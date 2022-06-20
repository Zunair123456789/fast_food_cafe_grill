import 'package:fast_food_cafe_grill/Provider/Auth.dart';
import 'package:fast_food_cafe_grill/Provider/Cafe.dart';
import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Provider/Orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeDetailScreen extends StatelessWidget {
  final String CafeId;
  CafeDetailScreen(this.CafeId);

  @override
  Widget build(BuildContext context) {
    final cafe = Provider.of<Cafe>(context).findById();
    final cafeData = Provider.of<Cafe>(context, listen: false);
    final mediaQuery = MediaQuery.of(context).size;
    final name = Provider.of<Auth>(context).fname;
    return Scaffold(
        drawer: const Drawer(),
        appBar: AppBar(
            leading: const Icon(Icons.person),
            actions: [
              InkWell(
                onTap: () {
                  cafeData.cafeSelection('');
                  Provider.of<MenusProvider>(context, listen: false).cafeName =
                      cafeData.isSelected;
                  Provider.of<Order>(context, listen: false).cafeName =
                      cafeData.isSelected;
                },
                child: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Icon(Icons.change_circle_outlined)),
              ),
              InkWell(
                onTap: () {
                  Provider.of<MenusProvider>(context, listen: false)
                      .listhistory();
                  print(Provider.of<MenusProvider>(context, listen: false)
                      .historylist);
                },
                child: const Padding(
                    padding: EdgeInsets.all(10), child: Icon(Icons.circle)),
              ),
            ],
            toolbarHeight: 120,
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cafe.cafeName,
                  style: const TextStyle(color: Colors.white),
                ),
                Text('$name',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
              ],
            )),
        body: Container(
          width: mediaQuery.width,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: mediaQuery.height * 0.3,
                    child: Image.network(
                      cafe.cafeImageUrl,
                      fit: BoxFit.cover,
                    )),
                Container(
                    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: Text(
                      cafe.cafeDiscription,
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    )),
              ],
            ),
          ),
        ));
  }
}
