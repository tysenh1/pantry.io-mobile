

import 'package:pantry_io_mobile/domain/models/local_unit.dart';

class GenericNameInfo {
  final int id;
  final String name;
  final Map<int, LocalUnit> units;
  final int pantryId;

  const GenericNameInfo({
    required this.id,
    required this.name,
    required this.units,
    required this.pantryId,
  });
}
