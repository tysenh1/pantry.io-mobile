import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/core/utils/product_utils.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/daos/products_dao.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/domain/models/product_info.dart';
import 'package:pantry_io_mobile/ui/widgets/barcode/barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

class PantryAddItemWidget extends StatefulWidget {
  const PantryAddItemWidget({super.key});

  @override
  State<PantryAddItemWidget> createState() => _PantryAddItemWidgetState();
}

class _PantryAddItemWidgetState extends State<PantryAddItemWidget> {
  @override
  void initState() {
    super.initState();
    _loadGenericNames();
  }

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

  @override
  void dispose() {
    _barcodeController.dispose();
    _nameController.dispose();
    _unitSizeController.dispose();
    _unitTypeController.dispose();
    super.dispose();
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

  // void createItem(ItemInfo item) async {
  //   if (
  //     _nameController.text == ''
  //     || _unitSizeController.text == ''
  //     || _unitTypeController.text == ''
  //     || _selectedGenericId == null
  //   ) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Make sure all required fields have information before submitting');
  //       )
  //     );
  //     return;
  //   }
  //   final db = Provider.of<AppDatabase>(context, listen: false);
  //
  //   if (_barcodeController.text == '') {
  //     await db.pantryDao.in
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Pantry Item")),
      body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() => _openScannerModal());
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Enable barcode scanner",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                if (_isLoadingProduct)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: LinearProgressIndicator(),
                  ),
                TextField(
                  controller: _barcodeController,
                  decoration: const InputDecoration(
                    labelText: 'Barcode',
                    border: OutlineInputBorder(),
                  ),
                  readOnly: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Product Name',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Generic Name',
                    border: OutlineInputBorder(),
                  ),
                  initialValue: _selectedGenericId,
                  items: _dropdownItems.map((info) {
                    return DropdownMenuItem<int>(
                      value: info.id,
                      child: Text(info.name),
                    );
                  }).toList(),
                  onChanged: (newId) {
                    setState(() => _selectedGenericId = newId);
                  },
                  isExpanded: true,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _unitSizeController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _unitTypeController,
                  decoration: const InputDecoration(
                    labelText: 'Unit',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 32),
                if (_showGenericNamesReset) ...[
                  ElevatedButton(
                    onPressed: () {
                      setState(() => _dropdownItems = _allGenericNames);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "Reset generic names",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                ElevatedButton(
                  onPressed: () {
                    debugPrint("SAVING THE STUFFFFF");
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Save to pantry",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
    );
  }
}
