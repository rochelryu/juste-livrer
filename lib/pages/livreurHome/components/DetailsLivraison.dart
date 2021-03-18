import 'package:flutter/material.dart';
import 'package:juste_livrer/Models/User.dart';
import 'package:juste_livrer/ServicesWorker/ConsumeAPI.dart';
import 'package:juste_livrer/Utils/Database.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DetailsLivraison extends StatefulWidget {
  String id;
  DetailsLivraison({@required this.id});

  @override
  _DetailsLivraisonState createState() => _DetailsLivraisonState();
}

class _DetailsLivraisonState extends State<DetailsLivraison> {
  User newClient;
  Map<dynamic, dynamic> user;
  bool inWait = true;

  @override
  void initState() {
    super.initState();
    // getNewLevel();
  }

  Future getNewLevel() async {
    User user = await DBProvider.db.getClient();
    final data =
        await new ConsumeAPI().getAllInfoProfil(user.ident, user.recovery);
    setState(() {
      newClient = user;
      this.user = data;
    });
    print("Le client ${newClient.name}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Moghamed Salam'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 100,
              color: Colors.grey[100],
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Nº COMMANDE"),
                        Text("#789809", style: subTitleBlack(15)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Nº LIVREUR"),
                        Text("48803377", style: subTitleBlack(15)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("MONTRANT"),
                        Text("1500 F cfa", style: subTitleBlack(15)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: <Widget>[
                      TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.1,
                        isFirst: true,
                        indicatorStyle: IndicatorStyle(
                          width: 20,
                          color: Color(0xFF27AA69),
                          padding: EdgeInsets.all(6),
                        ),
                        endChild: const _RightChild(
                          disabled: true,
                          asset: 'assets/images/everywhere.png',
                          title: 'En attente de livreur',
                          message:
                              'Recherche livreur le plus proche du point de depart',
                        ),
                        beforeLineStyle: LineStyle(
                          color: Color(0xFF27AA69),
                        ),
                      ),
                      TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.1,
                        indicatorStyle: IndicatorStyle(
                          width: 20,
                          color: Color(0xFF27AA69),
                          padding: EdgeInsets.all(6),
                        ),
                        endChild: const _RightChild(
                          disabled: true,
                          asset: 'assets/images/033-envelope.png',
                          title: 'Point de depart',
                          message:
                              'Livreur arrivé. Recupération de 1000 frs et du colis',
                        ),
                        beforeLineStyle: LineStyle(
                          color: inWait ? PrimaryLigthColor : Color(0xFF27AA69),
                        ),
                      ),
                      TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.1,
                        indicatorStyle: IndicatorStyle(
                          width: 20,
                          color: inWait ? PrimaryLigthColor : Color(0xFF27AA69),
                          padding: EdgeInsets.all(6),
                        ),
                        endChild: const _RightChild(
                          disabled: true,
                          asset: 'assets/images/livreur.png',
                          title: 'Direction Point d\'arrivé',
                          message:
                              'Le livreur est en route pour le point d\'arrivé',
                        ),
                        beforeLineStyle: LineStyle(
                          color: inWait ? PrimaryLigthColor : Color(0xFF27AA69),
                        ),
                      ),
                      TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.1,
                        indicatorStyle: IndicatorStyle(
                          width: 20,
                          color: inWait ? PrimaryLigthColor : Color(0xFF2B619C),
                          padding: EdgeInsets.all(6),
                        ),
                        endChild: const _RightChild(
                          disabled: true,
                          asset: 'assets/images/receive.png',
                          title: 'Point d\'arrivé',
                          message:
                              'Le livreur attend celui qui doit recevoir au point d\'arrivé',
                        ),
                        beforeLineStyle: LineStyle(
                          color: inWait ? PrimaryLigthColor : Color(0xFF27AA69),
                        ),
                        afterLineStyle: LineStyle(
                          color: PrimaryLigthColor,
                        ),
                      ),
                      TimelineTile(
                        alignment: TimelineAlign.manual,
                        lineXY: 0.1,
                        isLast: true,
                        indicatorStyle: IndicatorStyle(
                          width: 20,
                          color: PrimaryLigthColor,
                          padding: EdgeInsets.all(6),
                        ),
                        endChild: const _RightChild(
                          disabled: true,
                          asset: 'assets/images/meet.png',
                          title: 'Livré avec succès',
                          message: 'Your order is ready for pickup.',
                        ),
                        beforeLineStyle: LineStyle(
                          color: PrimaryLigthColor,
                        ),
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

//  Color SelectedColor(bool inWait, String status) {
//    if()
//  }
}

class _RightChild extends StatelessWidget {
  const _RightChild({
    Key key,
    this.asset,
    this.title,
    this.message,
    this.disabled = false,
  }) : super(key: key);

  final String asset;
  final String title;
  final String message;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          Opacity(
            child: Image.asset(asset, height: 50),
            opacity: disabled ? 0.5 : 1,
          ),
          const SizedBox(width: 16),
          Opacity(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text(
                    title,
                    style: subTitleBlack(15),
                  ),
                ),
                const SizedBox(height: 6),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Text(
                    message,
                  ),
                ),
              ],
            ),
            opacity: disabled ? 0.2 : 1,
          )
        ],
      ),
    );
  }
}
