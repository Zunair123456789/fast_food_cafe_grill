// ignore_for_file: file_names

import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class ItemDetailScreen extends StatelessWidget {
  static String routeName = '/product-detail';

  const ItemDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context)!.settings.arguments as String;
    final listItem =
        Provider.of<MenusProvider>(context, listen: false).findById(itemId);
    // final listItem2 = context.read<MenusProvider>().findById(itemId);
    // print('object');
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      listItem.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Positioned(
                      top: 10,
                      left: 10,
                      child: InkWell(
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                          size: 30,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ))
                ],
              ),
              const SizedBox(height: 10),
              Text(
                listItem.title,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Container(
                height: 200,
                child: ListView.builder(
                    itemCount: listItem.categories.length,
                    itemBuilder: (ctx, index) =>
                        Text(listItem.categories[index])),
              )
            ],
          ),
        ),
      ),
    );
  }
}
