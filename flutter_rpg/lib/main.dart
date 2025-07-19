import 'package:flutter/material.dart';
import 'package:flutter_rpg/home.dart';

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sandbox"), centerTitle: true),
      body: const Center(child: Text("Sandbox")),
    );
  }
}

// stl = stateless widget
// stf = stateful widget
