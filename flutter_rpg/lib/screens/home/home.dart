import 'package:flutter/material.dart';
import 'package:flutter_rpg/shared/styled_button.dart';
import 'package:flutter_rpg/shared/styled_text.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List characters = [
    "mario",
    "luigi",
    "peach",
    "toad",
    "bowser",
    "koopa",
    "yoshi",
    "mario",
    "luigi",
    "peach",
    "toad",
    "bowser",
    "koopa",
    "yoshi",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: StyledTitle("Your Characters"), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: characters.length,
                itemBuilder: (_, index) {
                  return Container(
                    color: Colors.grey[800],
                    margin: const EdgeInsets.only(bottom: 16),
                    padding: const EdgeInsets.all(40),
                    child: StyledText(characters[index]),
                  );
                },
              ),
            ),
            StyledButton(
              onPressed: () {},
              child: const StyledHeading("Create New"),
            ),
          ],
        ),
      ),
    );
  }
}
