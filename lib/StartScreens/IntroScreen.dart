// ignore_for_file: prefer_final_fields, file_names
import 'package:fast_food_cafe_grill/NavBar.dart';
import 'package:fast_food_cafe_grill/Provider/Auth.dart';
import 'package:fast_food_cafe_grill/Screens/SplashScreen.dart';
import 'package:fast_food_cafe_grill/Screens/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<ContentConfig> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      ContentConfig(
        title: "Discover Place",
        description:
            "We make it simple to find the food you crave. Enter your address and let",
        pathImage: "images/1.png",
        backgroundColor: const Color(0xFF3F51B5),
      ),
    );
    slides.add(
      ContentConfig(
        title: "Pick your food ",
        description:
            "We make food ordering fast, simple and free - no matter if you order",
        pathImage: "images/3.png",
        backgroundColor: const Color(0xFF3F51B5),
      ),
    );
    slides.add(
      const ContentConfig(
        title: "Choose A Tasty ",
        description: "Avoid the lines and have Fast food delivered by us",
        pathImage: "images/4.png",
        backgroundColor: Color(0xFF3F51B5),
      ),
    );
  }

  void onDonePress() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (ctx) => Consumer<Auth>(
                builder: (ctx, auth, _) => auth.isAuth
                    ? const NavBar()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) =>
                            authResultSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? const SplashScreen()
                                : AuthScreen()))),
        (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return IntroSlider(
      listContentConfig: slides,
      onDonePress: onDonePress,
    );
  }
}
