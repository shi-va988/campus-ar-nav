import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';

class SensorService {
  StreamSubscription<AccelerometerEvent>? _accelSub;
  StreamSubscription<GyroscopeEvent>? _gyroSub;

  void startTracking(void Function(AccelerometerEvent) onAccel, void Function(GyroscopeEvent) onGyro) {
    _accelSub = accelerometerEvents.listen(onAccel);
    _gyroSub = gyroscopeEvents.listen(onGyro);
  }

  void stopTracking() {
    _accelSub?.cancel();
    _gyroSub?.cancel();
  }
}
