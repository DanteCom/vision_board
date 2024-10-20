import 'package:hive_flutter/hive_flutter.dart';
import 'package:vision_board/app/app.dart';
import 'package:flutter/material.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('vision');
  await Hive.openBox('settings');
  runApp(const App());
}
