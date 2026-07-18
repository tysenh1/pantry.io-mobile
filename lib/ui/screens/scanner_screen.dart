import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/core/utils/product_utils.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/domain/models/product_info.dart';
import 'package:pantry_io_mobile/ui/widgets/barcode/barcode_scanner_widget.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_dropdown.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:provider/provider.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _unitSizeController = TextEditingController();
  final TextEditingController _unitTypeController = TextEditingController();

  bool _isLoadingProduct = false;
  ProductInfo? productInfo;
  List<GenericNameInfo> _dropdownItems = [];
  List<GenericNameInfo> _allGenericNames = [];
  int? _selectedGenericId;
  bool _showGenericNamesReset = false;

  @override
  void initState() {
    super.initState();
    _loadGenericNames();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _loadGenericNames() async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final allGenericNames = await db.genericNamesDao.getAllGenericNameInfo();

    if (mounted) {
      setState(() {
        _allGenericNames = allGenericNames;
        _dropdownItems = allGenericNames;
      });
    }
  }

  Future<void> _fetchProductData(String barcode) async {
    setState(() {
      _isLoadingProduct = true;
    });

    final db = Provider.of<AppDatabase>(context, listen: false);

    final localItem = await db.productsDao.getLocalItemByBarcode(barcode);

    if (localItem != null) {
      setState(() {
        productInfo = ProductInfo(
          barcode: localItem.$1.barcode,
          productName: localItem.$1.productName,
          genericName: GenericNameInfo(
            id: localItem.$2.id,
            name: localItem.$2.name,
          ),
          unitSize: localItem.$1.unitSize.toDouble(),
          unitType: localItem.$1.unitType,
        );
        _barcodeController.text = localItem.$1.barcode;
        _nameController.text = localItem.$1.productName;
        _unitSizeController.text = localItem.$1.unitSize.toString();
        _unitTypeController.text = localItem.$1.unitType;
      });

      return;
    }

    try {
      final ProductQueryConfiguration configuration = ProductQueryConfiguration(
        barcode,
        language: OpenFoodFactsLanguage.ENGLISH,
        fields: [
          ProductField.BARCODE,
          ProductField.GENERIC_NAME,
          ProductField.NAME,
          ProductField.QUANTITY,
          ProductField.CATEGORIES,
          ProductField.CATEGORIES_TAGS,
        ],
        version: ProductQueryVersion.v3,
      );

      final result = await OpenFoodAPIClient.getProductV3(configuration);

      if ((result.status == ProductResultV3.statusSuccess ||
          result.status == ProductResultV3.statusWarning) &&
          result.product != null) {
        final genericNameMatches = findGenericMatch(
          result.product?.genericName,
          result.product?.productName,
          result.product?.categoriesTags,
          result.product?.categories,
          _allGenericNames,
        );

        final filteredGenericNames = genericNameMatches
            .take(5)
            .map((result) => result.item)
            .toList();
        String productName = result.product?.productName ?? '';
        double quantity = parseQuantity(result);
        String unit = parseUnit(result);
        setState(() {


          if (filteredGenericNames.isNotEmpty) {
            _selectedGenericId = filteredGenericNames.first.id;
            _dropdownItems = filteredGenericNames;
            _showGenericNamesReset = true;
          } else {
            _selectedGenericId = null;
            _showGenericNamesReset = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product not found. Please enter manually.'),
              ),
            );
          }
          _barcodeController.text = barcode;
          _nameController.text = productName;
          _unitSizeController.text = quantity.toString();
          _unitTypeController.text = unit;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product not found. Please enter manually.'),
          ),
        );
      }
    } catch (e) {
      debugPrint(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network error looking up barcode')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoadingProduct = false);
      }
    }
  }

  void _openScannerModal() {
    showDialog(
        context: context,
        barrierDismissible: true,
        barrierColor: Colors.black.withValues(alpha: 0.6),
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              elevation: 16,
              child: LayoutBuilder(
                  builder: (context, constraints) {
                    final dynamicHeight = MediaQuery.of(context).size.height * 0.50;

                    return Container(
                        width: double.infinity,
                        height: dynamicHeight,
                        padding: const EdgeInsets.all(0.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: BarcodeScannerWidget(
                                onBarcodeScanned: (barcode) {
                                  _fetchProductData(barcode);
                                  Navigator.of(context).pop();
                                }
                            )
                        )
                    );
                  }
              )
          );

        }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: 'Add Pantry Item'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 20,
          children: [
            AppButton(
              label: 'Open Barcode Scanner',
              onPressed: _openScannerModal,
              size: AppButtonSize.large,
              type: AppButtonType.secondary,
            ),
            AppCard(
              title: 'Item Information',
              child: Column(
                spacing: 16,
                children: [
                  AppTextField(
                    placeholder: 'Barcode',
                  ),
                  AppTextField(
                    placeholder: 'Product Name',
                  ),
                  AppDropdown(
                    items: _allGenericNames.asMap().entries.map((entry) {
                      int index = entry.key;
                      var data = entry.value;
                      return DropdownMenuItem<int>(
                        value: index,
                        child: Text(data.name)
                      );
                    }).toList(),
                    placeholder: 'Generic Name',
                    onChanged: (_) {},
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppTextField(placeholder: 'Quantity', keyboardType: TextInputType.numberWithOptions(decimal: true))
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: AppTextField(placeholder: 'Unit')
                      ),
                    ]
                  )
                ],
              )
            ),
            AppButton(
              label: 'Add Pantry Item',
              onPressed: () {},
            )
          ]
        )
      )
    );
  }
}