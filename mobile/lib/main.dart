import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const EmsApp());
}

class EmsApp extends StatelessWidget {
  const EmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DT EMS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A5FB4)),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Android emulators reach the host machine through 10.0.2.2, not localhost.
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:8080/api',
  );

  String _status = 'Checking backend…';

  Future<void> _checkBackend() async {
    setState(() => _status = 'Checking backend…');
    try {
      final response = await http
          .get(Uri.parse('$apiBaseUrl/system/info'))
          .timeout(const Duration(seconds: 5));
      setState(() {
        _status = response.statusCode == 200
            ? 'Backend reachable (${response.statusCode})'
            : 'Backend returned ${response.statusCode}';
      });
    } catch (error) {
      setState(() => _status = 'Backend unreachable: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    _checkBackend();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('DT EMS')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.badge_outlined, size: 64),
              const SizedBox(height: 16),
              const Text(
                'Employment Management System',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              const Text('Employee mobile app'),
              const SizedBox(height: 32),
              Text(_status, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: _checkBackend,
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}