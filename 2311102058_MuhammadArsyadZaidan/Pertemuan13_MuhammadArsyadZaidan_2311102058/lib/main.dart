import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'value_provider.dart';
import 'notify_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotifyService.initialize();

  runApp(
    ChangeNotifierProvider(
      create: (_) => ValueProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Counter Modern',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final value = context.watch<ValueProvider>().value;

    return Scaffold(
      appBar: AppBar(title: const Text("Counter App"), centerTitle: true),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.deepPurple.shade50,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.bolt, size: 60, color: Colors.deepPurple),
              const SizedBox(height: 15),
              const Text("Nilai Saat Ini", style: TextStyle(fontSize: 18)),
              const SizedBox(height: 10),
              Text(
                "$value",
                style: const TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<ValueProvider>().increment();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
