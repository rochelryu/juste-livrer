import 'package:flutter/material.dart';
import 'package:juste_livrer/Models/User.dart';
import 'package:juste_livrer/ServicesWorker/ConsumeAPI.dart';
import 'package:juste_livrer/Utils/Database.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/constant/WidgetCommon.dart';
import 'package:juste_livrer/pages/livreurHome/components/DetailsLivraison.dart';

import 'components/ListLivraison.dart';

class HistoryScreen extends StatefulWidget {
  static String routeName = "/history";

  HistoryScreen({Key key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin {
  TabController _controller;
  List<bool> activate = [true, false, false, false];
  Map<dynamic, dynamic> info;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 3, vsync: this);
    getNewLevel();
  }

  Future getNewLevel() async {
    User user = await DBProvider.db.getClient();
    final data = await new ConsumeAPI().getHistory(user.ident, user.recovery);
    setState(() {
      info = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HISTORIQUE'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 60,
            width: double.infinity,
            child: new TabBar(
              controller: _controller,
              unselectedLabelColor: PrimaryLigthColor,
              labelColor: SecondaryColor,
              indicatorColor: SecondaryColor,
              tabs: [
                new Tab(
                  text: 'Aujourd\'hui',
                ),
                new Tab(
                  text: 'Livraison',
                ),
                new Tab(
//icon: const Icon(Icons.shopping_cart),
                  text: 'Reception',
                ),
              ],
            ),
          ),
          Expanded(
            child: new TabBarView(
              controller: _controller,
              children: <Widget>[
                info != null
                    ? ListLivraison(info['result']['livraisonForClientToDay'])
                    : IsLoadingData(),
                info != null
                    ? ListLivraison(info['result']['livraison'])
                    : IsLoadingData(),
                info != null
                    ? ListLivraison(info['result']['reception'])
                    : IsLoadingData(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContentOne extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsLivraison(id: '5bgdgd'),
                  ));
            },
            child: Container(
              margin: EdgeInsets.only(left: 25),
              width: 250,
              height: 350,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                        height: 320,
                        width: 225,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(34),
                            color: SecondaryColor.withOpacity(.18))),
                  ),
                  Positioned(
                    top: 7,
                    left: 7,
                    child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: PrimaryColor.withOpacity(.48))),
                  ),
                  Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        height: 130,
                        width: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("assets/images/piz.jpg")),
                        ),
                      )),
                  Positioned(
                      right: 20,
                      top: 60,
                      child: Text(
                        "5 000 Frs",
                        style: subTitleBlack(15),
                      )),
                  Positioned(
                      left: 30,
                      top: 140,
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Pizza Boloeisnne",
                            style: title(18),
                          ),
                          Text("En cours de livraison"),
                          Container(
                            margin: EdgeInsets.only(top: 10, left: 5),
                            width: 210,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Lieu de livraison: Rivera Palmeraie Ancien Camps",
                                  style: simpleTextBlackOpacity(13),
                                ),
                                Text("Livreur: John Doe",
                                    style: simpleTextBlackOpacity(13),
                                    maxLines: 1),
                                Text(
                                  "Nom & Contact: Belem Vladmir, +225 48803377",
                                  style: simpleTextBlackOpacity(13),
                                ),
                                Text("Date de livraison: Pas encore livré",
                                    style: simpleTextBlackOpacity(13),
                                    maxLines: 1),
                              ],
                            ),
                          )
                        ],
                      )),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            width: 250,
            height: 350,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                      height: 320,
                      width: 225,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(34),
                          color: SecondaryColor.withOpacity(.18))),
                ),
                Positioned(
                  top: 7,
                  left: 7,
                  child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PrimaryColor.withOpacity(.48))),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/ps4_console_blue_3.png")),
                      ),
                    )),
                Positioned(
                    right: 20,
                    top: 60,
                    child: Text(
                      "5 000 Frs",
                      style: subTitleBlack(15),
                    )),
                Positioned(
                    left: 30,
                    top: 140,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Manette PS4",
                          style: title(18),
                        ),
                        Text("Déjà"),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 5),
                          width: 210,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Lieu de livraison: Rivera Palmeraie Ancien Camps",
                                style: simpleTextBlackOpacity(13),
                              ),
                              Text("Livreur: John Doe",
                                  style: simpleTextBlackOpacity(13),
                                  maxLines: 1),
                              Text(
                                "Nom & Contact: Belem Vladmir, +225 48803377",
                                style: simpleTextBlackOpacity(13),
                              ),
                              Text("Date de livraison: Pas encore livré",
                                  style: simpleTextBlackOpacity(13),
                                  maxLines: 1),
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            width: 250,
            height: 350,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                      height: 320,
                      width: 225,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(34),
                          color: SecondaryColor.withOpacity(.18))),
                ),
                Positioned(
                  top: 7,
                  left: 7,
                  child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PrimaryColor.withOpacity(.48))),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/shoes2.png")),
                      ),
                    )),
                Positioned(
                    right: 20,
                    top: 60,
                    child: Text(
                      "5 000 Frs",
                      style: subTitleBlack(15),
                    )),
                Positioned(
                    left: 30,
                    top: 140,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Nike Air 2020",
                          style: title(18),
                        ),
                        Text("Pas encore livré"),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 5),
                          width: 210,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Lieu de livraison: Rivera Palmeraie Ancien Camps",
                                style: simpleTextBlackOpacity(13),
                              ),
                              Text("Livreur: John Doe",
                                  style: simpleTextBlackOpacity(13),
                                  maxLines: 1),
                              Text(
                                "Nom & Contact: Belem Vladmir, +225 48803377",
                                style: simpleTextBlackOpacity(13),
                              ),
                              Text("Date de livraison: Pas encore livré",
                                  style: simpleTextBlackOpacity(13),
                                  maxLines: 1),
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            width: 250,
            height: 350,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                      height: 320,
                      width: 225,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(34),
                          color: SecondaryColor.withOpacity(.18))),
                ),
                Positioned(
                  top: 7,
                  left: 7,
                  child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PrimaryColor.withOpacity(.48))),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/tshirt.png")),
                      ),
                    )),
                Positioned(
                    right: 20,
                    top: 60,
                    child: Text(
                      "5 000 Frs",
                      style: subTitleBlack(15),
                    )),
                Positioned(
                    left: 30,
                    top: 140,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "tshirt Orange",
                          style: title(18),
                        ),
                        Text("En cours de livraison"),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 5),
                          width: 210,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Lieu de livraison: Rivera Palmeraie Ancien Camps",
                                style: simpleTextBlackOpacity(13),
                              ),
                              Text("Livreur: John Doe",
                                  style: simpleTextBlackOpacity(13),
                                  maxLines: 1),
                              Text(
                                "Nom & Contact: Belem Vladmir, +225 48803377",
                                style: simpleTextBlackOpacity(13),
                              ),
                              Text("Date de livraison: Pas encore livré",
                                  style: simpleTextBlackOpacity(13),
                                  maxLines: 1),
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 25),
            width: 250,
            height: 350,
            child: Stack(
              children: <Widget>[
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                      height: 320,
                      width: 225,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(34),
                          color: SecondaryColor.withOpacity(.18))),
                ),
                Positioned(
                  top: 7,
                  left: 7,
                  child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: PrimaryColor.withOpacity(.48))),
                ),
                Positioned(
                    top: 0,
                    left: 0,
                    child: Container(
                      height: 130,
                      width: 130,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                                "assets/images/wireless headset.png")),
                      ),
                    )),
                Positioned(
                    right: 20,
                    top: 60,
                    child: Text(
                      "5 000 Frs",
                      style: subTitleBlack(15),
                    )),
                Positioned(
                    left: 30,
                    top: 140,
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Ecouteur Setreo OneX",
                          style: title(18),
                        ),
                        Text("En cours de livraison"),
                        Container(
                          margin: EdgeInsets.only(top: 10, left: 5),
                          width: 210,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Lieu de livraison: Rivera Palmeraie Ancien Camps",
                                style: simpleTextBlackOpacity(13),
                              ),
                              Text("Livreur: John Doe",
                                  style: simpleTextBlackOpacity(13),
                                  maxLines: 1),
                              Text(
                                "Nom & Contact: Belem Vladmir, +225 48803377",
                                style: simpleTextBlackOpacity(13),
                              ),
                              Text("Date de livraison: Pas encore livré",
                                  style: simpleTextBlackOpacity(13),
                                  maxLines: 1),
                            ],
                          ),
                        )
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContentTwo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Text(
          "Aucune Information pour le moment",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ContentThree extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Text("Aucune Information pour le moment 2"),
      ),
    );
  }
}

class ContentFour extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.6,
      child: Center(
        child: Text("Aucune Information pour le moment 3"),
      ),
    );
  }
}
