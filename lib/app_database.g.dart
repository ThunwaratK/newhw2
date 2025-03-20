// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  BoonDao? _boonDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `boon` (`bid` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT NOT NULL, `desc` TEXT, `eventDate` TEXT NOT NULL, `startHour` TEXT NOT NULL, `startMinute` TEXT NOT NULL, `location` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  BoonDao get boonDao {
    return _boonDaoInstance ??= _$BoonDao(database, changeListener);
  }
}

class _$BoonDao extends BoonDao {
  _$BoonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _boonEntityInsertionAdapter = InsertionAdapter(
            database,
            'boon',
            (BoonEntity item) => <String, Object?>{
                  'bid': item.bid,
                  'title': item.title,
                  'desc': item.desc,
                  'eventDate': item.eventDate,
                  'startHour': item.startHour,
                  'startMinute': item.startMinute,
                  'location': item.location
                },
            changeListener),
        _boonEntityUpdateAdapter = UpdateAdapter(
            database,
            'boon',
            ['bid'],
            (BoonEntity item) => <String, Object?>{
                  'bid': item.bid,
                  'title': item.title,
                  'desc': item.desc,
                  'eventDate': item.eventDate,
                  'startHour': item.startHour,
                  'startMinute': item.startMinute,
                  'location': item.location
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<BoonEntity> _boonEntityInsertionAdapter;

  final UpdateAdapter<BoonEntity> _boonEntityUpdateAdapter;

  @override
  Future<List<BoonEntity?>> findAllBoons() async {
    return _queryAdapter.queryList('SELECT * FROM boon',
        mapper: (Map<String, Object?> row) => BoonEntity(
            bid: row['bid'] as int?,
            title: row['title'] as String,
            desc: row['desc'] as String?,
            eventDate: row['eventDate'] as String,
            startHour: row['startHour'] as String,
            startMinute: row['startMinute'] as String,
            location: row['location'] as String));
  }

  @override
  Future<BoonEntity?> findBoonByBId(int bid) async {
    return _queryAdapter.query('SELECT * FROM boon WHERE bid = ?1',
        mapper: (Map<String, Object?> row) => BoonEntity(
            bid: row['bid'] as int?,
            title: row['title'] as String,
            desc: row['desc'] as String?,
            eventDate: row['eventDate'] as String,
            startHour: row['startHour'] as String,
            startMinute: row['startMinute'] as String,
            location: row['location'] as String),
        arguments: [bid]);
  }

  @override
  Future<void> deleteBoonByBID(int bid) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM boon WHERE bid = ?1', arguments: [bid]);
  }

  @override
  Stream<List<BoonEntity?>> watchAllBoons() {
    return _queryAdapter.queryListStream('SELECT * FROM boon',
        mapper: (Map<String, Object?> row) => BoonEntity(
            bid: row['bid'] as int?,
            title: row['title'] as String,
            desc: row['desc'] as String?,
            eventDate: row['eventDate'] as String,
            startHour: row['startHour'] as String,
            startMinute: row['startMinute'] as String,
            location: row['location'] as String),
        queryableName: 'boon',
        isView: false);
  }

  @override
  Future<void> insertBoon(BoonEntity boonEntity) async {
    await _boonEntityInsertionAdapter.insert(
        boonEntity, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateBoon(BoonEntity boonEntity) async {
    await _boonEntityUpdateAdapter.update(
        boonEntity, OnConflictStrategy.replace);
  }
}
