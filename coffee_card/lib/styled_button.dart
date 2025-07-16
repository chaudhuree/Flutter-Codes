import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  const StyledButton({
    super.key,
    this.bgColor,
    this.textColor,
    required this.onPressed,
    required this.child,
  });

  final void Function() onPressed;
  final Widget child;
  final Color? bgColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: bgColor ?? Colors.brown[700],
        foregroundColor: textColor ?? Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
