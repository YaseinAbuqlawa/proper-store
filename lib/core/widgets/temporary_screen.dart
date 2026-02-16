import 'package:flutter/material.dart';

class TemporaryScreen extends StatelessWidget {
  final String text;
  const TemporaryScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text)),
      body: Center(child: Text(text)),
    );
  }
}
