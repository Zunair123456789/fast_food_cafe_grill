import 'package:fast_food_cafe_grill/Provider/Cafe.dart';
import 'package:fast_food_cafe_grill/Provider/Menu_Provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CafeTile extends StatelessWidget {
  // final String cafeData;

  // CafeTile(this.cafeData);
  @override
  Widget build(BuildContext context) {
    final cafeData = Provider.of<CafeItem>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // color: Colors.amberAccent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.23,
        child: Card(
          elevation: 4,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: InkWell(
              focusColor: Theme.of(context).primaryColor,
              onTap: () {
                Provider.of<Cafe>(context, listen: false)
                    .cafeSelection(cafeData.cafeId);
                Provider.of<MenusProvider>(context, listen: false).cafeName =
                    cafeData.cafeName;
                Provider.of<MenusProvider>(context, listen: false)
                    .fetchAndSetProduct();
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        topLeft: Radius.circular(20)),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.23,
                        child: Image.network(
                          cafeData.cafeImageUrl,
                          alignment: Alignment.centerLeft,
                          fit: BoxFit.fill,
                        )),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                          ),
                          child: Text(
                            cafeData.cafeName,
                            style: Theme.of(context).textTheme.subtitle1,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 4,
                          ),
                          child: Text(
                            cafeData.cafeDiscription,
                            style: Theme.of(context).textTheme.bodyMedium,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
