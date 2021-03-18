import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/pages/createLivraison/CreateLivraisonScreen.dart';
import 'package:url_launcher/url_launcher.dart';

class Body extends StatefulWidget {
  final press;
  const Body({Key key, this.press}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool displayNotif = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Stack(
            children: <Widget>[
              IconButton(
                  icon: Icon(displayNotif
                      ? Icons.notifications_active
                      : Icons.notifications_none),
                  onPressed: () {
                    setState(() {
                      displayNotif = false;
                    });
                  }),
              displayNotif
                  ? new Positioned(
                      right: 11,
                      top: 11,
                      child: new Container(
                        padding: EdgeInsets.all(2),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 14,
                          minHeight: 14,
                        ),
                        child: Text(
                          '!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : new Container()
            ],
          )
        ],
        centerTitle: true,
        title: Text("JUSTE LIVRER"),
        leading: IconButton(icon: Icon(Icons.sort), onPressed: widget.press),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.47,
                child: Card(
                  elevation: 8.0,
                  shadowColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: SvgPicture.asset(
                          'assets/images/welcome.svg',
                          height: MediaQuery.of(context).size.height * 0.3,
                        ),
                      ),
                      Positioned(
                        left: 35,
                        top: 30,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "EXPERTISE",
                              style: titleWhite(32),
                            ),
                            Text(
                              "Nous avons plus de",
                              style: subTitleWhite(16),
                            ),
                            Text(
                              "1000 point relais",
                              style: subTitleWhite(16),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  color: SecondaryColor,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.44,
                padding: EdgeInsets.all(5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[100]),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 10, top: 7),
                                child: Text(
                                  "Un Problème ?",
                                  style: subTitleBlack(18),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Text(
                                  "Vous pouvez contacter notre centre appel",
                                ),
                              ),
                            ],
                          )),
                          GestureDetector(
                            onTap: () {
                              launch("tel:+22507469765");
                            },
                            child: Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Container(
                                height: 45,
                                width: 45,
                                child: Center(
                                  child: Icon(Icons.call),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      height: 20,
                      child: Row(
                        children: <Widget>[
                          Text("Nos Services", style: title(17)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Divider(),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CreateLivraisonScreen(type: 0),
                                  ));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/images/034-scooter.svg',
                                    height: 60,
                                  ),
                                  Text(
                                    "Envoyer un Colis",
                                    textAlign: TextAlign.center,
                                    style: titleColorBlack(13),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CreateLivraisonScreen(type: 1),
                                  ));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey[100]),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SvgPicture.asset(
                                    'assets/images/005-clearance.svg',
                                    height: 60,
                                  ),
                                  Text(
                                    "Recevoir un Colis",
                                    textAlign: TextAlign.center,
                                    style: titleColorBlack(13),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
