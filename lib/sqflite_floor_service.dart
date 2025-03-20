import 'app_database.dart';

class SqfliteFloorService {
  static final SqfliteFloorService instance = SqfliteFloorService._internal();
  SqfliteFloorService._internal();

  AppDatabase? _database;

  Future<AppDatabase> initializeDatabase() async {
    if (_database != null) {
      return _database!;
    }

    _database = await $FloorAppDatabase.databaseBuilder("boon.db").build();
    return _database!;
  }

  AppDatabase get database {
    if (_database == null) {
      throw Exception(
        "Database has not been initialized. Call initializeDatabase() first.",
      );
    }
    return _database!;
  }
}
