// ignore_for_file: prefer_final_fields, file_names

import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Screens/ItemDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

import '../Widget/MenuWithType.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _init = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<MenusProvider>(context).fetchAndSetProduct().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    const textStyle = TextStyle(
        fontFamily: 'Quicksand', fontWeight: FontWeight.bold, fontSize: 20);
    var listItem = context.read<MenusProvider>().listByCategory('Deals');
    return Scaffold(
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SizedBox(
              height: MediaQuery.of(context).size.height -
                  NavigationToolbar.kMiddleSpacing -
                  MediaQuery.of(context).padding.top,
              child: SingleChildScrollView(
                // ignore: sized_box_for_whitespace
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    ImageSlideshow(
                      /// Width of the [ImageSlideshow].
                      width: double.infinity,

                      /// Height of the [ImageSlideshow].
                      height: 200,

                      /// The page to show when first creating the [ImageSlideshow].
                      initialPage: 0,

                      /// The color to paint the indicator.
                      indicatorColor: Colors.blue,

                      /// The color to paint behind th indicator.
                      indicatorBackgroundColor: Colors.grey,
                      children: [
                        ...List.generate(
                          listItem.length,
                          (i) => InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                ItemDetailScreen.routeName,
                                arguments: listItem[i].id,
                              );
                            },
                            child: Image.network(
                              listItem[i].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),

                    //.......................................................................................//////.....

                    const MenuWithType('Recommended'),
                    const MenuWithType('History'),
                  ],
                ),
              ),
            ),
    );
  }
}
