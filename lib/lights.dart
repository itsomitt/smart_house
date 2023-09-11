import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'bluetooth_connection.dart';

late TextEditingController controller;

class Lights extends StatefulWidget {
  const Lights({super.key, this.connection});
  final BluetoothConnection? connection;
  @override
  State<Lights> createState() => _BluetoothDataState();
}

class _BluetoothDataState extends State<Lights> {
  late TextEditingController controller;
  String data1 = '';
  String data2 = '';
  bool switchKey = false;
  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lights"),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "room 1",
                style: TextStyle(
                  backgroundColor: Color.fromARGB(255, 172, 218, 255),
                ),
              ),
              swithces("lights 1"),
              const Divider(
                height: 10,
              ),
              const Text(
                "room 2",
                style: TextStyle(
                  backgroundColor: Color.fromARGB(255, 172, 218, 255),
                ),
              ),
              swithces("light x")
            ],
          ),
        ),
      ),
    );
  }

  Row swithces(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(name),
        Switch(
          value: switchKey,
          onChanged: (value) {
            _sendData(switchKey);
            setState(() {});
          },
        ),
      ],
    );
  }

  void _sendData(bool switchKey) {
    if (widget.connection != null) {
      log('connection is not null!');

      try {
        if (switchKey == true) {
          widget.connection!.output
              .add(Uint8List.fromList(data1.codeUnits)); // Send data here

          widget.connection!.output.allSent; // Wait until all data is sent
          log('Data sent');
          log(data1);
        } else {
          widget.connection!.output
              .add(Uint8List.fromList(data2.codeUnits)); // Send data here

          widget.connection!.output.allSent; // Wait until all data is sent
          log('Data sent');
          log(data2);
        }
      } catch (e) {
        log(e.toString());
      }
    } else {
      log('Not connected to a device');
      log(widget.connection.toString());
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
