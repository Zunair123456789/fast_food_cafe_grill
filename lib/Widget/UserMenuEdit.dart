import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Screens/EditMenuScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserMenuEdit extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  UserMenuEdit(this.id, this.title, this.imageUrl);

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
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(EditMenuScreen.routeName, arguments: id);
                },
                icon: Icon(
                  Icons.edit,
                  color: Theme.of(context).primaryColor,
                )),
            IconButton(
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
                                        .deleteMenuItem(id);
                                    Navigator.of(ctx).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Item is successfully deleted'),
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
                ))
          ],
        ),
      ),
    );
  }
}
