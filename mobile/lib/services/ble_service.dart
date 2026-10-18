import 'dart:async';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleService {
  final FlutterReactiveBle _ble = FlutterReactiveBle();
  StreamSubscription<DiscoveredDevice>? _subscription;
  final List<DiscoveredDevice> devices = [];

  void startScan() {
    devices.clear();
    _subscription = _ble.scanForDevices(withServices: []).listen((device) {
      if (!devices.any((d) => d.id == device.id)) {
        devices.add(device);
      }
    }, onError: (e) {
      print('BLE scan error: $e');
    });
  }

  void stopScan() {
    _subscription?.cancel();
    _subscription = null;
  }

  List<Map<String, dynamic>> getBeaconSnapshot() {
    return devices
        .map((d) => {
              'id': d.id,
              'name': d.name,
              'rssi': d.rssi,
            })
        .toList();
  }
}
