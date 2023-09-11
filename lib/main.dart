import 'package:bluetooth_test2/lights.dart';
import 'package:flutter/material.dart';
import 'bluetooth_connection.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bluetooth App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BluetoothConnecting(),
      // home: const BluetoothData()
    );
  }
}
