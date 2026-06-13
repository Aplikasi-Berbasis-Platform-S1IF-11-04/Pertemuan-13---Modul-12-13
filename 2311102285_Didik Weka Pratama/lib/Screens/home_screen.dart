import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/counter_provider.dart';
import '../services/notification_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4A90D9),
        foregroundColor: Colors.white,
        title: const Text(
          'Counter App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          // Tombol reset
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Reset Counter',
            onPressed: () {
              context.read<CounterProvider>().reset();
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Card untuk menampilkan nilai counter
            Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4A90D9).withOpacity(0.3),
                    blurRadius: 30,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Nilai Counter',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Consumer untuk membaca nilai dari Provider
                  Consumer<CounterProvider>(
                    builder: (context, counterProvider, child) {
                      return Text(
                        '${counterProvider.counter}',
                        style: const TextStyle(
                          fontSize: 72,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4A90D9),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 60),

            // Tombol Tambah
            Consumer<CounterProvider>(
              builder: (context, counterProvider, child) {
                return ElevatedButton.icon(
                  onPressed: () async {
                    // Tambah counter via Provider
                    counterProvider.increment();

                    // Tampilkan notifikasi dengan nilai terbaru
                    await NotificationService()
                        .showCounterNotification(counterProvider.counter);
                  },
                  icon: const Icon(Icons.add, size: 28),
                  label: const Text(
                    'Tambah (+)',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4A90D9),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                  ),
                );
              },
            ),

            const SizedBox(height: 24),

            // Info teks
            const Text(
              'Tekan tombol untuk menambah counter\ndan melihat notifikasi',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
