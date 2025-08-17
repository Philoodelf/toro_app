import 'package:flutter/material.dart';

class CostumeMenu extends StatelessWidget {

  final String label;
  final IconData? icon;
  final Color backgroundColor;
  final Color textColor;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const CostumeMenu({
    super.key,
    required this.label,
    this.icon,
    this.backgroundColor = const Color.fromARGB(255, 234, 145, 20),
    this.textColor = const Color.fromARGB(255, 93, 11, 18),
    this.width = 300,
    this.height = 70,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(),
          borderRadius: BorderRadius.circular(16),
        ),
        child: SizedBox(
          width: width,
          height: height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Icon(icon, size: 35),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 25,
                    color: textColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}