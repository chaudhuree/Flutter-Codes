import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coffee Card"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.brown[700],
        centerTitle: true,
      ),
      body: Container(
        color: Colors.amber,
        padding: EdgeInsets.all(10),
        child: Text("sOhan chaudhuree"),
      ),
    );
  }
}
