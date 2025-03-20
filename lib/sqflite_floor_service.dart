import 'app_database.dart';

class SqfliteFloorService {
  //Singleton
  static final SqfliteFloorService instance = SqfliteFloorService._internal();
  SqfliteFloorService._internal();
  late final AppDatabase database;
  Future<void> initializeDatabase() async {
    database = await $FloorAppDatabase.databaseBuilder("boon.db").build();
  }
}
