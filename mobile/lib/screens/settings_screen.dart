import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.accessibility_new),
            title: Text('Accessibility profile'),
            subtitle: Text('Avoid stairs, prefer ramps, large fonts'),
          ),
          ListTile(
            leading: Icon(Icons.hearing),
            title: Text('Text-to-speech'),
            subtitle: Text('Audio guidance enabled'),
          ),
          ListTile(
            leading: Icon(Icons.vibration),
            title: Text('Haptic feedback'),
            subtitle: Text('Turn-by-turn vibrate enabled'),
          ),
        ],
      ),
    );
  }
}
