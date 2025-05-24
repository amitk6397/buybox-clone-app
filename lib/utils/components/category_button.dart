import 'package:buybox_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

Widget icons(
  IconData icon,
  VoidCallback onTap,
  Color colors,
  Color iconColors,
) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colors,
      ),
      child: Icon(icon, color: iconColors),
    ),
  );
}

Widget addToCart(VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.green.shade100,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Add to cart',
              style: TextStyle(
                color: AppColors.green,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
