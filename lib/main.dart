import 'package:flutter/material.dart';
import 'package:rickandmortyapp/ui/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rick and Morty',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
