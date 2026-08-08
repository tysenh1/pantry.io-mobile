import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';

class ScannerScreenService {

  Future<void> processLocalItem(Product product, GenericNameInfo genericName, AppDatabase db) async {

    final pantryItem = await db.pantryDao.getPantryItemById(genericName.pantryId);
    final unit = genericName.units.values.firstWhere((u) => u.name == product.unitType);
    await db.pantryDao.updatePantry(
      genericName.id,
      pantryItem,
      product.unitSize * unit.value,
      pantryItem.id.value
    );
  }
}