import 'package:flutter/material.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:pantry_io_mobile/core/utils/pantry_utils.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/daos/items_dao.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/domain/models/item_info.dart';
import 'package:pantry_io_mobile/ui/widgets/barcode/barcode_scanner_widget.dart';
import 'package:provider/provider.dart';

class PantryAddItemWidget extends StatefulWidget {
  const PantryAddItemWidget({super.key});

  @override
  State<PantryAddItemWidget> createState() => _PantryAddItemWidgetState();
}

class _PantryAddItemWidgetState extends State<PantryAddItemWidget> {
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _unitSizeController = TextEditingController();
  final TextEditingController _unitTypeController = TextEditingController();

  bool _showScanner = false;
  bool _isLoadingProduct = false;
  bool _isScanSuccessful = false;
  ItemInfo? itemInfo;

  Future<void> _fetchProductData(String barcode) async {
    setState(() {
      _showScanner = false;
      _isLoadingProduct = true;
    });

    final db = Provider.of<AppDatabase>(context, listen: false);

    final localItem = await db.itemsDao.getLocalItemByBarcode(barcode);

    if (localItem != null) {
      setState(() {
        itemInfo = ItemInfo(
          barcode: localItem.$1.barcode,
          productName: localItem.$1.productName,
          genericName: GenericNameInfo(id: localItem.$2.id, name: localItem.$2.name),
          unitSize: localItem.$1.unitSize.toDouble(),
          unitType: localItem.$1.unitType
        );
        _barcodeController.text = localItem.$1.barcode;
        _nameController.text = localItem.$1.productName;
        _unitSizeController.text = localItem.$1.unitSize.toString();
        _unitTypeController.text = localItem.$1.unitType;
      });
    }

    try {
      final ProductQueryConfiguration configuration = ProductQueryConfiguration(barcode,
        language: OpenFoodFactsLanguage.ENGLISH,
        fields: [
          ProductField.BARCODE,
          ProductField.GENERIC_NAME,
          ProductField.NAME,
          ProductField.QUANTITY
        ],
        version: ProductQueryVersion.v3
      );

      final result = await OpenFoodAPIClient.getProductV3(configuration);

      if ((result.status == ProductResultV3.statusSuccess || result.status == ProductResultV3.statusWarning) && result.product != null) {
        GenericNameInfo? genericName;
        if (result.product?.genericName != null && result.product?.genericName != '') {
          final localName = await db.genericNamesDao.getGenericNameByName(result.product?.genericName as String);

          if (localName != null) {
            genericName = GenericNameInfo(id: localName.id, name: localName.name);
          } else {
            genericName = null;
          }
        }

        String productName = result.product?.productName ?? '';
        double quantity = parseQuantity(result);
        String unit = parseUnit(result);
        setState(() {
          itemInfo = ItemInfo(
            barcode: barcode,
            productName: productName,
            genericName: genericName,
            unitSize: quantity,
            unitType: unit
          );
          _barcodeController.text = barcode;
          _nameController.text = productName;
          _unitSizeController.text = quantity.toString();
          _unitTypeController.text = unit;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product not found. Please enter manually.')),
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

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();
    return Scaffold(
      appBar: AppBar(title: const Text("Add Pantry Item")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SwitchListTile(
              title: const Text('Use Barcode Scanner'),
              subtitle: const Text('Scan an item to auto-fill details'),
              value: _showScanner,
              onChanged: (value) => setState(() => _showScanner = value),
            ),
            const SizedBox(height: 16),

            if (_showScanner)
              Container(
                height: 250,
                margin: const EdgeInsets.only(bottom: 24),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300, width: 2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: BarcodeScannerWidget(onBarcodeScanned: (barcode) => _fetchProductData(barcode))
              ),
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
            ElevatedButton(
              onPressed: () {
                debugPrint("SAVING THE STUFFFFF");
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Save to pantry", style: TextStyle(fontSize: 18)),
              )
            )
          ]
        )
      )
    );
  }


}
