import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/shared/styled_text.dart';

class VocationCard extends StatelessWidget {
  const VocationCard({super.key, required this.vocation});

  final Vocation vocation;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // print(vocation.title);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              // vocation img
              SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(
                  'assets/img/vocations/${vocation.image}',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  children: [
                    StyledHeading(vocation.title),
                    StyledText(vocation.description),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
