import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:juste_livrer/constant/Style.dart';

Widget DialogCustomError(String title, String message, BuildContext context) {
  bool isIos = Platform.isIOS;
  return isIos
      ? new CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        )
      : new AlertDialog(
          title: Text(title),
          content: Text(message),
          elevation: 20.0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          actions: <Widget>[
            FlatButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        );
}

Widget ViewInfoPersonel(
  String name,
  String address,
  String number,
  String email,
) {
  return Padding(
    padding: EdgeInsets.only(left: 10),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(name.toUpperCase(), style: subTitleBlack(15)),
        SizedBox(height: 12),
        Row(
          children: <Widget>[
            Icon(Icons.location_on, color: PrimaryLigthColor),
            Text(address),
          ],
        ),
        SizedBox(height: 7),
        Row(
          children: <Widget>[
            Icon(Icons.call, color: PrimaryLigthColor),
            Text(number),
          ],
        ),
        SizedBox(height: 7),
        Row(
          children: <Widget>[
            Icon(Icons.mail, color: PrimaryLigthColor),
            Text(email),
          ],
        ),
      ],
    ),
  );
}

Widget IsLoadingData() {
  return Center(
    child: Container(
      height: 50,
      width: 50,
      child: CircularProgressIndicator(),
    ),
  );
}
