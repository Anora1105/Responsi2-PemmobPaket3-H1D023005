import 'package:flutter/material.dart';
import 'login_page.dart'; // Pastikan file ini nanti dibuat

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Responsi 2 Mobile Paket 3 H1D023005', 
      theme: ThemeData(
  
        primarySwatch: Colors.brown, 
        primaryColor: Colors.brown,
        useMaterial3: false, 
      ),
      home: const LoginPage(),
    );
  }
}