import 'package:flutter/material.dart';

class CoffeePrefs extends StatefulWidget {
  const CoffeePrefs({super.key});

  @override
  State<CoffeePrefs> createState() => _CoffeePrefsState();
}

class _CoffeePrefsState extends State<CoffeePrefs> {
  int strength = 1;

  int sugars = 2;

  void increaseStrength() {
    setState(() {
      strength++;
    });
  }

  void increaseSugars() {
    setState(() {
      sugars++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Strength: '),
            Text(strength.toString()),
            SizedBox(width: 10),
            Image.asset(
              'assets/images/coffee_bean.png',
              width: 20,
              height: 20,
              color: Colors.brown[200],
              colorBlendMode: BlendMode.multiply,
            ),
            Expanded(child: SizedBox(width: 50)),
            FilledButton(
              onPressed: increaseStrength,
              style: FilledButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.brown[700],
              ),
              child: Text("+"),
            ),
          ],
        ),
        Row(
          children: [
            Text('Sugars: '),
            Text(sugars.toString()),
            SizedBox(width: 10),
            Image.asset(
              'assets/images/sugar_cube.png',
              width: 20,
              height: 20,
              color: Colors.brown[200],
              colorBlendMode: BlendMode.multiply,
            ),
            Expanded(child: SizedBox(width: 50)),
            TextButton(
              onPressed: increaseSugars,
              style: TextButton.styleFrom(
                foregroundColor: Colors.brown[700],
                backgroundColor: Colors.white,
              ),
              child: Text("+"),
            ),
          ],
        ),
      ],
    );
  }
}
