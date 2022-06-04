import 'package:fast_food_cafe_grill/Provider/Cafe.dart';
import 'package:fast_food_cafe_grill/Widget/CafeList.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeUpdateScreen extends StatelessWidget {
  const CafeUpdateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void> _refreshMenu() async {
      await Provider.of<Cafe>(context, listen: false).fetchListOfCafes();
    }

    final cafeData = Provider.of<Cafe>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Your Menus'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
      ),
      body: RefreshIndicator(
        onRefresh: _refreshMenu,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: cafeData.listOfCafes.length,
            itemBuilder: (_, i) => Column(
              children: [
                CafeList(
                    cafeData.listOfCafes[i].cafeId,
                    cafeData.listOfCafes[i].cafeName,
                    cafeData.listOfCafes[i].cafeImageUrl),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
