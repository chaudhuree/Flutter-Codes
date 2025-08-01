import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
                onPressed: () {},
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
