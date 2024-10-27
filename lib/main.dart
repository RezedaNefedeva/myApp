import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:production_app/exports.dart';
import 'package:production_app/firebase_options.dart';
import 'package:production_app/hive_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await HiveService.initHive();

  runApp(MaterialApp(
      theme: theme,
      initialRoute: '/',
      routes: routes));
}
