import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Screens/EditMenuScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeList extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  CafeList(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        overflow: TextOverflow.fade,
      ),
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor,
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 50,
        child: IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: const Text(
                          'Are you sure?',
                        ),
                        content: const Text(
                            'Do you want to remove item from the Cart?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                              },
                              child: const Text('No')),
                          TextButton(
                              onPressed: () {
                                Provider.of<MenusProvider>(context,
                                        listen: false)
                                    .deleteMenuItem(id, title);
                                Navigator.of(ctx).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Item is successfully deleted'),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              child: const Text('Yes')),
                        ],
                      ));
            },
            icon: Icon(
              Icons.delete,
              color: Theme.of(context).errorColor,
            )),
      ),
    );
  }
}
