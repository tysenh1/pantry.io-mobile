// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $GenericNamesTable extends GenericNames
    with TableInfo<$GenericNamesTable, GenericName> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GenericNamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _primaryUnitMeta = const VerificationMeta(
    'primaryUnit',
  );
  @override
  late final GeneratedColumn<String> primaryUnit = GeneratedColumn<String>(
    'primary_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weightPerPieceMeta = const VerificationMeta(
    'weightPerPiece',
  );
  @override
  late final GeneratedColumn<double> weightPerPiece = GeneratedColumn<double>(
    'weight_per_piece',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, primaryUnit, weightPerPiece];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'generic_names';
  @override
  VerificationContext validateIntegrity(
    Insertable<GenericName> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('primary_unit')) {
      context.handle(
        _primaryUnitMeta,
        primaryUnit.isAcceptableOrUnknown(
          data['primary_unit']!,
          _primaryUnitMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_primaryUnitMeta);
    }
    if (data.containsKey('weight_per_piece')) {
      context.handle(
        _weightPerPieceMeta,
        weightPerPiece.isAcceptableOrUnknown(
          data['weight_per_piece']!,
          _weightPerPieceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weightPerPieceMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GenericName map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GenericName(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      primaryUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_unit'],
      )!,
      weightPerPiece: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_per_piece'],
      )!,
    );
  }

  @override
  $GenericNamesTable createAlias(String alias) {
    return $GenericNamesTable(attachedDatabase, alias);
  }
}

class GenericName extends DataClass implements Insertable<GenericName> {
  final int id;
  final String name;
  final String primaryUnit;
  final double weightPerPiece;
  const GenericName({
    required this.id,
    required this.name,
    required this.primaryUnit,
    required this.weightPerPiece,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['primary_unit'] = Variable<String>(primaryUnit);
    map['weight_per_piece'] = Variable<double>(weightPerPiece);
    return map;
  }

  GenericNamesCompanion toCompanion(bool nullToAbsent) {
    return GenericNamesCompanion(
      id: Value(id),
      name: Value(name),
      primaryUnit: Value(primaryUnit),
      weightPerPiece: Value(weightPerPiece),
    );
  }

  factory GenericName.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GenericName(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      primaryUnit: serializer.fromJson<String>(json['primaryUnit']),
      weightPerPiece: serializer.fromJson<double>(json['weightPerPiece']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'primaryUnit': serializer.toJson<String>(primaryUnit),
      'weightPerPiece': serializer.toJson<double>(weightPerPiece),
    };
  }

  GenericName copyWith({
    int? id,
    String? name,
    String? primaryUnit,
    double? weightPerPiece,
  }) => GenericName(
    id: id ?? this.id,
    name: name ?? this.name,
    primaryUnit: primaryUnit ?? this.primaryUnit,
    weightPerPiece: weightPerPiece ?? this.weightPerPiece,
  );
  GenericName copyWithCompanion(GenericNamesCompanion data) {
    return GenericName(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      primaryUnit: data.primaryUnit.present
          ? data.primaryUnit.value
          : this.primaryUnit,
      weightPerPiece: data.weightPerPiece.present
          ? data.weightPerPiece.value
          : this.weightPerPiece,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GenericName(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primaryUnit: $primaryUnit, ')
          ..write('weightPerPiece: $weightPerPiece')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, primaryUnit, weightPerPiece);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GenericName &&
          other.id == this.id &&
          other.name == this.name &&
          other.primaryUnit == this.primaryUnit &&
          other.weightPerPiece == this.weightPerPiece);
}

class GenericNamesCompanion extends UpdateCompanion<GenericName> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> primaryUnit;
  final Value<double> weightPerPiece;
  const GenericNamesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.primaryUnit = const Value.absent(),
    this.weightPerPiece = const Value.absent(),
  });
  GenericNamesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String primaryUnit,
    required double weightPerPiece,
  }) : name = Value(name),
       primaryUnit = Value(primaryUnit),
       weightPerPiece = Value(weightPerPiece);
  static Insertable<GenericName> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? primaryUnit,
    Expression<double>? weightPerPiece,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (primaryUnit != null) 'primary_unit': primaryUnit,
      if (weightPerPiece != null) 'weight_per_piece': weightPerPiece,
    });
  }

  GenericNamesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? primaryUnit,
    Value<double>? weightPerPiece,
  }) {
    return GenericNamesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      primaryUnit: primaryUnit ?? this.primaryUnit,
      weightPerPiece: weightPerPiece ?? this.weightPerPiece,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (primaryUnit.present) {
      map['primary_unit'] = Variable<String>(primaryUnit.value);
    }
    if (weightPerPiece.present) {
      map['weight_per_piece'] = Variable<double>(weightPerPiece.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenericNamesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primaryUnit: $primaryUnit, ')
          ..write('weightPerPiece: $weightPerPiece')
          ..write(')'))
        .toString();
  }
}

