import 'package:permission_handler/permission_handler.dart';

class PermissionsService {
  Future<void> requestAll() async {
    await Permission.bluetooth.request();
    await Permission.bluetoothScan.request();
    await Permission.bluetoothConnect.request();
    await Permission.camera.request();
    await Permission.locationWhenInUse.request();
  }
}
