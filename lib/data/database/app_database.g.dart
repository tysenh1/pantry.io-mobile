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
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  late final GeneratedColumn<int> weightPerPiece = GeneratedColumn<int>(
    'weight_per_piece',
    aliasedName,
    false,
    type: DriftSqlType.int,
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
    } else if (isInserting) {
      context.missing(_idMeta);
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
        DriftSqlType.string,
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
        DriftSqlType.int,
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
  final String id;
  final String name;
  final String primaryUnit;
  final int weightPerPiece;
  const GenericName({
    required this.id,
    required this.name,
    required this.primaryUnit,
    required this.weightPerPiece,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['primary_unit'] = Variable<String>(primaryUnit);
    map['weight_per_piece'] = Variable<int>(weightPerPiece);
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
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      primaryUnit: serializer.fromJson<String>(json['primaryUnit']),
      weightPerPiece: serializer.fromJson<int>(json['weightPerPiece']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'primaryUnit': serializer.toJson<String>(primaryUnit),
      'weightPerPiece': serializer.toJson<int>(weightPerPiece),
    };
  }

  GenericName copyWith({
    String? id,
    String? name,
    String? primaryUnit,
    int? weightPerPiece,
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
  final Value<String> id;
  final Value<String> name;
  final Value<String> primaryUnit;
  final Value<int> weightPerPiece;
  final Value<int> rowid;
  const GenericNamesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.primaryUnit = const Value.absent(),
    this.weightPerPiece = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GenericNamesCompanion.insert({
    required String id,
    required String name,
    required String primaryUnit,
    required int weightPerPiece,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       primaryUnit = Value(primaryUnit),
       weightPerPiece = Value(weightPerPiece);
  static Insertable<GenericName> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? primaryUnit,
    Expression<int>? weightPerPiece,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (primaryUnit != null) 'primary_unit': primaryUnit,
      if (weightPerPiece != null) 'weight_per_piece': weightPerPiece,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GenericNamesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? primaryUnit,
    Value<int>? weightPerPiece,
    Value<int>? rowid,
  }) {
    return GenericNamesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      primaryUnit: primaryUnit ?? this.primaryUnit,
      weightPerPiece: weightPerPiece ?? this.weightPerPiece,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (primaryUnit.present) {
      map['primary_unit'] = Variable<String>(primaryUnit.value);
    }
    if (weightPerPiece.present) {
      map['weight_per_piece'] = Variable<int>(weightPerPiece.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GenericNamesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('primaryUnit: $primaryUnit, ')
          ..write('weightPerPiece: $weightPerPiece, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $GenericNamesTable genericNames = $GenericNamesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [genericNames];
}

typedef $$GenericNamesTableCreateCompanionBuilder =
    GenericNamesCompanion Function({
      required String id,
      required String name,
      required String primaryUnit,
      required int weightPerPiece,
      Value<int> rowid,
    });
typedef $$GenericNamesTableUpdateCompanionBuilder =
    GenericNamesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> primaryUnit,
      Value<int> weightPerPiece,
      Value<int> rowid,
    });

class $$GenericNamesTableFilterComposer
    extends Composer<_$AppDatabase, $GenericNamesTable> {
  $$GenericNamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
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

  ColumnFilters<int> get weightPerPiece => $composableBuilder(
    column: $table.weightPerPiece,
    builder: (column) => ColumnFilters(column),
  );
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
  ColumnOrderings<String> get id => $composableBuilder(
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

  ColumnOrderings<int> get weightPerPiece => $composableBuilder(
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
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get primaryUnit => $composableBuilder(
    column: $table.primaryUnit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weightPerPiece => $composableBuilder(
    column: $table.weightPerPiece,
    builder: (column) => column,
  );
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
          (
            GenericName,
            BaseReferences<_$AppDatabase, $GenericNamesTable, GenericName>,
          ),
          GenericName,
          PrefetchHooks Function()
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
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> primaryUnit = const Value.absent(),
                Value<int> weightPerPiece = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GenericNamesCompanion(
                id: id,
                name: name,
                primaryUnit: primaryUnit,
                weightPerPiece: weightPerPiece,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String primaryUnit,
                required int weightPerPiece,
                Value<int> rowid = const Value.absent(),
              }) => GenericNamesCompanion.insert(
                id: id,
                name: name,
                primaryUnit: primaryUnit,
                weightPerPiece: weightPerPiece,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
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
      (
        GenericName,
        BaseReferences<_$AppDatabase, $GenericNamesTable, GenericName>,
      ),
      GenericName,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$GenericNamesTableTableManager get genericNames =>
      $$GenericNamesTableTableManager(_db, _db.genericNames);
}
