import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/items_table.dart';
import 'package:pantry_io_mobile/data/database/tables/generic_names_table.dart';
import 'package:pantry_io_mobile/domain/models/item_info.dart';

part 'items_dao.g.dart';

@DriftAccessor(tables: [Items, GenericNames])
class ItemsDao extends DatabaseAccessor<AppDatabase> with _$ItemsDaoMixin {
  ItemsDao(AppDatabase db) : super(db);

  Future<(Item, GenericName)?> getLocalItemByBarcode(String barcode) async {
    final query = select(items).join([
      innerJoin(genericNames, items.genericNameId.equalsExp(genericNames.id)),
    ])..where(items.barcode.equals(barcode));

    final row = await query.getSingleOrNull();

    if (row != null) {
      final itemData = row.readTable(items);
      final genericData = row.readTable(genericNames);

      return (itemData, genericData);
    }

    return null;
  }

  Future<int> insertItem(ItemInfo item) async {
    return await into(items).insert(item.toCompanion());
  }
}