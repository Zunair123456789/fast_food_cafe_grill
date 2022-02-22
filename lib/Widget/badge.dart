import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  Badge({
    Key? key,
    required this.child,
    required this.value,
  }) : super(key: key);

  final Widget child;
  final String value;
  Color color = const Color(0xFF3F51B5);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        Positioned(
          right: 3,
          top: 3,
          child: Container(
            padding: const EdgeInsets.all(2.0),
            // color: Theme.of(context).accentColor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color != null ? color : Theme.of(context).primaryColor,
            ),
            constraints: const BoxConstraints(
              minWidth: 16,
              minHeight: 16,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
              ),
            ),
          ),
        )
      ],
    );
  }
}
