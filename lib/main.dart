import 'package:connect/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      title: 'Daily Live',
      theme: ThemeData(
        primaryColor: Color(0xffEB713C),
        primarySwatch: Colors.orange,
      ),
      home: Home(),
    );
  }
}
