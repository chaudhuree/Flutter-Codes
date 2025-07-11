import 'package:flutter/material.dart';

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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // width: double.infinity,
            color: Colors.brown[200],
            padding: EdgeInsets.all(20),
            child: Text("How I like my coffee.."),
          ),
          Container(
            // width: double.infinity,
            color: Colors.brown[100],
            padding: EdgeInsets.all(20),
            child: Text("Coffee prefs."),
          ),
        ],
      ),
    );
  }
}
