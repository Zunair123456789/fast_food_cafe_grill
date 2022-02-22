// ignore_for_file: prefer_final_fields, file_names
import 'package:fast_food_cafe_grill/NavBar.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      Slide(
        title: "Discover Place",
        description:
            "We make it simple to find the food you crave. Enter your address and let",
        pathImage: "images/1.png",
        backgroundColor: const Color(0xFF3F51B5),
      ),
    );
    slides.add(
      Slide(
        title: "Pick your food ",
        description:
            "We make food ordering fast, simple and free - no matter if you order",
        pathImage: "images/3.png",
        backgroundColor: const Color(0xFF3F51B5),
      ),
    );
    slides.add(
      Slide(
        title: "Choose A Tasty ",
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        pathImage: "images/4.png",
        backgroundColor: const Color(0xFF3F51B5),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (ctx) => const NavBar()), (route) => false);

    // Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
    //   return const NavBar();
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      slides: slides,
      onDonePress: onDonePress,
    );
  }
}
