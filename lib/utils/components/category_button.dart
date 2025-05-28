import 'package:buybox_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

Widget addRemove(VoidCallback onAdd, VoidCallback onRemove, int count) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        icons(Icons.remove, onRemove, Colors.green.shade100, AppColors.green),
        SizedBox(width: 8),
        Text(count.toString()),
        SizedBox(width: 8),
        icons(Icons.add, onAdd, AppColors.green, AppColors.white),
      ],
    ),
  );
}

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

Widget addToCart(MediaQueryData mediaQuery, VoidCallback onTap) {
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
            padding: EdgeInsets.all(
              mediaQuery.orientation == Orientation.portrait ? 8.0 : 6.0,
            ),
            child: Text(
              'Add to cart',
              style: TextStyle(
                color: AppColors.green,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
