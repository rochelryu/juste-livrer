import 'package:flutter/material.dart';
import 'package:juste_livrer/constant/Style.dart';

import 'DetaisForLivreur.dart';

class ShowLivreur extends StatefulWidget {
  @override
  _ShowLivreurState createState() => _ShowLivreurState();
}

class _ShowLivreurState extends State<ShowLivreur> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(height: 10),
        title: Text("Vos livraisons d'aujourd'hui", style: titleColorBlack(16)),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: ListView.builder(
          itemCount: 7,
          itemBuilder: (context, index) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsForLivreur(),
                          ));
                    },
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Card(
                          color: PrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 3),
                              child: Text("1000 frs", style: titleWhite(12))),
                        )
                      ],
                    ),
                    leading: Container(
                      width: 70,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                            image:
                                AssetImage('assets/images/Profile Image.png'),
                          ),
                          shape: BoxShape.circle,
                          border: Border.all(color: SecondaryColor)),
                    ),
                    isThreeLine: true,
                    title: Text('Mohamed salam',
                        style: subTitleBlack(15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(Icons.location_on, color: PrimaryColor),
                            SizedBox(width: 5),
                            Text("Rivera Palmeraie")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Icon(Icons.call, color: PrimaryColor),
                            SizedBox(width: 5),
                            Text("48803377")
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider()
                ],
              ),
            );
          }),
    );
  }
}
