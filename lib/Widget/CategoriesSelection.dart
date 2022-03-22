import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesSelection extends StatefulWidget {
  final String category;

  const CategoriesSelection({Key? key, required this.category})
      : super(key: key);

  @override
  State<CategoriesSelection> createState() => _CategoriesSelectionState();
}

class _CategoriesSelectionState extends State<CategoriesSelection> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<MenusProvider>(context);
    bool _isCheck = data.tempList.contains(widget.category);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.category),
            Checkbox(
                value: _isCheck,
                onChanged: (val) {
                  setState(() {
                    setState(() {
                      _isCheck = !_isCheck;
                      if (_isCheck) {
                        data.addDataToTemop(widget.category);
                      } else {
                        data.tempList.remove(widget.category);
                      }
                    });
                  });
                })
          ],
        )
      ],
    );
  }
}
