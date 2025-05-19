import 'package:buybox_app/controllers/home_page_controller.dart';
import 'package:buybox_app/route/app_routes.dart';
import 'package:buybox_app/utils/app_colors.dart';
import 'package:buybox_app/utils/components/bottom_navigationbar.dart';
import 'package:buybox_app/utils/components/image_slider.dart';
import 'package:buybox_app/utils/text_style/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final uid = FirebaseAuth.instance.currentUser!.uid;

  final HomePageController _controller = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller.getLocation();
  }

  // final FirebaseFirestore _firestore = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(uid)
  //     .get['userName'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                "Good Morning",
                style: TextStyle(
                  color: AppColors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("Amit kumar", style: nameText()),
                      SizedBox(width: 5),
                      Icon(Icons.waving_hand_rounded, color: AppColors.yellow),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.yellow,
                    child: Icon(Icons.notifications, color: AppColors.white),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: AppColors.grey),
                ),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Search for over 5000+ product',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            ImageSlider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Categories', style: categoriesText()),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_forward_ios, size: 30),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25),
                child: Row(
                  spacing: 10,
                  children: List.generate(8, (index) {
                    return Container(
                      width: 90,
                      height: 110,
                      decoration: BoxDecoration(
                        color: AppColors.green,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        index.toString(),
                        style: TextStyle(color: AppColors.white),
                      ),
                    );
                  }),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 25.0, bottom: 0),
              child: Text('Popular Deals', style: categoriesText()),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25.0,
                vertical: 0,
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    color: AppColors.green,
                    child: Column(children: [Text('1')]),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
