import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/products_table.dart';
import 'package:pantry_io_mobile/data/database/tables/generic_names_table.dart';
import 'package:pantry_io_mobile/data/database/tables/ingredient_conversions_table.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/domain/models/product_info.dart';
import 'package:pantry_io_mobile/data/database/tables/pantry_table.dart';

part 'products_dao.g.dart';

@DriftAccessor(tables: [Products, GenericNames, IngredientConversions, Pantry])
class ProductsDao extends DatabaseAccessor<AppDatabase> with _$ProductsDaoMixin {
  ProductsDao(AppDatabase db) : super(db);

  Future<(Product, GenericNameInfo)?> getLocalItemByBarcode(String barcode) async {
    final query = select(products).join([
      innerJoin(genericNames, products.genericNameId.equalsExp(genericNames.id)),
      innerJoin(ingredientConversions, genericNames.id.equalsExp(ingredientConversions.genericNameId)),
      innerJoin(pantry, genericNames.id.equalsExp(pantry.genericNameId))
    ])..where(products.barcode.equals(barcode));

    final rows = await query.get();

    if (rows.isNotEmpty) {
      final productData = rows.first.readTable(products);
      final genericData = rows.first.readTable(genericNames);
      final pantryData = rows.first.readTable(pantry);

      final Set<String> units = {};

      for (final row in rows) {
        final conversionData = row.readTable(ingredientConversions);
        units.add(conversionData.unit);
      }

      GenericNameInfo name = GenericNameInfo(
        id: genericData.id,
        name: genericData.name,
        units: units,
        pantryId: pantryData.id
      );

      return (productData, name);
    }

    return null;
  }

  // Future<int> insertProduct(ItemInfo item) async {
  //   return await into(product).insert(item.toCompanion());
  // }
}