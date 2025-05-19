import 'package:buybox_app/route/app_routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final user = FirebaseAuth.instance.currentUser;
  singOut() async {
    await GoogleSignIn().signOut();
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed(AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              singOut();
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Text('amit'),
    );
  }
}
