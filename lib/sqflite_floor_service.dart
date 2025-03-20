import 'app_database.dart';

class SqfliteFloorService {
  // Singleton
  static final SqfliteFloorService instance = SqfliteFloorService._internal();
  SqfliteFloorService._internal();

  AppDatabase? _database; // Use nullable type to check initialization

  Future<AppDatabase> initializeDatabase() async {
    // If the database is already initialized, return it
    if (_database != null) {
      return _database!;
    }

    // Initialize the database
    _database = await $FloorAppDatabase.databaseBuilder("boon.db").build();
    return _database!;
  }

  // Getter for the database
  AppDatabase get database {
    if (_database == null) {
      throw Exception(
        "Database has not been initialized. Call initializeDatabase() first.",
      );
    }
    return _database!;
  }
}
