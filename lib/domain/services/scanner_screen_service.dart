import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/domain/models/local_unit.dart';

class ScannerScreenService {

  Future<void> processLocalItem(Product product, GenericNameInfo genericName, AppDatabase db) async {

    final pantryItem = await db.pantryDao.getPantryItemById(genericName.pantryId);
    final unit = genericName.units.values.firstWhere((u) => u.name == product.unitType);
    await db.pantryDao.updatePantry(
      pantryItem,
      product.unitSize * unit.value,
      pantryItem.id.value
    );
  }

  Future<void> processNewItem(ProductsCompanion product, LocalUnit unit, int genericNameId, AppDatabase db) async {
    await db.transaction(() async {
      final pantryItem = await db.pantryDao.getPantryFromGenericNameId(genericNameId);
      await db.productsDao.insertProduct(product);
      await db.pantryDao.updatePantryByGenericId(
        pantryItem,
        product.unitSize.value * unit.value
      );
    });
  }
}