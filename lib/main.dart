import 'package:flutter/material.dart';
import 'package:spc_app/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:const Color.fromARGB(255, 104, 131, 253)),
        useMaterial3: true,
      ),
      home: const Dashboard()
    );
  }
}
