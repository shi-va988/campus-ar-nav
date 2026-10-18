import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  static const String _baseUrl = 'http://10.0.2.2:3000';

  Future<Map<String, dynamic>> fetchRoute({
    required Map<String, dynamic> from,
    required Map<String, dynamic> to,
    required Map<String, dynamic> profile,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/api/v1/route'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'from': from,
        'to': to,
        'profile': profile,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch route: ${response.body}');
    }

    final data = jsonDecode(response.body);
    if (data['route'] == null) {
      throw Exception('No route returned by backend');
    }

    return data;
  }
}
