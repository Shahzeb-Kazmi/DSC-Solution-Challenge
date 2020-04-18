import 'package:flutter/material.dart';
import 'package:flutter_smart_course/src/pages/login_page.dart';
import 'src/theme/theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      home:LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
