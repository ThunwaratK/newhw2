import 'package:flutter/material.dart';
import 'package:cp_213_sqflife_thunwarat/boon_listview_screen.dart';

void main() {
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
