import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'lights.dart';
import 'kitchen.dart';
import 'heating.dart';

class BluetoothConnecting extends StatefulWidget {
  const BluetoothConnecting({super.key});

  @override
  _BluetoothConnecting createState() => _BluetoothConnecting();
}

class _BluetoothConnecting extends State<BluetoothConnecting> {
  BluetoothDevice? selectedDevice;
  BluetoothConnection? connection;
  String? selectedDeviceName;

  List<BluetoothDevice> devices = [];
  List<GlobalKey> keys = [];
  @override
  void initState() {
    getDevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.small(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Lights(),
                ),
              );
            },
            child: const Icon(Icons.lightbulb_sharp),
          ),
          FloatingActionButton.small(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Kitchen(),
                ),
              );
            },
            child: const Icon(Icons.kitchen),
          ),
          FloatingActionButton.small(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Heating(),
                  ));
            },
            child: const Icon(Icons.ac_unit),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Bluetooth App'),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        selectedDevice = devices[index];
                        setState(() {
                          selectedDeviceName = selectedDevice?.name.toString();
                        });

                        log(selectedDevice!.name.toString());
                      },
                      child: Column(
                        children: [
                          Text(
                            devices[index].name.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      ),
                    ),
                  );
                },
                itemCount: devices.length,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _connectToDevice();
              },
              child: Text('Connect to $selectedDeviceName'),
            ),
            ElevatedButton(
              onPressed: () {
                connection?.close();
              },
              child: const Text('disconnect'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<void> getDevices() async {
    devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    setState(() {});
  }

  Future<void> _connectToDevice() async {
    try {
      log("got devices");
      log(selectedDevice!.name.toString());
    } catch (e) {
      log(e.toString());
    }

    try {
      connection = await BluetoothConnection.toAddress(selectedDevice!.address);
      log('Connected to: ${selectedDevice!.name}');
    } catch (e) {
      log(e.toString());
      log("connection failed!!!");
    }
  }
}