class $AllergensTable extends Allergens
    with TableInfo<$AllergensTable, Allergen> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AllergensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'allergens';
  @override
  VerificationContext validateIntegrity(
    Insertable<Allergen> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Allergen map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Allergen(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $AllergensTable createAlias(String alias) {
    return $AllergensTable(attachedDatabase, alias);
  }
}

class Allergen extends DataClass implements Insertable<Allergen> {
  final int id;
  final String name;
  const Allergen({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  AllergensCompanion toCompanion(bool nullToAbsent) {
    return AllergensCompanion(id: Value(id), name: Value(name));
  }

  factory Allergen.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Allergen(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Allergen copyWith({int? id, String? name}) =>
      Allergen(id: id ?? this.id, name: name ?? this.name);
  Allergen copyWithCompanion(AllergensCompanion data) {
    return Allergen(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Allergen(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Allergen && other.id == this.id && other.name == this.name);
}

class AllergensCompanion extends UpdateCompanion<Allergen> {
  final Value<int> id;
  final Value<String> name;
  const AllergensCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  AllergensCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Allergen> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  AllergensCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return AllergensCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AllergensCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $ItemsTable extends Items with TableInfo<$ItemsTable, Item> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _productNameMeta = const VerificationMeta(
    'productName',
  );
  @override
  late final GeneratedColumn<String> productName = GeneratedColumn<String>(
    'product_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genericNameIdMeta = const VerificationMeta(
    'genericNameId',
  );
  @override
  late final GeneratedColumn<int> genericNameId = GeneratedColumn<int>(
    'generic_name_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES generic_names (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _unitSizeMeta = const VerificationMeta(
    'unitSize',
  );
  @override
  late final GeneratedColumn<int> unitSize = GeneratedColumn<int>(
    'unit_size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitTypeMeta = const VerificationMeta(
    'unitType',
  );
  @override
  late final GeneratedColumn<String> unitType = GeneratedColumn<String>(
    'unit_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    barcode,
    productName,
    genericNameId,
    unitSize,
    unitType,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items';
  @override
  VerificationContext validateIntegrity(
    Insertable<Item> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('product_name')) {
      context.handle(
        _productNameMeta,
        productName.isAcceptableOrUnknown(
          data['product_name']!,
          _productNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_productNameMeta);
    }
    if (data.containsKey('generic_name_id')) {
      context.handle(
        _genericNameIdMeta,
        genericNameId.isAcceptableOrUnknown(
          data['generic_name_id']!,
          _genericNameIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_genericNameIdMeta);
    }
    if (data.containsKey('unit_size')) {
      context.handle(
        _unitSizeMeta,
        unitSize.isAcceptableOrUnknown(data['unit_size']!, _unitSizeMeta),
      );
    } else if (isInserting) {
      context.missing(_unitSizeMeta);
    }
    if (data.containsKey('unit_type')) {
      context.handle(
        _unitTypeMeta,
        unitType.isAcceptableOrUnknown(data['unit_type']!, _unitTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_unitTypeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  Item map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Item(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      )!,
      productName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_name'],
      )!,
      genericNameId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generic_name_id'],
      )!,
      unitSize: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_size'],
      )!,
      unitType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_type'],
      )!,
    );
  }

  @override
  $ItemsTable createAlias(String alias) {
    return $ItemsTable(attachedDatabase, alias);
  }
}

class Item extends DataClass implements Insertable<Item> {
  final int id;
  final String barcode;
  final String productName;
  final int genericNameId;
  final int unitSize;
  final String unitType;
  const Item({
    required this.id,
    required this.barcode,
    required this.productName,
    required this.genericNameId,
    required this.unitSize,
    required this.unitType,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['barcode'] = Variable<String>(barcode);
    map['product_name'] = Variable<String>(productName);
    map['generic_name_id'] = Variable<int>(genericNameId);
    map['unit_size'] = Variable<int>(unitSize);
    map['unit_type'] = Variable<String>(unitType);
    return map;
  }

  ItemsCompanion toCompanion(bool nullToAbsent) {
    return ItemsCompanion(
      id: Value(id),
      barcode: Value(barcode),
      productName: Value(productName),
      genericNameId: Value(genericNameId),
      unitSize: Value(unitSize),
      unitType: Value(unitType),
    );
  }

  factory Item.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Item(
      id: serializer.fromJson<int>(json['id']),
      barcode: serializer.fromJson<String>(json['barcode']),
      productName: serializer.fromJson<String>(json['productName']),
      genericNameId: serializer.fromJson<int>(json['genericNameId']),
      unitSize: serializer.fromJson<int>(json['unitSize']),
      unitType: serializer.fromJson<String>(json['unitType']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'barcode': serializer.toJson<String>(barcode),
      'productName': serializer.toJson<String>(productName),
      'genericNameId': serializer.toJson<int>(genericNameId),
      'unitSize': serializer.toJson<int>(unitSize),
      'unitType': serializer.toJson<String>(unitType),
    };
  }

  Item copyWith({
    int? id,
    String? barcode,
    String? productName,
    int? genericNameId,
    int? unitSize,
    String? unitType,
  }) => Item(
    id: id ?? this.id,
    barcode: barcode ?? this.barcode,
    productName: productName ?? this.productName,
    genericNameId: genericNameId ?? this.genericNameId,
    unitSize: unitSize ?? this.unitSize,
    unitType: unitType ?? this.unitType,
  );
  Item copyWithCompanion(ItemsCompanion data) {
    return Item(
      id: data.id.present ? data.id.value : this.id,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      productName: data.productName.present
          ? data.productName.value
          : this.productName,
      genericNameId: data.genericNameId.present
          ? data.genericNameId.value
          : this.genericNameId,
      unitSize: data.unitSize.present ? data.unitSize.value : this.unitSize,
      unitType: data.unitType.present ? data.unitType.value : this.unitType,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Item(')
          ..write('id: $id, ')
          ..write('barcode: $barcode, ')
          ..write('productName: $productName, ')
          ..write('genericNameId: $genericNameId, ')
          ..write('unitSize: $unitSize, ')
          ..write('unitType: $unitType')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, barcode, productName, genericNameId, unitSize, unitType);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Item &&
          other.id == this.id &&
          other.barcode == this.barcode &&
          other.productName == this.productName &&
          other.genericNameId == this.genericNameId &&
          other.unitSize == this.unitSize &&
          other.unitType == this.unitType);
}

class ItemsCompanion extends UpdateCompanion<Item> {
  final Value<int> id;
  final Value<String> barcode;
  final Value<String> productName;
  final Value<int> genericNameId;
  final Value<int> unitSize;
  final Value<String> unitType;
  final Value<int> rowid;
  const ItemsCompanion({
    this.id = const Value.absent(),
    this.barcode = const Value.absent(),
    this.productName = const Value.absent(),
    this.genericNameId = const Value.absent(),
    this.unitSize = const Value.absent(),
    this.unitType = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemsCompanion.insert({
    required int id,
    required String barcode,
    required String productName,
    required int genericNameId,
    required int unitSize,
    required String unitType,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       barcode = Value(barcode),
       productName = Value(productName),
       genericNameId = Value(genericNameId),
       unitSize = Value(unitSize),
       unitType = Value(unitType);
  static Insertable<Item> custom({
    Expression<int>? id,
    Expression<String>? barcode,
    Expression<String>? productName,
    Expression<int>? genericNameId,
    Expression<int>? unitSize,
    Expression<String>? unitType,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (barcode != null) 'barcode': barcode,
      if (productName != null) 'product_name': productName,
      if (genericNameId != null) 'generic_name_id': genericNameId,
      if (unitSize != null) 'unit_size': unitSize,
      if (unitType != null) 'unit_type': unitType,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? barcode,
    Value<String>? productName,
    Value<int>? genericNameId,
    Value<int>? unitSize,
    Value<String>? unitType,
    Value<int>? rowid,
  }) {
    return ItemsCompanion(
      id: id ?? this.id,
      barcode: barcode ?? this.barcode,
      productName: productName ?? this.productName,
      genericNameId: genericNameId ?? this.genericNameId,
      unitSize: unitSize ?? this.unitSize,
      unitType: unitType ?? this.unitType,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (productName.present) {
      map['product_name'] = Variable<String>(productName.value);
    }
    if (genericNameId.present) {
      map['generic_name_id'] = Variable<int>(genericNameId.value);
    }
    if (unitSize.present) {
      map['unit_size'] = Variable<int>(unitSize.value);
    }
    if (unitType.present) {
      map['unit_type'] = Variable<String>(unitType.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsCompanion(')
          ..write('id: $id, ')
          ..write('barcode: $barcode, ')
          ..write('productName: $productName, ')
          ..write('genericNameId: $genericNameId, ')
          ..write('unitSize: $unitSize, ')
          ..write('unitType: $unitType, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ItemAllergensTable extends ItemAllergens
    with TableInfo<$ItemAllergensTable, ItemAllergen> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemAllergensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemIdMeta = const VerificationMeta('itemId');
  @override
  late final GeneratedColumn<int> itemId = GeneratedColumn<int>(
    'item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _allergenIdMeta = const VerificationMeta(
    'allergenId',
  );
  @override
  late final GeneratedColumn<int> allergenId = GeneratedColumn<int>(
    'allergen_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES allergens (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [itemId, allergenId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'item_allergens';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItemAllergen> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item_id')) {
      context.handle(
        _itemIdMeta,
        itemId.isAcceptableOrUnknown(data['item_id']!, _itemIdMeta),
      );
    } else if (isInserting) {
      context.missing(_itemIdMeta);
    }
    if (data.containsKey('allergen_id')) {
      context.handle(
        _allergenIdMeta,
        allergenId.isAcceptableOrUnknown(data['allergen_id']!, _allergenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_allergenIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {itemId, allergenId};
  @override
  ItemAllergen map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemAllergen(
      itemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item_id'],
      )!,
      allergenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}allergen_id'],
      )!,
    );
  }

  @override
  $ItemAllergensTable createAlias(String alias) {
    return $ItemAllergensTable(attachedDatabase, alias);
  }
}

class ItemAllergen extends DataClass implements Insertable<ItemAllergen> {
  final int itemId;
  final int allergenId;
  const ItemAllergen({required this.itemId, required this.allergenId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item_id'] = Variable<int>(itemId);
    map['allergen_id'] = Variable<int>(allergenId);
    return map;
  }

  ItemAllergensCompanion toCompanion(bool nullToAbsent) {
    return ItemAllergensCompanion(
      itemId: Value(itemId),
      allergenId: Value(allergenId),
    );
  }

  factory ItemAllergen.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemAllergen(
      itemId: serializer.fromJson<int>(json['itemId']),
      allergenId: serializer.fromJson<int>(json['allergenId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'itemId': serializer.toJson<int>(itemId),
      'allergenId': serializer.toJson<int>(allergenId),
    };
  }

  ItemAllergen copyWith({int? itemId, int? allergenId}) => ItemAllergen(
    itemId: itemId ?? this.itemId,
    allergenId: allergenId ?? this.allergenId,
  );
  ItemAllergen copyWithCompanion(ItemAllergensCompanion data) {
    return ItemAllergen(
      itemId: data.itemId.present ? data.itemId.value : this.itemId,
      allergenId: data.allergenId.present
          ? data.allergenId.value
          : this.allergenId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemAllergen(')
          ..write('itemId: $itemId, ')
          ..write('allergenId: $allergenId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(itemId, allergenId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemAllergen &&
          other.itemId == this.itemId &&
          other.allergenId == this.allergenId);
}

class ItemAllergensCompanion extends UpdateCompanion<ItemAllergen> {
  final Value<int> itemId;
  final Value<int> allergenId;
  final Value<int> rowid;
  const ItemAllergensCompanion({
    this.itemId = const Value.absent(),
    this.allergenId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ItemAllergensCompanion.insert({
    required int itemId,
    required int allergenId,
    this.rowid = const Value.absent(),
  }) : itemId = Value(itemId),
       allergenId = Value(allergenId);
  static Insertable<ItemAllergen> custom({
    Expression<int>? itemId,
    Expression<int>? allergenId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (itemId != null) 'item_id': itemId,
      if (allergenId != null) 'allergen_id': allergenId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ItemAllergensCompanion copyWith({
    Value<int>? itemId,
    Value<int>? allergenId,
    Value<int>? rowid,
  }) {
    return ItemAllergensCompanion(
      itemId: itemId ?? this.itemId,
      allergenId: allergenId ?? this.allergenId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (itemId.present) {
      map['item_id'] = Variable<int>(itemId.value);
    }
    if (allergenId.present) {
      map['allergen_id'] = Variable<int>(allergenId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemAllergensCompanion(')
          ..write('itemId: $itemId, ')
          ..write('allergenId: $allergenId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PantryTable extends Pantry with TableInfo<$PantryTable, PantryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PantryTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _genericNameIdMeta = const VerificationMeta(
    'genericNameId',
  );
  @override
  late final GeneratedColumn<int> genericNameId = GeneratedColumn<int>(
    'generic_name_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES generic_names (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isStapleMeta = const VerificationMeta(
    'isStaple',
  );
  @override
  late final GeneratedColumn<bool> isStaple = GeneratedColumn<bool>(
    'is_staple',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_staple" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [id, genericNameId, quantity, isStaple];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pantry';
  @override
  VerificationContext validateIntegrity(
    Insertable<PantryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('generic_name_id')) {
      context.handle(
        _genericNameIdMeta,
        genericNameId.isAcceptableOrUnknown(
          data['generic_name_id']!,
          _genericNameIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_genericNameIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    }
    if (data.containsKey('is_staple')) {
      context.handle(
        _isStapleMeta,
        isStaple.isAcceptableOrUnknown(data['is_staple']!, _isStapleMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PantryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PantryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      genericNameId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}generic_name_id'],
      )!,
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      isStaple: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_staple'],
      )!,
    );
  }

  @override
  $PantryTable createAlias(String alias) {
    return $PantryTable(attachedDatabase, alias);
  }
}

class PantryData extends DataClass implements Insertable<PantryData> {
  final int id;
  final int genericNameId;
  final int quantity;
  final bool isStaple;
  const PantryData({
    required this.id,
    required this.genericNameId,
    required this.quantity,
    required this.isStaple,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['generic_name_id'] = Variable<int>(genericNameId);
    map['quantity'] = Variable<int>(quantity);
    map['is_staple'] = Variable<bool>(isStaple);
    return map;
  }

  PantryCompanion toCompanion(bool nullToAbsent) {
    return PantryCompanion(
      id: Value(id),
      genericNameId: Value(genericNameId),
      quantity: Value(quantity),
      isStaple: Value(isStaple),
    );
  }

  factory PantryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PantryData(
      id: serializer.fromJson<int>(json['id']),
      genericNameId: serializer.fromJson<int>(json['genericNameId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      isStaple: serializer.fromJson<bool>(json['isStaple']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'genericNameId': serializer.toJson<int>(genericNameId),
      'quantity': serializer.toJson<int>(quantity),
      'isStaple': serializer.toJson<bool>(isStaple),
    };
  }

  PantryData copyWith({
    int? id,
    int? genericNameId,
    int? quantity,
    bool? isStaple,
  }) => PantryData(
    id: id ?? this.id,
    genericNameId: genericNameId ?? this.genericNameId,
    quantity: quantity ?? this.quantity,
    isStaple: isStaple ?? this.isStaple,
  );
  PantryData copyWithCompanion(PantryCompanion data) {
    return PantryData(
      id: data.id.present ? data.id.value : this.id,
      genericNameId: data.genericNameId.present
          ? data.genericNameId.value
          : this.genericNameId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      isStaple: data.isStaple.present ? data.isStaple.value : this.isStaple,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PantryData(')
          ..write('id: $id, ')
          ..write('genericNameId: $genericNameId, ')
          ..write('quantity: $quantity, ')
          ..write('isStaple: $isStaple')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, genericNameId, quantity, isStaple);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PantryData &&
          other.id == this.id &&
          other.genericNameId == this.genericNameId &&
          other.quantity == this.quantity &&
          other.isStaple == this.isStaple);
}

class PantryCompanion extends UpdateCompanion<PantryData> {
  final Value<int> id;
  final Value<int> genericNameId;
  final Value<int> quantity;
  final Value<bool> isStaple;
  const PantryCompanion({
    this.id = const Value.absent(),
    this.genericNameId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.isStaple = const Value.absent(),
  });
  PantryCompanion.insert({
    this.id = const Value.absent(),
    required int genericNameId,
    this.quantity = const Value.absent(),
    this.isStaple = const Value.absent(),
  }) : genericNameId = Value(genericNameId);
  static Insertable<PantryData> custom({
    Expression<int>? id,
    Expression<int>? genericNameId,
    Expression<int>? quantity,
    Expression<bool>? isStaple,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (genericNameId != null) 'generic_name_id': genericNameId,
      if (quantity != null) 'quantity': quantity,
      if (isStaple != null) 'is_staple': isStaple,
    });
  }

  PantryCompanion copyWith({
    Value<int>? id,
    Value<int>? genericNameId,
    Value<int>? quantity,
    Value<bool>? isStaple,
  }) {
    return PantryCompanion(
      id: id ?? this.id,
      genericNameId: genericNameId ?? this.genericNameId,
      quantity: quantity ?? this.quantity,
      isStaple: isStaple ?? this.isStaple,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (genericNameId.present) {
      map['generic_name_id'] = Variable<int>(genericNameId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (isStaple.present) {
      map['is_staple'] = Variable<bool>(isStaple.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PantryCompanion(')
          ..write('id: $id, ')
          ..write('genericNameId: $genericNameId, ')
          ..write('quantity: $quantity, ')
          ..write('isStaple: $isStaple')
          ..write(')'))
        .toString();
  }
}

class $RecipesTable extends Recipes with TableInfo<$RecipesTable, Recipe> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _instructionsMeta = const VerificationMeta(
    'instructions',
  );
  @override
  late final GeneratedColumn<String> instructions = GeneratedColumn<String>(
    'instructions',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
    'tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, instructions, tags];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Recipe> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('instructions')) {
      context.handle(
        _instructionsMeta,
        instructions.isAcceptableOrUnknown(
          data['instructions']!,
          _instructionsMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_instructionsMeta);
    }
    if (data.containsKey('tags')) {
      context.handle(
        _tagsMeta,
        tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta),
      );
    } else if (isInserting) {
      context.missing(_tagsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recipe map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recipe(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      instructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}instructions'],
      )!,
      tags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tags'],
      )!,
    );
  }

  @override
  $RecipesTable createAlias(String alias) {
    return $RecipesTable(attachedDatabase, alias);
  }
}

class Recipe extends DataClass implements Insertable<Recipe> {
  final int id;
  final String name;
  final String instructions;
  final String tags;
  const Recipe({
    required this.id,
    required this.name,
    required this.instructions,
    required this.tags,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['instructions'] = Variable<String>(instructions);
    map['tags'] = Variable<String>(tags);
    return map;
  }

  RecipesCompanion toCompanion(bool nullToAbsent) {
    return RecipesCompanion(
      id: Value(id),
      name: Value(name),
      instructions: Value(instructions),
      tags: Value(tags),
    );
  }

  factory Recipe.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recipe(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      instructions: serializer.fromJson<String>(json['instructions']),
      tags: serializer.fromJson<String>(json['tags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'instructions': serializer.toJson<String>(instructions),
      'tags': serializer.toJson<String>(tags),
    };
  }

  Recipe copyWith({
    int? id,
    String? name,
    String? instructions,
    String? tags,
  }) => Recipe(
    id: id ?? this.id,
    name: name ?? this.name,
    instructions: instructions ?? this.instructions,
    tags: tags ?? this.tags,
  );
  Recipe copyWithCompanion(RecipesCompanion data) {
    return Recipe(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      instructions: data.instructions.present
          ? data.instructions.value
          : this.instructions,
      tags: data.tags.present ? data.tags.value : this.tags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Recipe(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('instructions: $instructions, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, instructions, tags);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recipe &&
          other.id == this.id &&
          other.name == this.name &&
          other.instructions == this.instructions &&
          other.tags == this.tags);
}

class RecipesCompanion extends UpdateCompanion<Recipe> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> instructions;
  final Value<String> tags;
  const RecipesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.instructions = const Value.absent(),
    this.tags = const Value.absent(),
  });
  RecipesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String instructions,
    required String tags,
  }) : name = Value(name),
       instructions = Value(instructions),
       tags = Value(tags);
  static Insertable<Recipe> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? instructions,
    Expression<String>? tags,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (instructions != null) 'instructions': instructions,
      if (tags != null) 'tags': tags,
    });
  }

  RecipesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? instructions,
    Value<String>? tags,
  }) {
    return RecipesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      instructions: instructions ?? this.instructions,
      tags: tags ?? this.tags,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (instructions.present) {
      map['instructions'] = Variable<String>(instructions.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('instructions: $instructions, ')
          ..write('tags: $tags')
          ..write(')'))
        .toString();
  }
}

class $RecipeIngredientsTable extends RecipeIngredients
    with TableInfo<$RecipeIngredientsTable, RecipeIngredient> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeIngredientsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<int> recipeId = GeneratedColumn<int>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pantryIdMeta = const VerificationMeta(
    'pantryId',
  );
  @override
  late final GeneratedColumn<int> pantryId = GeneratedColumn<int>(
    'pantry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pantry (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _quantityNeededMeta = const VerificationMeta(
    'quantityNeeded',
  );
  @override
  late final GeneratedColumn<double> quantityNeeded = GeneratedColumn<double>(
    'quantity_needed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    recipeId,
    pantryId,
    quantityNeeded,
    unit,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeIngredient> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('pantry_id')) {
      context.handle(
        _pantryIdMeta,
        pantryId.isAcceptableOrUnknown(data['pantry_id']!, _pantryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pantryIdMeta);
    }
    if (data.containsKey('quantity_needed')) {
      context.handle(
        _quantityNeededMeta,
        quantityNeeded.isAcceptableOrUnknown(
          data['quantity_needed']!,
          _quantityNeededMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantityNeededMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {recipeId, pantryId};
  @override
  RecipeIngredient map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeIngredient(
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recipe_id'],
      )!,
      pantryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pantry_id'],
      )!,
      quantityNeeded: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}quantity_needed'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
    );
  }

  @override
  $RecipeIngredientsTable createAlias(String alias) {
    return $RecipeIngredientsTable(attachedDatabase, alias);
  }
}

class RecipeIngredient extends DataClass
    implements Insertable<RecipeIngredient> {
  final int recipeId;
  final int pantryId;
  final double quantityNeeded;
  final String unit;
  const RecipeIngredient({
    required this.recipeId,
    required this.pantryId,
    required this.quantityNeeded,
    required this.unit,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['recipe_id'] = Variable<int>(recipeId);
    map['pantry_id'] = Variable<int>(pantryId);
    map['quantity_needed'] = Variable<double>(quantityNeeded);
    map['unit'] = Variable<String>(unit);
    return map;
  }

  RecipeIngredientsCompanion toCompanion(bool nullToAbsent) {
    return RecipeIngredientsCompanion(
      recipeId: Value(recipeId),
      pantryId: Value(pantryId),
      quantityNeeded: Value(quantityNeeded),
      unit: Value(unit),
    );
  }

  factory RecipeIngredient.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeIngredient(
      recipeId: serializer.fromJson<int>(json['recipeId']),
      pantryId: serializer.fromJson<int>(json['pantryId']),
      quantityNeeded: serializer.fromJson<double>(json['quantityNeeded']),
      unit: serializer.fromJson<String>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'recipeId': serializer.toJson<int>(recipeId),
      'pantryId': serializer.toJson<int>(pantryId),
      'quantityNeeded': serializer.toJson<double>(quantityNeeded),
      'unit': serializer.toJson<String>(unit),
    };
  }

  RecipeIngredient copyWith({
    int? recipeId,
    int? pantryId,
    double? quantityNeeded,
    String? unit,
  }) => RecipeIngredient(
    recipeId: recipeId ?? this.recipeId,
    pantryId: pantryId ?? this.pantryId,
    quantityNeeded: quantityNeeded ?? this.quantityNeeded,
    unit: unit ?? this.unit,
  );
  RecipeIngredient copyWithCompanion(RecipeIngredientsCompanion data) {
    return RecipeIngredient(
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      pantryId: data.pantryId.present ? data.pantryId.value : this.pantryId,
      quantityNeeded: data.quantityNeeded.present
          ? data.quantityNeeded.value
          : this.quantityNeeded,
      unit: data.unit.present ? data.unit.value : this.unit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredient(')
          ..write('recipeId: $recipeId, ')
          ..write('pantryId: $pantryId, ')
          ..write('quantityNeeded: $quantityNeeded, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(recipeId, pantryId, quantityNeeded, unit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeIngredient &&
          other.recipeId == this.recipeId &&
          other.pantryId == this.pantryId &&
          other.quantityNeeded == this.quantityNeeded &&
          other.unit == this.unit);
}

class RecipeIngredientsCompanion extends UpdateCompanion<RecipeIngredient> {
  final Value<int> recipeId;
  final Value<int> pantryId;
  final Value<double> quantityNeeded;
  final Value<String> unit;
  final Value<int> rowid;
  const RecipeIngredientsCompanion({
    this.recipeId = const Value.absent(),
    this.pantryId = const Value.absent(),
    this.quantityNeeded = const Value.absent(),
    this.unit = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipeIngredientsCompanion.insert({
    required int recipeId,
    required int pantryId,
    required double quantityNeeded,
    required String unit,
    this.rowid = const Value.absent(),
  }) : recipeId = Value(recipeId),
       pantryId = Value(pantryId),
       quantityNeeded = Value(quantityNeeded),
       unit = Value(unit);
  static Insertable<RecipeIngredient> custom({
    Expression<int>? recipeId,
    Expression<int>? pantryId,
    Expression<double>? quantityNeeded,
    Expression<String>? unit,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (recipeId != null) 'recipe_id': recipeId,
      if (pantryId != null) 'pantry_id': pantryId,
      if (quantityNeeded != null) 'quantity_needed': quantityNeeded,
      if (unit != null) 'unit': unit,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipeIngredientsCompanion copyWith({
    Value<int>? recipeId,
    Value<int>? pantryId,
    Value<double>? quantityNeeded,
    Value<String>? unit,
    Value<int>? rowid,
  }) {
    return RecipeIngredientsCompanion(
      recipeId: recipeId ?? this.recipeId,
      pantryId: pantryId ?? this.pantryId,
      quantityNeeded: quantityNeeded ?? this.quantityNeeded,
      unit: unit ?? this.unit,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (recipeId.present) {
      map['recipe_id'] = Variable<int>(recipeId.value);
    }
    if (pantryId.present) {
      map['pantry_id'] = Variable<int>(pantryId.value);
    }
    if (quantityNeeded.present) {
      map['quantity_needed'] = Variable<double>(quantityNeeded.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeIngredientsCompanion(')
          ..write('recipeId: $recipeId, ')
          ..write('pantryId: $pantryId, ')
          ..write('quantityNeeded: $quantityNeeded, ')
          ..write('unit: $unit, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GenericNamesTable genericNames = $GenericNamesTable(this);
  late final $AllergensTable allergens = $AllergensTable(this);
  late final $ItemsTable items = $ItemsTable(this);
  late final $ItemAllergensTable itemAllergens = $ItemAllergensTable(this);
  late final $PantryTable pantry = $PantryTable(this);
  late final $RecipesTable recipes = $RecipesTable(this);
  late final $RecipeIngredientsTable recipeIngredients =
      $RecipeIngredientsTable(this);
  late final PantryDao pantryDao = PantryDao(this as AppDatabase);
  late final RecipeDao recipeDao = RecipeDao(this as AppDatabase);
  late final ItemsDao itemsDao = ItemsDao(this as AppDatabase);
  late final GenericNamesDao genericNamesDao = GenericNamesDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    genericNames,
    allergens,
    items,
    itemAllergens,
    pantry,
    recipes,
    recipeIngredients,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'generic_names',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('item_allergens', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'allergens',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('item_allergens', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'generic_names',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pantry', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_ingredients', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'pantry',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recipe_ingredients', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$GenericNamesTableCreateCompanionBuilder =
    GenericNamesCompanion Function({
      Value<int> id,
      required String name,
      required String primaryUnit,
      required double weightPerPiece,
    });
typedef $$GenericNamesTableUpdateCompanionBuilder =
    GenericNamesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> primaryUnit,
      Value<double> weightPerPiece,
    });

final class $$GenericNamesTableReferences
    extends BaseReferences<_$AppDatabase, $GenericNamesTable, GenericName> {
  $$GenericNamesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItemsTable, List<Item>> _itemsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.items,
    aliasName: $_aliasNameGenerator(db.genericNames.id, db.items.genericNameId),
  );

  $$ItemsTableProcessedTableManager get itemsRefs {
    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.genericNameId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PantryTable, List<PantryData>> _pantryRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.pantry,
    aliasName: $_aliasNameGenerator(
      db.genericNames.id,
      db.pantry.genericNameId,
    ),
  );

  $$PantryTableProcessedTableManager get pantryRefs {
    final manager = $$PantryTableTableManager(
      $_db,
      $_db.pantry,
    ).filter((f) => f.genericNameId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_pantryRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GenericNamesTableFilterComposer
    extends Composer<_$AppDatabase, $GenericNamesTable> {
  $$GenericNamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryUnit => $composableBuilder(
    column: $table.primaryUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightPerPiece => $composableBuilder(
    column: $table.weightPerPiece,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> itemsRefs(
    Expression<bool> Function($$ItemsTableFilterComposer f) f,
  ) {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.genericNameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pantryRefs(
    Expression<bool> Function($$PantryTableFilterComposer f) f,
  ) {
    final $$PantryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pantry,
      getReferencedColumn: (t) => t.genericNameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PantryTableFilterComposer(
            $db: $db,
            $table: $db.pantry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GenericNamesTableOrderingComposer
    extends Composer<_$AppDatabase, $GenericNamesTable> {
  $$GenericNamesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryUnit => $composableBuilder(
    column: $table.primaryUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightPerPiece => $composableBuilder(
    column: $table.weightPerPiece,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GenericNamesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GenericNamesTable> {
  $$GenericNamesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get primaryUnit => $composableBuilder(
    column: $table.primaryUnit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get weightPerPiece => $composableBuilder(
    column: $table.weightPerPiece,
    builder: (column) => column,
  );

  Expression<T> itemsRefs<T extends Object>(
    Expression<T> Function($$ItemsTableAnnotationComposer a) f,
  ) {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.genericNameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pantryRefs<T extends Object>(
    Expression<T> Function($$PantryTableAnnotationComposer a) f,
  ) {
    final $$PantryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pantry,
      getReferencedColumn: (t) => t.genericNameId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PantryTableAnnotationComposer(
            $db: $db,
            $table: $db.pantry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GenericNamesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GenericNamesTable,
          GenericName,
          $$GenericNamesTableFilterComposer,
          $$GenericNamesTableOrderingComposer,
          $$GenericNamesTableAnnotationComposer,
          $$GenericNamesTableCreateCompanionBuilder,
          $$GenericNamesTableUpdateCompanionBuilder,
          (GenericName, $$GenericNamesTableReferences),
          GenericName,
          PrefetchHooks Function({bool itemsRefs, bool pantryRefs})
        > {
  $$GenericNamesTableTableManager(_$AppDatabase db, $GenericNamesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GenericNamesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GenericNamesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GenericNamesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> primaryUnit = const Value.absent(),
                Value<double> weightPerPiece = const Value.absent(),
              }) => GenericNamesCompanion(
                id: id,
                name: name,
                primaryUnit: primaryUnit,
                weightPerPiece: weightPerPiece,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String primaryUnit,
                required double weightPerPiece,
              }) => GenericNamesCompanion.insert(
                id: id,
                name: name,
                primaryUnit: primaryUnit,
                weightPerPiece: weightPerPiece,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$GenericNamesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemsRefs = false, pantryRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (itemsRefs) db.items,
                if (pantryRefs) db.pantry,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemsRefs)
                    await $_getPrefetchedData<
                      GenericName,
                      $GenericNamesTable,
                      Item
                    >(
                      currentTable: table,
                      referencedTable: $$GenericNamesTableReferences
                          ._itemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GenericNamesTableReferences(
                            db,
                            table,
                            p0,
                          ).itemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.genericNameId == item.id,
                          ),
                      typedResults: items,
                    ),
                  if (pantryRefs)
                    await $_getPrefetchedData<
                      GenericName,
                      $GenericNamesTable,
                      PantryData
                    >(
                      currentTable: table,
                      referencedTable: $$GenericNamesTableReferences
                          ._pantryRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$GenericNamesTableReferences(
                            db,
                            table,
                            p0,
                          ).pantryRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.genericNameId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GenericNamesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GenericNamesTable,
      GenericName,
      $$GenericNamesTableFilterComposer,
      $$GenericNamesTableOrderingComposer,
      $$GenericNamesTableAnnotationComposer,
      $$GenericNamesTableCreateCompanionBuilder,
      $$GenericNamesTableUpdateCompanionBuilder,
      (GenericName, $$GenericNamesTableReferences),
      GenericName,
      PrefetchHooks Function({bool itemsRefs, bool pantryRefs})
    >;
typedef $$AllergensTableCreateCompanionBuilder =
    AllergensCompanion Function({Value<int> id, required String name});
typedef $$AllergensTableUpdateCompanionBuilder =
    AllergensCompanion Function({Value<int> id, Value<String> name});

final class $$AllergensTableReferences
    extends BaseReferences<_$AppDatabase, $AllergensTable, Allergen> {
  $$AllergensTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ItemAllergensTable, List<ItemAllergen>>
  _itemAllergensRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.itemAllergens,
    aliasName: $_aliasNameGenerator(
      db.allergens.id,
      db.itemAllergens.allergenId,
    ),
  );

  $$ItemAllergensTableProcessedTableManager get itemAllergensRefs {
    final manager = $$ItemAllergensTableTableManager(
      $_db,
      $_db.itemAllergens,
    ).filter((f) => f.allergenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemAllergensRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$AllergensTableFilterComposer
    extends Composer<_$AppDatabase, $AllergensTable> {
  $$AllergensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> itemAllergensRefs(
    Expression<bool> Function($$ItemAllergensTableFilterComposer f) f,
  ) {
    final $$ItemAllergensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemAllergens,
      getReferencedColumn: (t) => t.allergenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemAllergensTableFilterComposer(
            $db: $db,
            $table: $db.itemAllergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AllergensTableOrderingComposer
    extends Composer<_$AppDatabase, $AllergensTable> {
  $$AllergensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AllergensTableAnnotationComposer
    extends Composer<_$AppDatabase, $AllergensTable> {
  $$AllergensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> itemAllergensRefs<T extends Object>(
    Expression<T> Function($$ItemAllergensTableAnnotationComposer a) f,
  ) {
    final $$ItemAllergensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemAllergens,
      getReferencedColumn: (t) => t.allergenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemAllergensTableAnnotationComposer(
            $db: $db,
            $table: $db.itemAllergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$AllergensTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AllergensTable,
          Allergen,
          $$AllergensTableFilterComposer,
          $$AllergensTableOrderingComposer,
          $$AllergensTableAnnotationComposer,
          $$AllergensTableCreateCompanionBuilder,
          $$AllergensTableUpdateCompanionBuilder,
          (Allergen, $$AllergensTableReferences),
          Allergen,
          PrefetchHooks Function({bool itemAllergensRefs})
        > {
  $$AllergensTableTableManager(_$AppDatabase db, $AllergensTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AllergensTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AllergensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AllergensTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => AllergensCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  AllergensCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$AllergensTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemAllergensRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (itemAllergensRefs) db.itemAllergens,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (itemAllergensRefs)
                    await $_getPrefetchedData<
                      Allergen,
                      $AllergensTable,
                      ItemAllergen
                    >(
                      currentTable: table,
                      referencedTable: $$AllergensTableReferences
                          ._itemAllergensRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$AllergensTableReferences(
                            db,
                            table,
                            p0,
                          ).itemAllergensRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.allergenId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$AllergensTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AllergensTable,
      Allergen,
      $$AllergensTableFilterComposer,
      $$AllergensTableOrderingComposer,
      $$AllergensTableAnnotationComposer,
      $$AllergensTableCreateCompanionBuilder,
      $$AllergensTableUpdateCompanionBuilder,
      (Allergen, $$AllergensTableReferences),
      Allergen,
      PrefetchHooks Function({bool itemAllergensRefs})
    >;
typedef $$ItemsTableCreateCompanionBuilder =
    ItemsCompanion Function({
      required int id,
      required String barcode,
      required String productName,
      required int genericNameId,
      required int unitSize,
      required String unitType,
      Value<int> rowid,
    });
typedef $$ItemsTableUpdateCompanionBuilder =
    ItemsCompanion Function({
      Value<int> id,
      Value<String> barcode,
      Value<String> productName,
      Value<int> genericNameId,
      Value<int> unitSize,
      Value<String> unitType,
      Value<int> rowid,
    });

final class $$ItemsTableReferences
    extends BaseReferences<_$AppDatabase, $ItemsTable, Item> {
  $$ItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GenericNamesTable _genericNameIdTable(_$AppDatabase db) =>
      db.genericNames.createAlias(
        $_aliasNameGenerator(db.items.genericNameId, db.genericNames.id),
      );

  $$GenericNamesTableProcessedTableManager get genericNameId {
    final $_column = $_itemColumn<int>('generic_name_id')!;

    final manager = $$GenericNamesTableTableManager(
      $_db,
      $_db.genericNames,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_genericNameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ItemAllergensTable, List<ItemAllergen>>
  _itemAllergensRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.itemAllergens,
    aliasName: $_aliasNameGenerator(db.items.id, db.itemAllergens.itemId),
  );

  $$ItemAllergensTableProcessedTableManager get itemAllergensRefs {
    final manager = $$ItemAllergensTableTableManager(
      $_db,
      $_db.itemAllergens,
    ).filter((f) => f.itemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_itemAllergensRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ItemsTableFilterComposer extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitSize => $composableBuilder(
    column: $table.unitSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitType => $composableBuilder(
    column: $table.unitType,
    builder: (column) => ColumnFilters(column),
  );

  $$GenericNamesTableFilterComposer get genericNameId {
    final $$GenericNamesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.genericNameId,
      referencedTable: $db.genericNames,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenericNamesTableFilterComposer(
            $db: $db,
            $table: $db.genericNames,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> itemAllergensRefs(
    Expression<bool> Function($$ItemAllergensTableFilterComposer f) f,
  ) {
    final $$ItemAllergensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemAllergens,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemAllergensTableFilterComposer(
            $db: $db,
            $table: $db.itemAllergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitSize => $composableBuilder(
    column: $table.unitSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitType => $composableBuilder(
    column: $table.unitType,
    builder: (column) => ColumnOrderings(column),
  );

  $$GenericNamesTableOrderingComposer get genericNameId {
    final $$GenericNamesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.genericNameId,
      referencedTable: $db.genericNames,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenericNamesTableOrderingComposer(
            $db: $db,
            $table: $db.genericNames,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsTable> {
  $$ItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get productName => $composableBuilder(
    column: $table.productName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unitSize =>
      $composableBuilder(column: $table.unitSize, builder: (column) => column);

  GeneratedColumn<String> get unitType =>
      $composableBuilder(column: $table.unitType, builder: (column) => column);

  $$GenericNamesTableAnnotationComposer get genericNameId {
    final $$GenericNamesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.genericNameId,
      referencedTable: $db.genericNames,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenericNamesTableAnnotationComposer(
            $db: $db,
            $table: $db.genericNames,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> itemAllergensRefs<T extends Object>(
    Expression<T> Function($$ItemAllergensTableAnnotationComposer a) f,
  ) {
    final $$ItemAllergensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.itemAllergens,
      getReferencedColumn: (t) => t.itemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemAllergensTableAnnotationComposer(
            $db: $db,
            $table: $db.itemAllergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemsTable,
          Item,
          $$ItemsTableFilterComposer,
          $$ItemsTableOrderingComposer,
          $$ItemsTableAnnotationComposer,
          $$ItemsTableCreateCompanionBuilder,
          $$ItemsTableUpdateCompanionBuilder,
          (Item, $$ItemsTableReferences),
          Item,
          PrefetchHooks Function({bool genericNameId, bool itemAllergensRefs})
        > {
  $$ItemsTableTableManager(_$AppDatabase db, $ItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> barcode = const Value.absent(),
                Value<String> productName = const Value.absent(),
                Value<int> genericNameId = const Value.absent(),
                Value<int> unitSize = const Value.absent(),
                Value<String> unitType = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemsCompanion(
                id: id,
                barcode: barcode,
                productName: productName,
                genericNameId: genericNameId,
                unitSize: unitSize,
                unitType: unitType,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int id,
                required String barcode,
                required String productName,
                required int genericNameId,
                required int unitSize,
                required String unitType,
                Value<int> rowid = const Value.absent(),
              }) => ItemsCompanion.insert(
                id: id,
                barcode: barcode,
                productName: productName,
                genericNameId: genericNameId,
                unitSize: unitSize,
                unitType: unitType,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$ItemsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({genericNameId = false, itemAllergensRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (itemAllergensRefs) db.itemAllergens,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (genericNameId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.genericNameId,
                                    referencedTable: $$ItemsTableReferences
                                        ._genericNameIdTable(db),
                                    referencedColumn: $$ItemsTableReferences
                                        ._genericNameIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (itemAllergensRefs)
                        await $_getPrefetchedData<
                          Item,
                          $ItemsTable,
                          ItemAllergen
                        >(
                          currentTable: table,
                          referencedTable: $$ItemsTableReferences
                              ._itemAllergensRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).itemAllergensRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.itemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemsTable,
      Item,
      $$ItemsTableFilterComposer,
      $$ItemsTableOrderingComposer,
      $$ItemsTableAnnotationComposer,
      $$ItemsTableCreateCompanionBuilder,
      $$ItemsTableUpdateCompanionBuilder,
      (Item, $$ItemsTableReferences),
      Item,
      PrefetchHooks Function({bool genericNameId, bool itemAllergensRefs})
    >;
typedef $$ItemAllergensTableCreateCompanionBuilder =
    ItemAllergensCompanion Function({
      required int itemId,
      required int allergenId,
      Value<int> rowid,
    });
typedef $$ItemAllergensTableUpdateCompanionBuilder =
    ItemAllergensCompanion Function({
      Value<int> itemId,
      Value<int> allergenId,
      Value<int> rowid,
    });

final class $$ItemAllergensTableReferences
    extends BaseReferences<_$AppDatabase, $ItemAllergensTable, ItemAllergen> {
  $$ItemAllergensTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ItemsTable _itemIdTable(_$AppDatabase db) => db.items.createAlias(
    $_aliasNameGenerator(db.itemAllergens.itemId, db.items.id),
  );

  $$ItemsTableProcessedTableManager get itemId {
    final $_column = $_itemColumn<int>('item_id')!;

    final manager = $$ItemsTableTableManager(
      $_db,
      $_db.items,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $AllergensTable _allergenIdTable(_$AppDatabase db) =>
      db.allergens.createAlias(
        $_aliasNameGenerator(db.itemAllergens.allergenId, db.allergens.id),
      );

  $$AllergensTableProcessedTableManager get allergenId {
    final $_column = $_itemColumn<int>('allergen_id')!;

    final manager = $$AllergensTableTableManager(
      $_db,
      $_db.allergens,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_allergenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ItemAllergensTableFilterComposer
    extends Composer<_$AppDatabase, $ItemAllergensTable> {
  $$ItemAllergensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ItemsTableFilterComposer get itemId {
    final $$ItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableFilterComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergensTableFilterComposer get allergenId {
    final $$AllergensTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergenId,
      referencedTable: $db.allergens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergensTableFilterComposer(
            $db: $db,
            $table: $db.allergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemAllergensTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemAllergensTable> {
  $$ItemAllergensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ItemsTableOrderingComposer get itemId {
    final $$ItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableOrderingComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergensTableOrderingComposer get allergenId {
    final $$AllergensTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergenId,
      referencedTable: $db.allergens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergensTableOrderingComposer(
            $db: $db,
            $table: $db.allergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemAllergensTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemAllergensTable> {
  $$ItemAllergensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ItemsTableAnnotationComposer get itemId {
    final $$ItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.itemId,
      referencedTable: $db.items,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.items,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$AllergensTableAnnotationComposer get allergenId {
    final $$AllergensTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.allergenId,
      referencedTable: $db.allergens,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$AllergensTableAnnotationComposer(
            $db: $db,
            $table: $db.allergens,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemAllergensTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemAllergensTable,
          ItemAllergen,
          $$ItemAllergensTableFilterComposer,
          $$ItemAllergensTableOrderingComposer,
          $$ItemAllergensTableAnnotationComposer,
          $$ItemAllergensTableCreateCompanionBuilder,
          $$ItemAllergensTableUpdateCompanionBuilder,
          (ItemAllergen, $$ItemAllergensTableReferences),
          ItemAllergen,
          PrefetchHooks Function({bool itemId, bool allergenId})
        > {
  $$ItemAllergensTableTableManager(_$AppDatabase db, $ItemAllergensTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemAllergensTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ItemAllergensTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ItemAllergensTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> itemId = const Value.absent(),
                Value<int> allergenId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ItemAllergensCompanion(
                itemId: itemId,
                allergenId: allergenId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int itemId,
                required int allergenId,
                Value<int> rowid = const Value.absent(),
              }) => ItemAllergensCompanion.insert(
                itemId: itemId,
                allergenId: allergenId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ItemAllergensTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({itemId = false, allergenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (itemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.itemId,
                                referencedTable: $$ItemAllergensTableReferences
                                    ._itemIdTable(db),
                                referencedColumn: $$ItemAllergensTableReferences
                                    ._itemIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (allergenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.allergenId,
                                referencedTable: $$ItemAllergensTableReferences
                                    ._allergenIdTable(db),
                                referencedColumn: $$ItemAllergensTableReferences
                                    ._allergenIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ItemAllergensTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemAllergensTable,
      ItemAllergen,
      $$ItemAllergensTableFilterComposer,
      $$ItemAllergensTableOrderingComposer,
      $$ItemAllergensTableAnnotationComposer,
      $$ItemAllergensTableCreateCompanionBuilder,
      $$ItemAllergensTableUpdateCompanionBuilder,
      (ItemAllergen, $$ItemAllergensTableReferences),
      ItemAllergen,
      PrefetchHooks Function({bool itemId, bool allergenId})
    >;
typedef $$PantryTableCreateCompanionBuilder =
    PantryCompanion Function({
      Value<int> id,
      required int genericNameId,
      Value<int> quantity,
      Value<bool> isStaple,
    });
typedef $$PantryTableUpdateCompanionBuilder =
    PantryCompanion Function({
      Value<int> id,
      Value<int> genericNameId,
      Value<int> quantity,
      Value<bool> isStaple,
    });

final class $$PantryTableReferences
    extends BaseReferences<_$AppDatabase, $PantryTable, PantryData> {
  $$PantryTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GenericNamesTable _genericNameIdTable(_$AppDatabase db) =>
      db.genericNames.createAlias(
        $_aliasNameGenerator(db.pantry.genericNameId, db.genericNames.id),
      );

  $$GenericNamesTableProcessedTableManager get genericNameId {
    final $_column = $_itemColumn<int>('generic_name_id')!;

    final manager = $$GenericNamesTableTableManager(
      $_db,
      $_db.genericNames,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_genericNameIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$RecipeIngredientsTable, List<RecipeIngredient>>
  _recipeIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recipeIngredients,
        aliasName: $_aliasNameGenerator(
          db.pantry.id,
          db.recipeIngredients.pantryId,
        ),
      );

  $$RecipeIngredientsTableProcessedTableManager get recipeIngredientsRefs {
    final manager = $$RecipeIngredientsTableTableManager(
      $_db,
      $_db.recipeIngredients,
    ).filter((f) => f.pantryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recipeIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PantryTableFilterComposer
    extends Composer<_$AppDatabase, $PantryTable> {
  $$PantryTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStaple => $composableBuilder(
    column: $table.isStaple,
    builder: (column) => ColumnFilters(column),
  );

  $$GenericNamesTableFilterComposer get genericNameId {
    final $$GenericNamesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.genericNameId,
      referencedTable: $db.genericNames,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenericNamesTableFilterComposer(
            $db: $db,
            $table: $db.genericNames,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> recipeIngredientsRefs(
    Expression<bool> Function($$RecipeIngredientsTableFilterComposer f) f,
  ) {
    final $$RecipeIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredients,
      getReferencedColumn: (t) => t.pantryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.recipeIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PantryTableOrderingComposer
    extends Composer<_$AppDatabase, $PantryTable> {
  $$PantryTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStaple => $composableBuilder(
    column: $table.isStaple,
    builder: (column) => ColumnOrderings(column),
  );

  $$GenericNamesTableOrderingComposer get genericNameId {
    final $$GenericNamesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.genericNameId,
      referencedTable: $db.genericNames,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenericNamesTableOrderingComposer(
            $db: $db,
            $table: $db.genericNames,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PantryTableAnnotationComposer
    extends Composer<_$AppDatabase, $PantryTable> {
  $$PantryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<bool> get isStaple =>
      $composableBuilder(column: $table.isStaple, builder: (column) => column);

  $$GenericNamesTableAnnotationComposer get genericNameId {
    final $$GenericNamesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.genericNameId,
      referencedTable: $db.genericNames,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GenericNamesTableAnnotationComposer(
            $db: $db,
            $table: $db.genericNames,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> recipeIngredientsRefs<T extends Object>(
    Expression<T> Function($$RecipeIngredientsTableAnnotationComposer a) f,
  ) {
    final $$RecipeIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recipeIngredients,
          getReferencedColumn: (t) => t.pantryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecipeIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.recipeIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$PantryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PantryTable,
          PantryData,
          $$PantryTableFilterComposer,
          $$PantryTableOrderingComposer,
          $$PantryTableAnnotationComposer,
          $$PantryTableCreateCompanionBuilder,
          $$PantryTableUpdateCompanionBuilder,
          (PantryData, $$PantryTableReferences),
          PantryData,
          PrefetchHooks Function({
            bool genericNameId,
            bool recipeIngredientsRefs,
          })
        > {
  $$PantryTableTableManager(_$AppDatabase db, $PantryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PantryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PantryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PantryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> genericNameId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<bool> isStaple = const Value.absent(),
              }) => PantryCompanion(
                id: id,
                genericNameId: genericNameId,
                quantity: quantity,
                isStaple: isStaple,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int genericNameId,
                Value<int> quantity = const Value.absent(),
                Value<bool> isStaple = const Value.absent(),
              }) => PantryCompanion.insert(
                id: id,
                genericNameId: genericNameId,
                quantity: quantity,
                isStaple: isStaple,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PantryTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({genericNameId = false, recipeIngredientsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (recipeIngredientsRefs) db.recipeIngredients,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (genericNameId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.genericNameId,
                                    referencedTable: $$PantryTableReferences
                                        ._genericNameIdTable(db),
                                    referencedColumn: $$PantryTableReferences
                                        ._genericNameIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (recipeIngredientsRefs)
                        await $_getPrefetchedData<
                          PantryData,
                          $PantryTable,
                          RecipeIngredient
                        >(
                          currentTable: table,
                          referencedTable: $$PantryTableReferences
                              ._recipeIngredientsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PantryTableReferences(
                                db,
                                table,
                                p0,
                              ).recipeIngredientsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.pantryId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PantryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PantryTable,
      PantryData,
      $$PantryTableFilterComposer,
      $$PantryTableOrderingComposer,
      $$PantryTableAnnotationComposer,
      $$PantryTableCreateCompanionBuilder,
      $$PantryTableUpdateCompanionBuilder,
      (PantryData, $$PantryTableReferences),
      PantryData,
      PrefetchHooks Function({bool genericNameId, bool recipeIngredientsRefs})
    >;
typedef $$RecipesTableCreateCompanionBuilder =
    RecipesCompanion Function({
      Value<int> id,
      required String name,
      required String instructions,
      required String tags,
    });
typedef $$RecipesTableUpdateCompanionBuilder =
    RecipesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> instructions,
      Value<String> tags,
    });

final class $$RecipesTableReferences
    extends BaseReferences<_$AppDatabase, $RecipesTable, Recipe> {
  $$RecipesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RecipeIngredientsTable, List<RecipeIngredient>>
  _recipeIngredientsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.recipeIngredients,
        aliasName: $_aliasNameGenerator(
          db.recipes.id,
          db.recipeIngredients.recipeId,
        ),
      );

  $$RecipeIngredientsTableProcessedTableManager get recipeIngredientsRefs {
    final manager = $$RecipeIngredientsTableTableManager(
      $_db,
      $_db.recipeIngredients,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _recipeIngredientsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecipesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> recipeIngredientsRefs(
    Expression<bool> Function($$RecipeIngredientsTableFilterComposer f) f,
  ) {
    final $$RecipeIngredientsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.recipeIngredients,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeIngredientsTableFilterComposer(
            $db: $db,
            $table: $db.recipeIngredients,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tags => $composableBuilder(
    column: $table.tags,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipesTable> {
  $$RecipesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get instructions => $composableBuilder(
    column: $table.instructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  Expression<T> recipeIngredientsRefs<T extends Object>(
    Expression<T> Function($$RecipeIngredientsTableAnnotationComposer a) f,
  ) {
    final $$RecipeIngredientsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.recipeIngredients,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RecipeIngredientsTableAnnotationComposer(
                $db: $db,
                $table: $db.recipeIngredients,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RecipesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipesTable,
          Recipe,
          $$RecipesTableFilterComposer,
          $$RecipesTableOrderingComposer,
          $$RecipesTableAnnotationComposer,
          $$RecipesTableCreateCompanionBuilder,
          $$RecipesTableUpdateCompanionBuilder,
          (Recipe, $$RecipesTableReferences),
          Recipe,
          PrefetchHooks Function({bool recipeIngredientsRefs})
        > {
  $$RecipesTableTableManager(_$AppDatabase db, $RecipesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> instructions = const Value.absent(),
                Value<String> tags = const Value.absent(),
              }) => RecipesCompanion(
                id: id,
                name: name,
                instructions: instructions,
                tags: tags,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String instructions,
                required String tags,
              }) => RecipesCompanion.insert(
                id: id,
                name: name,
                instructions: instructions,
                tags: tags,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecipesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeIngredientsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (recipeIngredientsRefs) db.recipeIngredients,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (recipeIngredientsRefs)
                    await $_getPrefetchedData<
                      Recipe,
                      $RecipesTable,
                      RecipeIngredient
                    >(
                      currentTable: table,
                      referencedTable: $$RecipesTableReferences
                          ._recipeIngredientsRefsTable(db),
                      managerFromTypedResult: (p0) => $$RecipesTableReferences(
                        db,
                        table,
                        p0,
                      ).recipeIngredientsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.recipeId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RecipesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipesTable,
      Recipe,
      $$RecipesTableFilterComposer,
      $$RecipesTableOrderingComposer,
      $$RecipesTableAnnotationComposer,
      $$RecipesTableCreateCompanionBuilder,
      $$RecipesTableUpdateCompanionBuilder,
      (Recipe, $$RecipesTableReferences),
      Recipe,
      PrefetchHooks Function({bool recipeIngredientsRefs})
    >;
typedef $$RecipeIngredientsTableCreateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      required int recipeId,
      required int pantryId,
      required double quantityNeeded,
      required String unit,
      Value<int> rowid,
    });
typedef $$RecipeIngredientsTableUpdateCompanionBuilder =
    RecipeIngredientsCompanion Function({
      Value<int> recipeId,
      Value<int> pantryId,
      Value<double> quantityNeeded,
      Value<String> unit,
      Value<int> rowid,
    });

final class $$RecipeIngredientsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredient
        > {
  $$RecipeIngredientsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecipesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipes.createAlias(
        $_aliasNameGenerator(db.recipeIngredients.recipeId, db.recipes.id),
      );

  $$RecipesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<int>('recipe_id')!;

    final manager = $$RecipesTableTableManager(
      $_db,
      $_db.recipes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $PantryTable _pantryIdTable(_$AppDatabase db) => db.pantry.createAlias(
    $_aliasNameGenerator(db.recipeIngredients.pantryId, db.pantry.id),
  );

  $$PantryTableProcessedTableManager get pantryId {
    final $_column = $_itemColumn<int>('pantry_id')!;

    final manager = $$PantryTableTableManager(
      $_db,
      $_db.pantry,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pantryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RecipeIngredientsTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get quantityNeeded => $composableBuilder(
    column: $table.quantityNeeded,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipesTableFilterComposer get recipeId {
    final $$RecipesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableFilterComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PantryTableFilterComposer get pantryId {
    final $$PantryTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pantryId,
      referencedTable: $db.pantry,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PantryTableFilterComposer(
            $db: $db,
            $table: $db.pantry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get quantityNeeded => $composableBuilder(
    column: $table.quantityNeeded,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipesTableOrderingComposer get recipeId {
    final $$RecipesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableOrderingComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PantryTableOrderingComposer get pantryId {
    final $$PantryTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pantryId,
      referencedTable: $db.pantry,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PantryTableOrderingComposer(
            $db: $db,
            $table: $db.pantry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeIngredientsTable> {
  $$RecipeIngredientsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get quantityNeeded => $composableBuilder(
    column: $table.quantityNeeded,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  $$RecipesTableAnnotationComposer get recipeId {
    final $$RecipesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$PantryTableAnnotationComposer get pantryId {
    final $$PantryTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pantryId,
      referencedTable: $db.pantry,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PantryTableAnnotationComposer(
            $db: $db,
            $table: $db.pantry,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RecipeIngredientsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeIngredientsTable,
          RecipeIngredient,
          $$RecipeIngredientsTableFilterComposer,
          $$RecipeIngredientsTableOrderingComposer,
          $$RecipeIngredientsTableAnnotationComposer,
          $$RecipeIngredientsTableCreateCompanionBuilder,
          $$RecipeIngredientsTableUpdateCompanionBuilder,
          (RecipeIngredient, $$RecipeIngredientsTableReferences),
          RecipeIngredient,
          PrefetchHooks Function({bool recipeId, bool pantryId})
        > {
  $$RecipeIngredientsTableTableManager(
    _$AppDatabase db,
    $RecipeIngredientsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeIngredientsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeIngredientsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeIngredientsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> recipeId = const Value.absent(),
                Value<int> pantryId = const Value.absent(),
                Value<double> quantityNeeded = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipeIngredientsCompanion(
                recipeId: recipeId,
                pantryId: pantryId,
                quantityNeeded: quantityNeeded,
                unit: unit,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int recipeId,
                required int pantryId,
                required double quantityNeeded,
                required String unit,
                Value<int> rowid = const Value.absent(),
              }) => RecipeIngredientsCompanion.insert(
                recipeId: recipeId,
                pantryId: pantryId,
                quantityNeeded: quantityNeeded,
                unit: unit,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecipeIngredientsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false, pantryId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.recipeId,
                                referencedTable:
                                    $$RecipeIngredientsTableReferences
                                        ._recipeIdTable(db),
                                referencedColumn:
                                    $$RecipeIngredientsTableReferences
                                        ._recipeIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (pantryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.pantryId,
                                referencedTable:
                                    $$RecipeIngredientsTableReferences
                                        ._pantryIdTable(db),
                                referencedColumn:
                                    $$RecipeIngredientsTableReferences
                                        ._pantryIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RecipeIngredientsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeIngredientsTable,
      RecipeIngredient,
      $$RecipeIngredientsTableFilterComposer,
      $$RecipeIngredientsTableOrderingComposer,
      $$RecipeIngredientsTableAnnotationComposer,
      $$RecipeIngredientsTableCreateCompanionBuilder,
      $$RecipeIngredientsTableUpdateCompanionBuilder,
      (RecipeIngredient, $$RecipeIngredientsTableReferences),
      RecipeIngredient,
      PrefetchHooks Function({bool recipeId, bool pantryId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GenericNamesTableTableManager get genericNames =>
      $$GenericNamesTableTableManager(_db, _db.genericNames);
  $$AllergensTableTableManager get allergens =>
      $$AllergensTableTableManager(_db, _db.allergens);
  $$ItemsTableTableManager get items =>
      $$ItemsTableTableManager(_db, _db.items);
  $$ItemAllergensTableTableManager get itemAllergens =>
      $$ItemAllergensTableTableManager(_db, _db.itemAllergens);
  $$PantryTableTableManager get pantry =>
      $$PantryTableTableManager(_db, _db.pantry);
  $$RecipesTableTableManager get recipes =>
      $$RecipesTableTableManager(_db, _db.recipes);
  $$RecipeIngredientsTableTableManager get recipeIngredients =>
      $$RecipeIngredientsTableTableManager(_db, _db.recipeIngredients);
}
