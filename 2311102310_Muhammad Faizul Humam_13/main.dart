import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    // Mendaftarkan ChangeNotifierProvider di tingkat akar aplikasi
    ChangeNotifierProvider(
      create: (context) => CounterProvider(),
      child: const MyApp(),
    ),
  );
}

// ==========================================
// STATE MANAGEMENT: COUNTER PROVIDER
// ==========================================
class CounterProvider with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners(); // Memberitahu semua widget yang mendengarkan untuk memperbarui UI
  }
}

// ==========================================
// APLIKASI UTAMA
// ==========================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Modul 12-13 Provider & Notifikasi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HalamanUtamaCounter(),
    );
  }
}

class HalamanUtamaCounter extends StatelessWidget {
  const HalamanUtamaCounter({super.key});

  // Fungsi internal untuk memicu sistem notifikasi lokal melayang
  void _picuNotifikasiLokal(BuildContext context, int nilaiTerbaru) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.notifications_active, color: Colors.amberAccent),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Counter Update',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  Text(
                    'Nilai counter saat ini: $nilaiTerbaru',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.deepPurple.shade800,
        behavior: SnackBarBehavior.floating, // Membuat notifikasi melayang di atas UI
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Provider & Notifikasi'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Anda telah menekan tombol sebanyak:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            
            // Menggunakan Consumer untuk mendengarkan perubahan nilai dari Provider
            Consumer<CounterProvider>(
              builder: (context, counterProvider, child) {
                return Text(
                  '${counterProvider.counter}',
                  style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 1. Memanggil fungsi increment dari Provider tanpa mendengarkan ulang seluruh build
          final provider = Provider.of<CounterProvider>(context, listen: false);
          provider.incrementCounter();
          
          // 2. Memicu notifikasi dengan mengirimkan nilai counter terbaru
          _picuNotifikasiLokal(context, provider.counter);
        },
        tooltip: 'Tambah',
        child: const Icon(Icons.add),
      ),
    );
  }
}