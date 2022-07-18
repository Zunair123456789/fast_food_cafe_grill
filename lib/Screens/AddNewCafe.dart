import 'dart:io';

import 'package:fast_food_cafe_grill/Provider/Cafe.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewCafe extends StatefulWidget {
  const AddNewCafe({Key? key}) : super(key: key);

  @override
  State<AddNewCafe> createState() => _AddNewCafeState();
}

class _AddNewCafeState extends State<AddNewCafe> {
  final _discriptionFocusNode = FocusNode();
  bool _isLoading = false;

  final _form = GlobalKey<FormState>();

  var _editedMenu = CafeItem(
    cafeId: '',
    cafeName: '',
    cafeDiscription: '',
    cafeImageUrl: '',
    cafephone: '',
    cafeMail: '',
    cafefacebook: '',
  );

  Future<void> _saveForm() async {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }

    if (_pickedImage == null) {
      showDialog(
          context: context,
          builder: (ctx) {
            return ErrorDialog('Image', 'Please add an image for menu');
          });
      return;
    }

    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Cafe>(context, listen: false).addMenu(_editedMenu);
    } catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) {
            return ErrorDialog(
                'An error occured', 'Please add some categories ');
          });
    }
    _isLoading = false;
    Navigator.of(context).pop();
  }

  File? _pickedImage;
  void _pickImage() async {
    final pickedImageFile =
        await ImagePicker.platform.getImage(source: ImageSource.gallery);
    setState(() {
      _pickedImage = File(pickedImageFile!.path);
    });
    Provider.of<Cafe>(context, listen: false).pickedImage = _pickedImage;
  }

  @override
  void dispose() {
    _discriptionFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('Adding New Cafe'),
        actions: [
          IconButton(onPressed: _saveForm, icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Cafe Name'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          Focus.of(context).requestFocus(_discriptionFocusNode);
                        },
                        onSaved: (value) {
                          _editedMenu = CafeItem(
                            cafeId: _editedMenu.cafeId,
                            cafeName: value.toString(),
                            cafeDiscription: _editedMenu.cafeDiscription,
                            cafeImageUrl: _editedMenu.cafeImageUrl,
                            cafeMail: _editedMenu.cafeMail,
                            cafefacebook: _editedMenu.cafephone,
                            cafephone: _editedMenu.cafephone,
                          );
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
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                            labelText: 'Cafe phone', prefixText: '+92'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          Focus.of(context).requestFocus(_discriptionFocusNode);
                        },
                        onSaved: (value) {
                          _editedMenu = CafeItem(
                            cafeId: _editedMenu.cafeId,
                            cafeName: _editedMenu.cafeName,
                            cafeDiscription: _editedMenu.cafeDiscription,
                            cafeImageUrl: _editedMenu.cafeImageUrl,
                            cafeMail: _editedMenu.cafeMail,
                            cafefacebook: _editedMenu.cafephone,
                            cafephone: value.toString(),
                          );
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
                        decoration:
                            const InputDecoration(labelText: 'Facebook Id'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          Focus.of(context).requestFocus(_discriptionFocusNode);
                        },
                        onSaved: (value) {
                          _editedMenu = CafeItem(
                            cafeId: _editedMenu.cafeId,
                            cafeName: _editedMenu.cafeName,
                            cafeDiscription: _editedMenu.cafeDiscription,
                            cafeImageUrl: _editedMenu.cafeImageUrl,
                            cafeMail: _editedMenu.cafeMail,
                            cafefacebook: value.toString(),
                            cafephone: _editedMenu.cafephone,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a valid phone number';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Email'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          Focus.of(context).requestFocus(_discriptionFocusNode);
                        },
                        onSaved: (value) {
                          _editedMenu = CafeItem(
                            cafeId: _editedMenu.cafeId,
                            cafeName: _editedMenu.cafeName,
                            cafeDiscription: _editedMenu.cafeDiscription,
                            cafeImageUrl: _editedMenu.cafeImageUrl,
                            cafeMail: value.toString(),
                            cafefacebook: _editedMenu.cafefacebook,
                            cafephone: _editedMenu.cafephone,
                          );
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide a valid email';
                          }
                          if (!value.contains('@')) {
                            return 'Please provide a valid email';
                          } else {
                            return null;
                          }
                        },
                      ),

                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Discription'),
                        keyboardType: TextInputType.multiline,
                        maxLines: 3,
                        focusNode: _discriptionFocusNode,
                        onSaved: (value) {
                          _editedMenu = _editedMenu = CafeItem(
                            cafeId: _editedMenu.cafeId,
                            cafeName: _editedMenu.cafeName,
                            cafeDiscription: value.toString(),
                            cafeImageUrl: _editedMenu.cafeImageUrl,
                            cafeMail: _editedMenu.cafeMail,
                            cafefacebook: _editedMenu.cafephone,
                            cafephone: _editedMenu.cafephone,
                          );
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

                      Column(
                        children: [
                          Container(
                              width: 200,
                              height: 200,
                              margin: const EdgeInsets.only(top: 8, right: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 1, color: Colors.grey)),
                              child: _pickedImage == null
                                  ? const Center(child: Text('Add Image'))
                                  : Image.file(
                                      _pickedImage!,
                                    )),
                          Center(
                            child: TextButton.icon(
                              icon: const Icon(Icons.image),
                              label: const Text('Add image'),
                              onPressed: () {
                                _pickImage();
                              },
                              style: TextButton.styleFrom(
                                  primary: Theme.of(context).primaryColor),
                            ),
                          ),
                        ],
                      ),

//..........................................................................................................................................

//........................................................................................................................
                    ],
                  )),
            ),
    );
  }
}

class ErrorDialog extends StatelessWidget {
  final String title;
  final String content;
  ErrorDialog(this.title, this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Okay'))
      ],
    );
  }
}
