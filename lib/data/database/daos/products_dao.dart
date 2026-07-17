import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/products_table.dart';
import 'package:pantry_io_mobile/data/database/tables/generic_names_table.dart';
import 'package:pantry_io_mobile/domain/models/item_info.dart';

part 'products_dao.g.dart';

@DriftAccessor(tables: [Products, GenericNames])
class ProductsDao extends DatabaseAccessor<AppDatabase> with _$ProductsDaoMixin {
  ProductsDao(AppDatabase db) : super(db);

  Future<(Product, GenericName)?> getLocalItemByBarcode(String barcode) async {
    final query = select(products).join([
      innerJoin(genericNames, products.genericNameId.equalsExp(genericNames.id)),
    ])..where(products.barcode.equals(barcode));

    final row = await query.getSingleOrNull();

    if (row != null) {
      final productData = row.readTable(products);
      final genericData = row.readTable(genericNames);

      return (productData, genericData);
    }

    return null;
  }

  // Future<int> insertProduct(ItemInfo item) async {
  //   return await into(product).insert(item.toCompanion());
  // }
}