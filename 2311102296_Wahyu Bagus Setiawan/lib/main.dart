import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) => HydrationProvider(),
      child: const MyApp(),
    ),
  );
}

// MANAGEMENT STATE: Mengatur data jumlah minum air
class HydrationProvider extends ChangeNotifier {
  int _waterGlasses = 0;
  final int _dailyTarget = 8;

  int get waterGlasses => _waterGlasses;
  int get dailyTarget => _dailyTarget;
  double get progressPercentage => (_waterGlasses / _dailyTarget).clamp(0.0, 1.0);

  void addGlass(BuildContext context) {
    if (_waterGlasses < _dailyTarget) {
      _waterGlasses++;
      notifyListeners(); // Refresh UI secara otomatis secara reaktif
      _showWebNotification(context); // Memicu notifikasi visual di web
    }
  }

  void resetTracker() {
    _waterGlasses = 0;
    notifyListeners();
  }

  void _showWebNotification(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.local_drink, color: Colors.cyanAccent),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Gelas ke-$_waterGlasses dicatat! Sisa ${_dailyTarget - _waterGlasses} gelas lagi hari ini.',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1F1F1F),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Hydration Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.cyan,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.dark(
          primary: Colors.cyan,
          secondary: Colors.cyanAccent,
          primaryContainer: Colors.cyan.withAlpha(50),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HydrationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Hydration Tracker', 
          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Times New Roman')
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF1F1F1F),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.cyanAccent),
            onPressed: () => provider.resetTracker(),
            tooltip: 'Reset Data',
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // KARTU IDENTITAS MAHASISWA
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1F1F1F),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.cyan.withAlpha(128), width: 1.5),
                ),
                child: const Column(
                  children: [
                    Text(
                      'Wahyu Bagus Setiawan', 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Times New Roman')
                    ),
                    SizedBox(height: 4),
                    Text(
                      'NIM: 2311102296', 
                      style: TextStyle(fontSize: 16, color: Colors.cyanAccent, fontFamily: 'Times New Roman')
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              
              // GRAFIK PROGRESS MELINGKAR
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 180,
                    height: 180,
                    child: CircularProgressIndicator(
                      value: provider.progressPercentage,
                      strokeWidth: 12,
                      backgroundColor: Colors.white10,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_drink, size: 40, color: Colors.cyanAccent),
                      const SizedBox(height: 8),
                      Text(
                        '${provider.waterGlasses} / ${provider.dailyTarget}',
                        style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const Text('Gelas', style: TextStyle(color: Colors.white60, fontSize: 14)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              
              // TOMBOL AKSI
              ElevatedButton.icon(
                onPressed: provider.waterGlasses >= provider.dailyTarget ? null : () => provider.addGlass(context),
                icon: const Icon(Icons.add, color: Colors.black),
                label: const Text(
                  'Tambah 1 Gelas', 
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}