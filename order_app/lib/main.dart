import 'package:flutter/material.dart';
import 'package:order_app/home_screen.dart';

import 'objectbox.g.dart';

void main() {
  Sync.isAvailable();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(title: 'Order App Demo'),
    );
  }
}
