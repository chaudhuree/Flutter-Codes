import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/screens/profile/profile.dart';

import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class CharacterCard extends StatelessWidget {
  const CharacterCard(this.character, {super.key});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
        child: Row(
          // Use MainAxisSize.max to fill the available width
          mainAxisSize: MainAxisSize.max,
          // Add alignment to properly position children
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Character image - fixed width
            // SizedBox(
            //   width: 80,
            //   height: 80,
            //   child: Image.asset(
            //     'assets/img/vocations/${character.vocation.image}',
            //     fit: BoxFit.cover,
            //   ),
            // ),
            // Image.asset(
            //   'assets/img/vocations/algo_wizard.jpg',
            //   width: 80.w,
            //   height: 80.h,
            //   fit: BoxFit.cover,
            // ),
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.secondaryColor.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            const SizedBox(width: 12),
            // Character info - wrap in Expanded to take available space but not overflow
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  StyledHeading(character.name),
                  StyledText(character.vocation.title),
                ],
              ),
            ),
            // Arrow button with fixed size
            SizedBox(
              width: 40,
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(character: character),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_forward, color: AppColors.textColor),
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
