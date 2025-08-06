import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/character.dart';
import 'package:flutter_rpg/screens/profile/stats_table.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class Profile extends StatelessWidget {
  const Profile({super.key, required this.character});

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: StyledTitle(character.name), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // basic info - image ,vocation ,description
            Container(
              padding: EdgeInsets.all(16),
              color: AppColors.secondaryColor.withValues(alpha: 0.5),
              child: Row(
                children: [
                  // vocation img
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StyledHeading(character.vocation.title),
                        const SizedBox(height: 10),
                        StyledText(character.vocation.description),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // weaon and ability
            const SizedBox(height: 20),

            Center(child: Icon(Icons.code, color: AppColors.primaryColor)),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                width: double.infinity, // full width
                color: AppColors.secondaryColor.withValues(alpha: 0.5),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StyledHeading("Slogan"),
                    StyledText(character.slogan),
                    const SizedBox(height: 10),
                    StyledHeading("Weapon Of Choice"),
                    StyledText(character.vocation.weapon),
                    const SizedBox(height: 10),
                    StyledHeading("Ability"),
                    StyledText(character.vocation.ability),
                  ],
                ),
              ),
            ),

            // stats and skills
            const SizedBox(height: 20),
            StatsTable(character: character),
            // save button
          ],
        ),
      ),
    );
  }
}
