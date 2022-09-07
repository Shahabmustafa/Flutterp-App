import 'package:flutter/material.dart';
import 'price_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.lightBlue,
        ),
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Colors.white),
      home: PriceScreen(),
    );
  }
}

