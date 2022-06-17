import 'package:fast_food_cafe_grill/Provider/Cafe.dart';
import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Screens/CafeDetailScreen.dart';
import 'package:fast_food_cafe_grill/Widget/CafeTile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeSelection extends StatefulWidget {
  @override
  State<CafeSelection> createState() => _CafeSelectionState();
}

class _CafeSelectionState extends State<CafeSelection> {
  var _init = true;

  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_init) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<MenusProvider>(context)
          .fetchAndSetProduct()
          .then((value) async {
        await Provider.of<Cafe>(context, listen: false).fetchListOfCafes().then(
            (value) => Provider.of<MenusProvider>(context, listen: false)
                    .fetchAndSetProduct()
                    .then((value) {
                  setState(() {
                    _isLoading = false;
                  });
                }));
      });
    }
    _init = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final listOfcafe = Provider.of<Cafe>(context, listen: false).listOfCafes;
    final cafe = Provider.of<Cafe>(context, listen: false);
    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
            actions: [
              InkWell(
                onTap: () {},
                child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.favorite_outline)),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Icon(Icons.card_travel),
              )
            ],
            toolbarHeight: 120,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
                Text('Username',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            )),
        body: _isLoading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    ...List.generate(
                      listOfcafe.length,
                      (i) => ChangeNotifierProvider.value(
                        value: listOfcafe[i],
                        child: CafeTile(),
                      ),
                    ),
                    const SizedBox(
                      height: 55,
                    )
                  ],
                ),
              ));
  }
}
