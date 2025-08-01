import 'package:flutter/material.dart';
import 'package:flutter_rpg/models/vocation.dart';
import 'package:flutter_rpg/shared/styled_text.dart';
import 'package:flutter_rpg/theme.dart';

class VocationCard extends StatelessWidget {
  const VocationCard({
    super.key,
    required this.vocation,
    required this.onVocationSelected,
    required this.selected,
  });

  final Vocation vocation;
  final void Function(Vocation) onVocationSelected;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onVocationSelected(vocation);
      },
      child: Card(
        color: selected
            ? AppColors.secondaryColor.withValues(alpha: 0.5)
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              // vocation img
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.secondaryColor.withValues(alpha: 0.5)
                      : Colors.transparent,
                  border: Border.all(color: AppColors.secondaryColor, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                // Uncomment this when you want to use the image
                // child: Image.asset(
                //   'assets/img/vocations/${vocation.image}',
                // width: 80,
                //   colorBlendMode: BlendMode.color,
                //   color: !selected ? Colors.black.withValues(alpha: 0.5) : Colors.transparent,
                // ),
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
