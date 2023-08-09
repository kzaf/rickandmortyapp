import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final int index;

  const DetailsPage({
    required this.index, 
    super.key}
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$index"),
        centerTitle: true,
      ),
      body: Center()
    );
  }
}