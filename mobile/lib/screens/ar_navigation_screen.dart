import 'package:flutter/material.dart';

class ArNavigationScreen extends StatelessWidget {
  final Map<String, dynamic> route;
  final String destination;

  const ArNavigationScreen({
    super.key,
    required this.route,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    final routeNodes = route['route']?['nodes'] ?? [];
    return Scaffold(
      appBar: AppBar(
        title: Text('Navigate to $destination'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.architecture_rounded, size: 72),
              const SizedBox(height: 20),
              const Text(
                'AR Navigation View',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                'Waypoints: ${routeNodes.isNotEmpty ? routeNodes.length : 0}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 24),
              const Text(
                'This placeholder is ready to be connected to the AR plugin and BLE localization logic.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
