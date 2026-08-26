import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/core/utils/product_utils.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/domain/models/scanner_screen_form.dart';
import 'package:pantry_io_mobile/domain/services/scanner_screen_service.dart';
import 'package:pantry_io_mobile/ui/widgets/barcode/barcode_scanner_widget.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_button.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_card.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_dropdown.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_header.dart';
import 'package:pantry_io_mobile/ui/widgets/common/app_text_field.dart';
import 'package:pantry_io_mobile/domain/models/local_unit.dart';
import 'package:pantry_io_mobile/ui/widgets/tutorial/tutorial_spotlight_card.dart';
import 'package:provider/provider.dart';
import 'package:pantry_io_mobile/core/utils/string_utils.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class ScannerScreen extends StatefulWidget {
  final bool isTutorial;
  final VoidCallback? onTutorialNext;
  const ScannerScreen({super.key, required this.isTutorial, this.onTutorialNext});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey _formKey = GlobalKey();
  final GlobalKey _genericNameKey = GlobalKey();
  final GlobalKey _unitKey = GlobalKey();
  final GlobalKey _scannerButtonKey = GlobalKey();

  TutorialCoachMark? tutorialCoachMark;

  final ScannerScreenFormModel _formModel = ScannerScreenFormModel();

  bool _isProductLoading = false;
  List<GenericNameInfo> _dropdownItems = [];
  List<GenericNameInfo> _genericNames = [];
  bool _showGenericNamesReset = false;
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
      if (widget.isTutorial) {
        _availableUnits = <int, LocalUnit>{1: LocalUnit(id: 1, name: 'name', value: 1)};
        _formModel.selectedUnitId = null;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showTutorial();
        });
      }
    }
  }

  void _showTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.black,
      opacityShadow: 0.75,
      hideSkip: false,
      alignSkip: Alignment.topRight,
      pulseEnable: false,
      focusAnimationDuration: const Duration(milliseconds: 500),
      unFocusAnimationDuration: const Duration(milliseconds: 500),
      onFinish: () {
        widget.onTutorialNext?.call();
      },
      onSkip: () {
        tutorialCoachMark?.finish();
        widget.onTutorialNext?.call();
        return true;
      },
    )..show(context: context);
  }

  List<TargetFocus> _createTargets() {
    return [
      TargetFocus(
        identify: 'item_form',
        keyTarget: _formKey,
        shape: ShapeLightFocus.RRect,
        paddingFocus: 24,
        radius: 16,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(
              bottom: 16
            ),
            padding: EdgeInsets.all(8),
            builder: (context, controller) {
              return TutorialSpotlightCard(
                  title: 'Build Your Pantry',
                  description: 'Welcome! This is where you add items to your digital inventory. When you scan a product, its basic details will automatically populate here.',
                currentStep: 1,
                totalSteps: 4,
                onNext: () => controller.next()
              );
            }
          )
        ]
      ),
      TargetFocus(
        identify: 'generic_name',
        keyTarget: _genericNameKey,
        shape: ShapeLightFocus.RRect,
        radius: 16,
        paddingFocus: 24,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
            customPosition: CustomTargetContentPosition(
              bottom: 16
            ),
            padding: EdgeInsets.all(8),
            builder: (context, controller) {
              return TutorialSpotlightCard(
                  title: 'Categorize Your Items',
                  description: 'Map your specific product (like "Heinz Ketchup") to a generic category ("Ketchup"). This is how the app knows what ingredients you actually have when looking up recipes later.',
                currentStep: 2,
                totalSteps: 4,
                onNext: () => controller.next()
              );
            }
          )
        ]
      ),
      TargetFocus(
          identify: 'unit',
          keyTarget: _unitKey,
          shape: ShapeLightFocus.RRect,
          radius: 16,
          paddingFocus: 24,
          contents: [
            TargetContent(
              align: ContentAlign.custom,
              customPosition: CustomTargetContentPosition(
                bottom: 16
              ),
              padding: EdgeInsets.all(8),
              builder: (context, controller) {
                return TutorialSpotlightCard(
                    title: 'Track Your Stock',
                    description: 'Set the size and unit of measurement. This allows the app to do the math for you and deduct the right amount when you cook a meal.',
                  currentStep: 3,
                  totalSteps: 4,
                  onNext: () => controller.next()
                );
              }
            )
          ]
      ),
      TargetFocus(
        identify: 'scanner_button',
        keyTarget: _scannerButtonKey,
        shape: ShapeLightFocus.RRect,
        radius: 16,
        paddingFocus: 24,
        contents: [
          TargetContent(
            align: ContentAlign.custom,
              customPosition: CustomTargetContentPosition(
                bottom: 16
              ),
            padding: EdgeInsets.all(8),
            builder: (context, controller) {
              return TutorialSpotlightCard(
                  title: 'Scan & Go',
                  description: 'The fastest way to stock your kitchen! Use your camera to scan a barcode, and we’ll look up the product and fill this form out for you.',
                currentStep: 4,
                totalSteps: 4,
                onNext: () => tutorialCoachMark?.finish()
              );
            }
          )
        ]
      )
    ];
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

      try {
        await ScannerScreenService().processLocalItem(localItem.$1, localItem.$2, db);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error inserting new pantry item."))
        );
        return;
      }

      setState(() {
        _isProductLoading = false;
        _showSuccessModal(localItem.$1.productName);
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
            final parsedUnits = fuzzyFindLocalUnit(filteredGenericNames.first.units.values.toList(), parseUnit(result));
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
            _showGenericNamesReset = true;
          } else {
            _formModel.selectedGenericId = null;
            _showGenericNamesReset = false;
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Parts of the product could not be retrieved. Please enter manually.'),
              ),
            );
          }
          _formModel.barcodeController.text = barcode;
          _formModel.nameController.text = productName.toLowerCase().toTitleCase();
          _formModel.unitSizeController.text = formatQuantity(quantity.toDouble());
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
      if (mounted) {
        _availableUnits = conversions;
        _formModel.selectedUnitId = _availableUnits.keys.first;
      }
    });
  }

  void _onSubmit() async {
    if (!_formModel.isValid()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Some fields are missing values.")),
      );
      return;
    }

    final genericName = _dropdownItems.firstWhere((item) => item.id == _formModel.selectedGenericId);
    final unit = genericName.units[_formModel.selectedUnitId!];
    final productCompanion = _formModel.getProductCompanion(unit!);

    final db = context.read<AppDatabase>();
    try {
      await ScannerScreenService().processNewItem(productCompanion!, unit, genericName.id, db);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error inserting new pantry item."))
      );
      return;
    }
    _formModel.reset();

    _showSuccessModal(productCompanion.productName.value);
  }

  void _showSuccessModal(String name) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success!'),
        content: Text("$name has been added!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<int>> _populateUnitDropdown() {
    if (_formModel.selectedGenericId != null) {
      return _availableUnits.values.map((unit) =>
        DropdownMenuItem<int>(
          value: unit.id,
          child: Text(unit.name.toTitleCase())
        )
      ).toList();
    } else if (widget.isTutorial) {
      return [DropdownMenuItem<int>(value: 1, child: Text('thing'))];
    } else {
      return [];
    }
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
              key: _scannerButtonKey,
            ),
            AppCard(
              title: 'Item Information',
              key: _formKey,
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
                    key: _genericNameKey
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    key: _unitKey,
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
                          // items: _formModel.selectedGenericId != null
                          //   ? _availableUnits.values.map((unit) =>
                          //     DropdownMenuItem<int>(
                          //       value: unit.id,
                          //       child: Text(unit.name.toTitleCase())
                          //     )
                          //   ).toList()
                          // : [],
                          items: _populateUnitDropdown(),
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
                  if (_showGenericNamesReset)
                      AppButton(
                        type: AppButtonType.secondary,
                        label: 'Reset Generic Names',
                        onPressed: () => setState(() {
                          _dropdownItems = _genericNames;
                          _formModel.selectedUnitId = null;
                          _formModel.selectedGenericId = null;
                          _showGenericNamesReset = false;
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