import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatelessWidget {
  List<String> imageSlider = [
    'assets/image_slider/image1.webp',
    'assets/image_slider/image2.webp',
    'assets/image_slider/image3.webp',
    'assets/image_slider/image4.jpg',
    'assets/image_slider/image5.webp',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: imageSlider.length,
      itemBuilder: (context, index, realInd) {
        return Container(
          width: MediaQuery.of(context).size.width * 0.9,
          // margin: EdgeInsets.symmetric(horizontal: 5.0), // GAP/MARGIN here
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage(imageSlider[index]),
              fit: BoxFit.cover,
            ),
          ),
        );
      },
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 0.8,
        aspectRatio: 2.2,
        scrollPhysics: BouncingScrollPhysics(),
        enlargeCenterPage: true,
      ),
    );
  }
}
