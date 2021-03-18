import 'package:flutter/material.dart';
import 'package:juste_livrer/constant/Style.dart';

class CategorieTitle extends StatelessWidget {
  final String title;
  final bool active;
  final press;

  const CategorieTitle({Key key, this.title, this.active, this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: press,
        child: Padding(
          padding: EdgeInsets.only(left: 25.0, top: 15.0, right: 15.0),
          child: !active
              ? Text(title, style: menuSlideBarHistory(active))
              : Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: SecondaryColor, width: 1)),
                  child: Text(title, style: menuSlideBarHistory(active)),
                ),
        ));
  }
}
