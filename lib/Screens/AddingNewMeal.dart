import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddingNewMeal extends StatefulWidget {
  const AddingNewMeal({Key? key}) : super(key: key);

  @override
  _AddingNewMealState createState() => _AddingNewMealState();
}

class _AddingNewMealState extends State<AddingNewMeal> {
  final _priceFocusNode = FocusNode();
  final _discriptionFocusNode = FocusNode();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _discriptionFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adding new Meals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            child: ListView(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                Focus.of(context).requestFocus(_priceFocusNode);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Price'),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              focusNode: _priceFocusNode,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Discription'),
              keyboardType: TextInputType.multiline,
              maxLines: 3,
              focusNode: _discriptionFocusNode,
            ),
          ],
        )),
      ),
    );
  }
}
