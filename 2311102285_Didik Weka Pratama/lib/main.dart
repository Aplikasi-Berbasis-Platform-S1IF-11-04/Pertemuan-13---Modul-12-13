import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/counter_provider.dart';
import 'services/notification_service.dart';
import 'screens/home_screen.dart';

void main() async {
  // Pastikan Flutter binding sudah diinisialisasi sebelum async operations
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi NotificationService
  await NotificationService().initialize();

  runApp(
    // MultiProvider untuk mendaftarkan semua provider
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter App - Provider & Notifikasi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4A90D9),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HomeScreen(),
    );
  }
}
