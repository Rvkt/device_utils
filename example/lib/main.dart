import 'dart:async';
import 'dart:developer';

import 'package:device_utils/device_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _deviceId = 'Unknown';
  String _freeSpace = 'Unknown';
  String _batteryLevel = 'Unknown';
  String _networkStatus = 'Unknown';

  final _deviceUtilsPlugin = DeviceUtils();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    try {
      String platformVersion = await _deviceUtilsPlugin.getPlatformVersion() ?? 'Unknown platform version';
      String deviceId = await _deviceUtilsPlugin.getDeviceId() ?? 'Unknown device ID';
      String freeSpace = (await _deviceUtilsPlugin.getFreeSpace())?.toString() ?? 'Unknown';
      String batteryLevel = (await _deviceUtilsPlugin.getBatteryLevel())?.toString() ?? 'Unknown';
      String networkStatus = await _deviceUtilsPlugin.getNetworkStatus() ?? 'Unknown';

      if (!mounted) return;

      setState(() {
        _platformVersion = platformVersion;
        _deviceId = deviceId;
        _freeSpace = freeSpace;
        _batteryLevel = batteryLevel;
        _networkStatus = networkStatus;
      });
    } on PlatformException catch (e) {
      log('Failed to get device info: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'monospace', // Using a monospace font
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontFamily: 'monospace', fontSize: 16),
          bodyMedium: TextStyle(fontFamily: 'monospace', fontSize: 12),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Device Utils',
            style: TextStyle(fontFamily: 'monospace', fontSize: 20),
          ),
        ),
        body: Card(
          margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Parameter', style: TextStyle(fontWeight: FontWeight.bold))),
                  DataColumn(label: Text('Value', style: TextStyle(fontWeight: FontWeight.bold))),
                ],
                rows: [
                  DataRow(cells: [
                    const DataCell(Text('Platform Version')),
                    DataCell(Text(_platformVersion)),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Device ID')),
                    DataCell(Text(_deviceId)),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Free Space')),
                    DataCell(Text('$_freeSpace bytes')),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Battery Level')),
                    DataCell(Text('$_batteryLevel%')),
                  ]),
                  DataRow(cells: [
                    const DataCell(Text('Network Status')),
                    DataCell(Text(_networkStatus)),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
