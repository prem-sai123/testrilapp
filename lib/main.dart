import 'package:flutter/material.dart';
import 'package:testrilapp/login/presentation/widgets/main_log_in_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RIL Test App',
      home: Scaffold(
        body: RILHomePage(),
      ),
    );
  }
}
