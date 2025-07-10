// import 'package:coffee_card/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Sandbox()));
}

class Sandbox extends StatelessWidget {
  const Sandbox({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Coffee Card"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.brown[200],
            padding: EdgeInsets.all(20),
            child: Text("How I like my coffee.."),
          ),
          Container(
            width: double.infinity,
            color: Colors.brown[100],
            padding: EdgeInsets.all(20),
            child: Text("Coffee prefs."),
          ),
        ],
      ),
    );
  }
}

// const Center(child: Text("sOhan chaudhuree")),
// container
// stl
