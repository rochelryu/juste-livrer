import 'package:flutter/material.dart';
import 'package:juste_livrer/ServicesWorker/ConsumeAPI.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/pages/history/history_screen.dart';
import 'package:juste_livrer/pages/profil/ProfilScreen.dart';

class CustomSlideBar extends StatelessWidget {
  String name;

  String picture;

  CustomSlideBar({Key key, String this.name, String this.picture})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PrimaryColor,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0)),
                    elevation: 6.0,
                    color: Colors.redAccent,
                    child: Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          image: DecorationImage(
                            image: NetworkImage(
                                '${ConsumeAPI.AssetProfilServer}$picture'),
                          ),
                        ))),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(name, style: subTitleWhite(15), maxLines: 2),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(
              color: PrimaryLigthColor,
            ),
          ),
          SizedBox(height: 10),
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, HistoryScreen.routeName);
              },
              leading: Icon(Icons.history, color: SecondaryColor),
              title:
                  Text("HISTORIQUE", style: TextStyle(color: SecondaryColor))),
          ListTile(
              onTap: () {
                Navigator.pushNamed(context, ProfilScreen.routeName);
              },
              leading: Icon(Icons.account_circle, color: SecondaryColor),
              title: Text("PROFIL", style: TextStyle(color: SecondaryColor))),
          ListTile(
              onTap: () {
                print("OK");
              },
              leading: Icon(Icons.textsms, color: SecondaryColor),
              title:
                  Text("SUGGESTION", style: TextStyle(color: SecondaryColor))),
          ListTile(
              onTap: () {
                print("ok");
              },
              leading: Icon(
                Icons.closed_caption,
                color: SecondaryColor,
              ),
              title: Text("A PROPOS", style: TextStyle(color: SecondaryColor))),
          ListTile(
              onTap: () {
                print("OK");
              },
              leading: Icon(Icons.keyboard_backspace, color: SecondaryColor),
              title:
                  Text("DECONNEXION", style: TextStyle(color: SecondaryColor))),
        ],
      ),
    );
  }
}
