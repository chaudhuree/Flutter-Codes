import 'package:flutter/material.dart';
import 'package:coffee_card/styled_button.dart';

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
      strength = strength < 5 ? strength + 1 : 1;
    });
  }

  void increaseSugars() {
    setState(() {
      sugars = sugars < 5 ? sugars + 1 : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text('Strength: '),
            // Text(strength.toString()),
            SizedBox(width: 10),
            for (int i = 0; i < strength; i++)
              Image.asset(
                'assets/images/coffee_bean.png',
                width: 20,
                height: 20,
                color: Colors.brown[100],
                colorBlendMode: BlendMode.multiply,
              ),
            Expanded(child: SizedBox(width: 50)),
            StyledButton(onPressed: increaseStrength, child: Text("+")),
            // FilledButton(
            //   onPressed: increaseStrength,
            //   style: FilledButton.styleFrom(
            //     foregroundColor: Colors.white,
            //     backgroundColor: Colors.brown[700],
            //   ),
            //   child: Text("+"),
            // ),
          ],
        ),
        Row(
          children: [
            Text('Sugars: '),
            // Text(sugars.toString()),
            SizedBox(width: 10),
            if (sugars == 0) const Text("No sugars"),

            for (int i = 0; i < sugars; i++)
              Image.asset(
                'assets/images/sugar_cube.png',
                width: 20,
                height: 20,
                color: Colors.brown[100],
                colorBlendMode: BlendMode.multiply,
              ),
            Expanded(child: SizedBox(width: 50)),
            StyledButton(
              bgColor: Colors.white,
              textColor: Colors.brown[700],
              onPressed: increaseSugars,
              child: Text("+"),
            ),
            // TextButton(
            //   onPressed: increaseSugars,
            //   style: TextButton.styleFrom(
            //     foregroundColor: Colors.brown[700],
            //     backgroundColor: Colors.white,
            //   ),
            //   child: Text("+"),
            // ),
          ],
        ),
      ],
    );
  }
}
