import 'dart:math';

import 'package:fast_food_cafe_grill/ImagePicker/MenuImagePicker.dart';
import 'package:fast_food_cafe_grill/Provider/Menu.dart';
import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:fast_food_cafe_grill/Widget/CategoriesSelection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_tags/flutter_tags.dart';

class EditMenuScreen extends StatefulWidget {
  static String routeName = '/EditMenuScreen';

  @override
  _EditMenuScreenState createState() => _EditMenuScreenState();
}

class _EditMenuScreenState extends State<EditMenuScreen> {
  final _priceFocusNode = FocusNode();
  final _discriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();

  // ignore: prefer_final_fields
  var _editedMenu = Menu(
    id: '',
    title: '',
    imageUrl: '',
    price: 0,
    categories: [],
    description: '',
  );
  var initValue = {
    'title': "",
    'description': "",
    'price': "",
    'imageUrl': "",
  };
  var _isInit = true;
  var _isLoading = false;
  var _isExpanded = false;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);

    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final menuId = ModalRoute.of(context)!.settings.arguments as String;
      // ignore: unnecessary_null_comparison
      if (menuId != '') {
        _editedMenu =
            Provider.of<MenusProvider>(context, listen: false).findById(menuId);
        initValue = {
          'title': _editedMenu.title,
          'description': _editedMenu.description,
          'price': _editedMenu.price.toString(),

          // 'imageUrl': _editedMenu.imageUr
        };

        Provider.of<MenusProvider>(context).tempList = _editedMenu.categories;
        _imageUrlController.text = _editedMenu.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus ||
        !_imageUrlController.text.endsWith('.jpg') ||
        !_imageUrlController.text.endsWith('.png') ||
        !_imageUrlController.text.endsWith('.jpeg')) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _discriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();
    final data =
        await Provider.of<MenusProvider>(context, listen: false).tempList;

    if (!isValid) {
      return;
    }

    if (data.isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Categories Check'),
              content: const Text('Please add some categories '),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      return;
                    },
                    child: const Text('Okay'))
              ],
            );
          });
      return;
    }

    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    if (_editedMenu.id != '') {
      await Provider.of<MenusProvider>(context, listen: false)
          .updateMenu(_editedMenu.id, _editedMenu);
      setState(() {
        _isLoading = false;
        Navigator.of(context).pop();
      });
    } else {
      try {
        await Provider.of<MenusProvider>(context, listen: false)
            .addMenu(_editedMenu);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('An error  occurred'),
                content: const Text('Something went wrong.'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Okay'))
                ],
              );
            });
        // }
        // finally {
        //   setState(() {
        //     _isLoading = false;
        //   });

      }
      _isLoading = false;
      Navigator.of(context).pop();
    }
  }

  // final _listOfCatogries = [
  //   'Everyday Value',
  //   'Make it a Meal',
  //   'Signature Box',
  //   'Sharing',
  //   'Mid Night Deals',
  //   'Snacks'
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Adding new Meals'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading == true
          ? const Center(
              child: CircularProgressIndicator(
                color: Color.fromARGB(255, 41, 69, 163),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: initValue['title'],
                        decoration: const InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          Focus.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (value) {
                          _editedMenu = Menu(
                              id: _editedMenu.id,
                              title: value.toString(),
                              imageUrl: _editedMenu.imageUrl,
                              price: _editedMenu.price,
                              description: _editedMenu.description,
                              categories: _editedMenu.categories,
                              isFavorite: _editedMenu.isFavorite);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a valid Title';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        initialValue: initValue['price'],
                        decoration: const InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onSaved: (value) {
                          _editedMenu = Menu(
                              id: _editedMenu.id,
                              title: _editedMenu.title,
                              imageUrl: _editedMenu.imageUrl,
                              price: double.parse(value!),
                              description: _editedMenu.description,
                              categories: _editedMenu.categories,
                              isFavorite: _editedMenu.isFavorite);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a  Price';
                          }
                          if (double.parse(value) <= 0) {
                            return 'Please Provide a Number Greater than 0';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please provide a Valid Number ';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: initValue['description'],
                        decoration:
                            const InputDecoration(labelText: 'Discription'),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        focusNode: _discriptionFocusNode,
                        onSaved: (value) {
                          _editedMenu = Menu(
                              id: _editedMenu.id,
                              title: _editedMenu.title,
                              imageUrl: _editedMenu.imageUrl,
                              price: _editedMenu.price,
                              description: value.toString(),
                              categories: _editedMenu.categories,
                              isFavorite: _editedMenu.isFavorite);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a valid Discription';
                          }
                          if (value.length < 20) {
                            return 'Discription should be at least 20 charater long';
                          } else {
                            return null;
                          }
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(top: 8, right: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: _imageUrlController.text.isEmpty
                                ? const Text(
                                    'Enter a Url',
                                    textAlign: TextAlign.center,
                                  )
                                : FittedBox(
                                    child: Image.network(
                                      _imageUrlController.text,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                          ),
                          Expanded(
                            child: TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'ImageUrl'),
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,
                              controller: _imageUrlController,
                              focusNode: _imageUrlFocusNode,
                              onFieldSubmitted: (_) {
                                _saveForm();
                              },
                              onSaved: (value) {
                                _editedMenu = Menu(
                                    id: _editedMenu.id,
                                    title: _editedMenu.title,
                                    imageUrl: value.toString(),
                                    price: _editedMenu.price,
                                    description: _editedMenu.description,
                                    categories: _editedMenu.categories,
                                    isFavorite: _editedMenu.isFavorite);
                              },
                              validator: (value) {
                                bool validURL =
                                    Uri.parse(value.toString()).host == ''
                                        ? true
                                        : false;
                                if (validURL) {
                                  return 'Please provide a ImageUrl';
                                }
                                if (!value!.endsWith('.jpg') &&
                                    !value.endsWith('.png') &&
                                    !value.endsWith('.jpeg')) {
                                  return 'Please add a valid Image Url';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ],
                      ),

                      MenuImagePicker(),

//..........................................................................................................................................

                      ListTile(
                        title: const Text('Categories'),
                        subtitle: const Text(
                          'Select the Categories',
                          style: TextStyle(color: Colors.black54),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          icon: Icon(
                            _isExpanded ? Icons.expand_less : Icons.expand_more,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      _isExpanded
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 0),
                              height: min(
                                  Provider.of<MenusProvider>(context)
                                              .listOfCategories
                                              .length *
                                          20.0 +
                                      10,
                                  123.0),
                              child: ListView.builder(
                                  itemCount: Provider.of<MenusProvider>(context,
                                          listen: false)
                                      .listOfCategories
                                      .length,
                                  itemBuilder: (ctx, index) {
                                    return CategoriesSelection(
                                        category: Provider.of<MenusProvider>(
                                                context,
                                                listen: false)
                                            .listOfCategories[index]);
                                  }),
                            )
                          : Container()
//........................................................................................................................
                    ],
                  )),
            ),
    );
  }
}
