// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_scale/routers/app_router.dart';
import 'package:flutter_scale/themes/styles.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

var initURL;

// Logger
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    colors: true,
    printEmojis: true,
    printTime: false,
  ),
);

// Print logger
void _printLogger() {
  logger.d('Debug');
  logger.e('Error');
  logger.w('Warning');
  logger.i('Info');
  logger.v('Verbose');
  logger.wtf('What a terrible failure');
}

void main() async {
  _printLogger();

  WidgetsFlutterBinding
      .ensureInitialized(); // ต้องเรียกใช้เพื่อให้ทำงานก่อน runApp

  // Create shared preferences instance
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getInt('step') == null) {
    initURL = '/';
  } else if (prefs.getInt('step') == 1) {
    initURL = '/login';
  } else if (prefs.getInt('step') == 2) {
    initURL = '/dashboard';
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // home: WelcomeScreen(),
      initialRoute: initURL,
      routes: AppRouter.routes,
    );
  }
}
