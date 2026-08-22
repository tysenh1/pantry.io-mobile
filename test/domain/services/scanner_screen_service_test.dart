// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:pantry_io_mobile/data/database/app_database.dart';
// import 'package:pantry_io_mobile/data/database/daos/pantry_dao.dart';
// import 'package:pantry_io_mobile/data/database/daos/products_dao.dart';
// import 'package:pantry_io_mobile/domain/models/generic_name_info.dart';
// import 'package:pantry_io_mobile/domain/models/local_unit.dart';
// import 'package:pantry_io_mobile/domain/services/scanner_screen_service.dart';
//
// class MockAppDatabase extends Mock implements AppDatabase {}
// class MockPantryDao extends Mock implements PantryDao {}
// class MockProductsDao extends Mock implements ProductsDao {}
//
// class MockProduct extends Mock implements Product {}
// class MockGenericNameInfo extends Mock implements GenericNameInfo {}
// class MockPantryCompanion extends Mock implements PantryCompanion {}
// class MockProductsCompanion extends Mock implements ProductsCompanion {}
// class MockLocalUnit extends Mock implements LocalUnit {}
//
// class FakePantryItem extends Fake implements PantryCompanion {}
// class FakeProductsCompanion extends Fake implements ProductsCompanion {}
// class _MockDynamicWrapper extends Mock {}
//
// Future<void> _fakeTransactionCallback() async {}
//
// class MockDriftValue<T> {
//   final T value;
//   MockDriftValue(this.value);
// }
//
// void main() {
//   setUpAll(() {
//     registerFallbackValue(FakePantryItem());
//     registerFallbackValue(FakeProductsCompanion());
//     registerFallbackValue(_fakeTransactionCallback);
//   });
//
//   group('ScannerScreenService', () {
//     late ScannerScreenService service;
//     late MockAppDatabase mockDb;
//     late MockPantryDao mockPantryDao;
//     late MockProductsDao mockProductsDao;
//
//     setUp(() {
//       service = ScannerScreenService();
//       mockDb = MockAppDatabase();
//       mockPantryDao = MockPantryDao();
//       mockProductsDao = MockProductsDao();
//
//       when(() => mockDb.pantryDao).thenReturn(mockPantryDao);
//       when(() => mockDb.productsDao).thenReturn(mockProductsDao);
//
//       when(() => mockDb.transaction(any())).thenAnswer((invocation) async {
//         final callback = invocation.positionalArguments[0];
//         return await callback();
//       });
//     });
//
//     test('processLocalItem', () async {
//       final mockProduct = MockProduct();
//       when(() => mockProduct.unitType).thenReturn('kg');
//       when(() => mockProduct.unitSize).thenReturn(2.5);
//
//       final mockUnit = MockLocalUnit();
//       when(() => mockUnit.name).thenReturn('kg');
//       when(() => mockUnit.value).thenReturn(1000.0);
//
//       final mockGenericName = MockGenericNameInfo();
//       when(() => mockGenericName.pantryId).thenReturn(42);
//       when(() => mockGenericName.units).thenReturn({1: mockUnit});
//
//       // final mockIdWrapper = _MockDynamicWrapper();
//       final mockIdValue = MockDriftValue(99);
//       when(() => mock).thenReturn(99);
//
//       final mockPantryItem = MockPantryCompanion();
//       when(() => mockPantryItem.id).thenReturn(mockIdWrapper as dynamic);
//
//       when(() => mockPantryDao.getPantryItemById(42))
//           .thenAnswer((_) async => mockPantryItem);
//       when(() => mockPantryDao.updatePantry(any(), any(), any()))
//           .thenAnswer((_) async {});
//
//       await service.processLocalItem(mockProduct, mockGenericName, mockDb);
//
//       verify(() => mockPantryDao.updatePantry(mockPantryItem, 2500.0, 99)).called(1);
//     });
//
//     test('processNewItem', () async {
//       final mockValueWrapper = _MockDynamicWrapper();
//       when(() => mockValueWrapper.value).thenReturn(3.0);
//
//       final mockProductCompanion = MockProductsCompanion();
//       when(() => mockProductCompanion.unitSize).thenReturn(mockValueWrapper as dynamic);
//
//       final mockUnit = MockLocalUnit();
//       when(() => mockUnit.value).thenReturn(500.0);
//
//       final mockPantryItem = MockPantryCompanion();
//
//       when(() => mockPantryDao.getPantryFromGenericNameId(10))
//           .thenAnswer((_) async => mockPantryItem);
//       when(() => mockProductsDao.insertProduct(any()))
//           .thenAnswer((_) async => 1);
//       when(() => mockPantryDao.updatePantryByGenericId(any(), any()))
//           .thenAnswer((_) async {});
//
//       await service.processNewItem(mockProductCompanion, mockUnit, 10, mockDb);
//
//       verify(() => mockProductsDao.insertProduct(mockProductCompanion)).called(1);
//       verify(() => mockPantryDao.updatePantryByGenericId(mockPantryItem, 1500.0)).called(1);
//     });
//   });
// }