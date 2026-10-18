import 'package:flutter/material.dart';
import 'package:campus_ar_mobile/screens/ar_navigation_screen.dart';
import 'package:campus_ar_mobile/services/api_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String destination = 'Library';
  bool accessibilityMode = true;
  bool isLoading = false;

  Future<void> _startNavigation() async {
    setState(() => isLoading = true);
    try {
      final api = ApiClient();
      final route = await api.fetchRoute(
        from: {'floor_id': 1, 'node_id': 10},
        to: {'floor_id': 1, 'node_id': 20},
        profile: {
          'avoid_stairs': accessibilityMode,
          'prefer_elevator': true,
        },
      );

      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ArNavigationScreen(
            route: route,
            destination: destination,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Route error: $e')),
      );
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus AR Nav'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Campus Navigation',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Destination',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => destination = value,
              controller: TextEditingController(text: destination),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text('Accessibility mode'),
                const Spacer(),
                Switch(
                  value: accessibilityMode,
                  onChanged: (value) => setState(() => accessibilityMode = value),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : _startNavigation,
                icon: const Icon(Icons.navigation_outlined),
                label: Text(isLoading ? 'Loading...' : 'Start Navigation'),
              ),
            ),
            const Spacer(),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Nearby destinations', style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    Text('Library • CSE Block • Admin Office • Auditorium'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
