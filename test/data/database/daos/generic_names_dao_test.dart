import 'package:drift/drift.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pantry_io_mobile/data/database/app_database.dart';
import 'package:pantry_io_mobile/data/database/daos/generic_names_dao.dart';
import 'package:pantry_io_mobile/data/db_seed_data.dart';

void main() {
  late AppDatabase db;
  late GenericNamesDao dao;

  setUp(() async {
    db = AppDatabase.memory();
    dao = GenericNamesDao(db);
  });

  tearDown(() async {
    await db.close();
  });

  group('GenericNamesDao Simple Queries', () {
    test('getGenericNameByName is case-insensitive and returns correct item', () async {
      await db.into(db.genericNames).insert(
        const GenericNamesCompanion(name: Value('butter'), primaryUnit: Value('g')),
      );

      final result = await dao.getGenericNameByName('BUTTER');

      expect(result != null, isTrue);
      expect(result!.name, 'butter');
    });

    test('getGenericNameByName returns null if not found', () async {
      final result = await dao.getGenericNameByName('ghost pepper');

      expect(result == null, isTrue);
    });
  });

  group('getAllGenericNameInfo (The Complex Join)', () {
    // test('successfully joins and groups pantry and conversion data', () async {
    //   final results = await dao.getAllGenericNameInfo();
    //
    //   expect(results.length, 1, reason: 'Should group everything under one GenericNameInfo');
    //
    //   final honeyInfo = results.first;
    //   expect(honeyInfo.name, 'honey');
    //   expect(honeyInfo.pantryId, pantryId);
    //
    //   expect(honeyInfo.units.length, 3);
    //
    //   expect(honeyInfo.units[-1]?.name, 'g');
    //   expect(honeyInfo.units[-1]?.value, 1.0);
    //
    //   expect(honeyInfo.units[conversionId1]?.name, 'tbsp');
    //   expect(honeyInfo.units[conversionId1]?.value, 21.0);
    //
    //   expect(honeyInfo.units[conversionId2]?.name, 'cup');
    //   expect(honeyInfo.units[conversionId2]?.value, 340.0);
    // });
  });
}