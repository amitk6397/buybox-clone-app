import 'package:buybox_app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Krishna'),
                    SizedBox(width: 5),
                    Icon(Icons.waving_hand_rounded, color: AppColors.yellow),
                  ],
                ),
                GestureDetector(
                  onTap: () async {},
                  child: CircleAvatar(
                    backgroundColor: AppColors.yellow,
                    child: Icon(Icons.notifications, color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
