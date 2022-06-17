import 'package:fast_food_cafe_grill/NavBar.dart';
import 'package:fast_food_cafe_grill/Provider/Auth.dart';
import 'package:fast_food_cafe_grill/Provider/Cafe.dart';
import 'package:fast_food_cafe_grill/Screens/Location_Map.dart';
import 'package:fast_food_cafe_grill/Screens/SplashScreen.dart';
import 'package:fast_food_cafe_grill/Screens/auth_screen.dart';
import 'package:fast_food_cafe_grill/StartScreens/IntroScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:fast_food_cafe_grill/Provider/Cart.dart';
import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Provider/Orders.dart';
import 'package:fast_food_cafe_grill/Screens/EditMenuScreen.dart';
import 'package:fast_food_cafe_grill/Screens/ItemDetailScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cafe(),
        ),
        ChangeNotifierProxyProvider<Auth, MenusProvider>(
          create: (ctx) => MenusProvider('', '', []),
          update: (ctx, auth, previousItemList) => MenusProvider(
              auth.token ?? '',
              auth.userId ?? '',
              previousItemList == null ? [] : previousItemList.listOfMeal),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Order(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF3F51B5),
        // primarySwatch: Color(0xFF3F51B5),
        // ignore: deprecated_member_use
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
            subtitle1: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            subtitle2: const TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.normal,
              fontSize: 18,
            )),
      ),
      home: NavBar(),
      // Consumer<Auth>(
      //     builder: (ctx, auth, _) => auth.isAuth
      //         ? const NavBar()
      //         : FutureBuilder(
      //             future: auth.tryAutoLogin(),
      //             builder: (ctx, authResultSnapshot) =>
      //                 authResultSnapshot.connectionState ==
      //                         ConnectionState.waiting
      //                     ? const SplashScreen()
      //                     : const IntroScreen())),
      //  MenuUpdateScreen(),
      // const IntroScreen(),
      routes: {
        ItemDetailScreen.routeName: (ctx) => const ItemDetailScreen(),
        EditMenuScreen.routeName: (ctx) => EditMenuScreen(),
      },
    );
  }
}
