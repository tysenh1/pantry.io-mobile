import 'package:drift/drift.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/tables/products_table.dart';
import 'package:pantry_io_mobile/data/database/tables/generic_names_table.dart';
import 'package:pantry_io_mobile/data/database/tables/ingredient_conversions_table.dart';
import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
import 'package:pantry_io_mobile/data/database/tables/pantry_table.dart';
import 'package:pantry_io_mobile/domain/models/local_unit.dart';

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

      final Map<int, LocalUnit> units = {-1: LocalUnit(id: -1, name: pantryData.unit, value: 1.0)};

      for (final row in rows) {
        final conversionData = row.readTable(ingredientConversions);
        units[conversionData.id] = LocalUnit(id: conversionData.id, name: conversionData.unit, value: conversionData.gramWeight);
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

  Future<void> insertProduct(ProductsCompanion product) async {
    return transaction(() async {
      final existingItem = await (products.select()..where((p) => p.barcode.equals(product.barcode.value))).getSingleOrNull();
      if (existingItem != null) return;
      await into(products).insert(product);
    });
  }
}