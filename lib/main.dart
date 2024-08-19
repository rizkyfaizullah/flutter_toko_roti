import 'package:flutter/material.dart';
import 'package:sertifikasi_jmp_final/toko_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kelompok Pekerjaan 3',
      home: MaterialApp(
        theme: ThemeData(
          // primarySwatch: Colors.grey,
          // colorScheme: ColorScheme.fromSeed(
          //   seedColor:
          //       Colors.grey, // Seed color for generating the color scheme
          //   primary: const Color.fromARGB(255, 255, 255, 255),
          //   secondary: Colors.amber, // Accent color
          // ),
          scaffoldBackgroundColor:
              Colors.grey[100], // Background color for Scaffold
          cardColor: Colors.white,
        ),
        home: TokoPage(),
      ),
    );
  }
}
