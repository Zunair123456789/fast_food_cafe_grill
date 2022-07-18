import 'package:fast_food_cafe_grill/Provider/Auth.dart';
import 'package:fast_food_cafe_grill/Provider/Cafe.dart';
import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
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
  Future<void> didChangeDependencies() async {
    if (_init) {
      setState(() {
        _isLoading = true;
      });

      await Provider.of<Cafe>(context, listen: false)
          .fetchListOfCafes()
          .then((value) => _isLoading = false);
    }
    _init = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final listOfcafe = Provider.of<Cafe>(context, listen: false).listOfCafes;
    final cafe = Provider.of<Cafe>(context, listen: false);
    final name = Provider.of<Auth>(context, listen: false).fname;
    return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: true,
            leading: const Icon(Icons.person),
            // actions: [
            //   InkWell(
            //     onTap: () {},
            //     child: const Padding(
            //         padding: EdgeInsets.all(10),
            //         child: Icon(Icons.favorite_outline)),
            //   ),
            //   const Padding(
            //     padding: EdgeInsets.all(10.0),
            //     child: Icon(Icons.card_travel),
            //   )
            // ],
            toolbarHeight: 120,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Home',
                  style: TextStyle(color: Colors.white),
                ),
                Text(name ?? '',
                    style: const TextStyle(color: Colors.white, fontSize: 12)),
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
