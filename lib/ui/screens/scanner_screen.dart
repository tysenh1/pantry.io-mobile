import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/core/utils/product_utils.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/domain/models/ingredient_input.dart';
import 'package:pantry_io_mobile/domain/models/product_info.dart';
import 'package:pantry_io_mobile/domain/models/scanner_item.dart';
import 'package:pantry_io_mobile/domain/models/scanner_screen_form.dart';
import 'package:pantry_io_mobile/domain/services/scanner_screen_service.dart';
import 'package:pantry_io_mobile/ui/widgets/barcode/barcode_scanner_widget.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_dropdown.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:pantry_io_mobile/domain/models/local_unit.dart';
import 'package:provider/provider.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final ScannerScreenFormModel _formModel = ScannerScreenFormModel();

  bool _isProductLoading = false;
  List<GenericNameInfo> _dropdownItems = [];
  List<GenericNameInfo> _genericNames = [];
  // bool _showGenericNamesReset = false;
  Map<int, LocalUnit> _availableUnits = {};

  @override
  void initState() {
    super.initState();
    _loadGenericNames();
  }

  @override
  void dispose() {
    super.dispose();
    _formModel.dispose();
  }

  Future<void> _loadGenericNames() async {
    final db = Provider.of<AppDatabase>(context, listen: false);
    final allGenericNames = await db.genericNamesDao.getAllGenericNameInfo();

    if (mounted) {
      setState(() {
        _genericNames = allGenericNames;
        _dropdownItems = allGenericNames;
      });
    }
  }

  Future<void> _fetchProductData(String barcode) async {
    setState(() {
      _isProductLoading = true;
      _dropdownItems = _genericNames;
    });

    final db = Provider.of<AppDatabase>(context, listen: false);

    final localItem = await db.productsDao.getLocalItemByBarcode(barcode);

    if (localItem != null) {
      final db = Provider.of<AppDatabase>(context, listen: false);
      // setState(() {
      //   _formModel.barcodeController.text = localItem.$1.barcode;
      //   _formModel.nameController.text = localItem.$1.productName;
      //   _formModel.unitSizeController.text = localItem.$1.unitSize.toString();
      //   _formModel.selectedGenericId = localItem.$1.genericNameId;
      // });
      // final unit = LocalUnit(id: 0, name: 'g', value: 1.0);
      // final pantryCompanion = _formModel.getPantryCompanion(unit);
      final pantryCompanion = await db.pantryDao.getPantryFromGenericNameId(localItem.$1.genericNameId);

      try {
        ScannerScreenService().processLocalItem(localItem.$1, localItem.$2, db);
        // final scannerItem = ScannerItem(product: pantryCompanion, ingredientUnit: LocalUnit(id: 0, name: pantryCompanion.unit.value, value: 0));
        // await db.pantryDao.upsertPantry(scannerItem);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error inserting new pantry item."))
        );
        return;
      }

      setState(() {
        _isProductLoading = false;
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
          _genericNames,
        );

        final filteredGenericNames = genericNameMatches
            .take(5)
            .map((result) => result.item)
            .toList();
        String productName = result.product?.productName ?? '';
        double quantity = parseQuantity(result);
        setState(() {

          if (filteredGenericNames.isNotEmpty) {
            final parsedUnits = fuzzyFindLocalUnit(result, filteredGenericNames.first.units.values.toList(), parseUnit(result));
            if (parsedUnits.isNotEmpty) {
              _formModel.selectedUnitId = parsedUnits.first.item.id;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Unit could not be parsed, enter in grams/ml if packaging unit is not available.'))
              );
            }
            _formModel.selectedGenericId = filteredGenericNames.first.id;
            _availableUnits = filteredGenericNames.first.units;
            _formModel.selectedUnitId = _availableUnits.keys.first;
            _dropdownItems = filteredGenericNames;
            // _showGenericNamesReset = true;
          } else {
            _formModel.selectedGenericId = null;
            // _showGenericNamesReset = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Product not found. Please enter manually.'),
              ),
            );
          }
          _formModel.barcodeController.text = barcode;
          _formModel.nameController.text = productName;
          _formModel.unitSizeController.text = quantity.toString();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product not found. Please enter manually.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Network error looking up barcode')),
      );
    } finally {
      if (mounted) {
        setState(() => _isProductLoading = false);
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
                                },
                              isProductLoading: _isProductLoading
                            )
                        )
                    );
                  }
              )
          );

        }
    );
  }

  void _onGenericNameChanged(int? newId) async {
    if (newId == null) return;

    final selectedName = _genericNames.firstWhere((name) => name.id == newId);

    _formModel.selectedGenericId = newId;

    final db = context.read<AppDatabase>();
    final conversions = await db.ingredientConversionsDao.getAvailableUnitConversions(selectedName.id);

    setState(() {
      _availableUnits = conversions;
      _formModel.selectedUnitId = _availableUnits.keys.first;
    });
  }

  void _onSubmit() async {
    if (!_formModel.isValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Some fields are missing values.")),
      );
      return;
    }

    // final genericName = _dropdownItems[_formModel.selectedGenericId!];
    final genericName = _dropdownItems.firstWhere((item) => item.id == _formModel.selectedGenericId);
    final unit = genericName.units[_formModel.selectedUnitId!];
    final productCompanion = _formModel.getProductCompanion(unit!);
    final pantryCompanion = _formModel.getPantryCompanion(unit);

    final db = context.read<AppDatabase>();
    try {
      // final scannerItem = ScannerItem(product: pantryCompanion!, ingredientUnit: unit);
      await db.productsDao.insertProduct(productCompanion!);
      // await db.pantryDao.upsertPantry(scannerItem);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error inserting new pantry item."))
      );
      return;
    }

    _showSuccessModal();
  }

  void _showSuccessModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success!'),
        content: Text("${_formModel.nameController.text} has been added!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
        ],
      ),
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
                    controller: _formModel.barcodeController
                  ),
                  AppTextField(
                    placeholder: 'Product Name',
                    controller: _formModel.nameController
                  ),
                  AppDropdown(
                    items: _dropdownItems.asMap().entries.map((entry) {
                      int id = entry.value.id;
                      var data = entry.value;
                      return DropdownMenuItem<int>(
                        value: id,
                        child: Text(data.name)
                      );
                    }).toList(),
                    value: _formModel.selectedGenericId,
                    placeholder: 'Generic Name',
                    onChanged: (int? newId) => _onGenericNameChanged(newId),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: AppTextField(
                            placeholder: 'Quantity',
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                          controller: _formModel.unitSizeController
                        )
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: AppDropdown<int>(
                          value: _formModel.selectedUnitId,
                          // items: _formModel.selectedGenericId && _availableUnits.values.map((unit) =>
                          //   DropdownMenuItem<int>(
                          //     value: unit.id,
                          //     child: Text(unit.name)
                          //   )
                          // ).toList(),
                          items: _formModel.selectedGenericId != null
                            ? _availableUnits.values.map((unit) =>
                              DropdownMenuItem<int>(
                                value: unit.id,
                                child: Text(unit.name)
                              )
                            ).toList()
                          : [],
                          onChanged: _availableUnits.isEmpty
                              ? null
                              : (int? newUnitId) {
                            setState(() {
                              _formModel.selectedUnitId = newUnitId;
                            });
                          },
                          placeholder: 'Unit',
                        ),
                      ),
                    ]
                  ),
                      AppButton(
                        type: AppButtonType.secondary,
                        label: 'Reset Generic Names',
                        onPressed: () => setState(() {
                          _dropdownItems = _genericNames;
                          _formModel.selectedUnitId = null;
                          _formModel.selectedGenericId = null;
                        }),
                      ),
                  AppButton(
                    type: AppButtonType.secondary,
                    label: 'Reset Form',
                    onPressed: () => setState(() {
                      _formModel.reset();
                    })
                  )
                ],
              )
            ),
            AppButton(
              label: 'Add Pantry Item',
              onPressed: _onSubmit,
            )
          ]
        )
      )
    );
  }
}