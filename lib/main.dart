import 'package:flutter/material.dart';
import 'boon_listview_screen.dart';
import 'sqflite_floor_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteFloorService.instance.initializeDatabase();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Center(child: BoonListViewScreen())),
    );
  }
}
