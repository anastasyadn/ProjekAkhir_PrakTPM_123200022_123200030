import 'package:flutter/material.dart';
import 'package:tpm_projekakhir_123200022/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Projek Akhir',
      home: HalamanLogin(),
    );
  }
}
