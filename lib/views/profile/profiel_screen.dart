import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfielScreen extends StatelessWidget {
  const ProfielScreen({super.key});

  singOut() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
    // await GoogleSignIn().signOut();
    // await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: appBarText()),
        backgroundColor: AppColors.green,
      ),
      backgroundColor: AppColors.green,
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          image: DecorationImage(
            image: AssetImage('assets/images/cooking_background.webp'),
            fit: BoxFit.cover,
            opacity: 0.3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.person,
                          size: 50,
                          color: AppColors.yellow,
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    Column(children: [Text('Amit kumar', style: startPage())]),
                  ],
                ),
                SizedBox(height: 25),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListtileWidget(
                        label: 'Personal Info',
                        icon: Icons.person,
                        color: Colors.deepOrange,
                        onTap: () {},
                      ),
                      ListtileWidget(
                        label: 'Addresses',
                        icon: Icons.details_outlined,
                        color: Colors.blue,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListtileWidget(
                        label: 'Cart',
                        icon: Icons.shopping_cart,
                        color: Colors.lightBlue,
                        onTap: () {},
                      ),

                      ListtileWidget(
                        label: 'Notification',
                        icon: Icons.notifications,
                        color: Colors.orange,
                        onTap: () {},
                      ),
                      ListtileWidget(
                        label: 'Payment Method',
                        icon: Icons.payment,
                        color: Colors.lightBlue,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListtileWidget(
                        label: 'FAQs',
                        icon: Icons.question_mark,
                        color: Colors.deepOrange,
                        onTap: () {},
                      ),
                      ListtileWidget(
                        label: 'User Reviews',
                        icon: Icons.reviews,
                        color: Colors.lightBlue,
                        onTap: () {},
                      ),
                      ListtileWidget(
                        label: 'Settings',
                        icon: Icons.settings,
                        color: Colors.blueAccent,
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(15),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.green,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      ListtileWidget(
                        label: 'Log Out',
                        icon: Icons.logout,
                        color: Colors.deepOrange,
                        onTap: () {
                          singOut();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListtileWidget extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  ListtileWidget({
    required this.label,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(icon, color: color),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 16,

            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_outlined,
          color: AppColors.white,
          size: 20,
        ),
      ),
    );
  }
}
