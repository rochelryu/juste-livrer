import 'package:flutter/material.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/pages/livreurHome/components/DetailsLivraison.dart';

class ListLivraison extends StatelessWidget {
  List<dynamic> mesRendezVous;

  ListLivraison(this.mesRendezVous);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mesRendezVous.length > 0
          ? ListView.builder(
              itemCount: mesRendezVous.length,
              itemBuilder: (context, index) {
                //mesRendezVous[index]['_id']
                return Padding(
                  padding: EdgeInsets.all(10),
                  child: GestureDetector(
                    onTap: () {
                      MaterialPageRoute(
                          builder: (context) => DetailsLivraison(
                                id: mesRendezVous[index]['_id'],
                              ));
                    },
                    child: Card(
                      elevation: 10,
                      child: Container(
                        height: 150,
                        child: Row(
                          children: [
                            Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(mesRendezVous[index]['nameProduct'],
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: titleColorBlack(15)),
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color:
                                                    SecondaryColor.withOpacity(
                                                        0.3),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: Icon(Icons.location_city,
                                                  color: SecondaryColor),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    mesRendezVous[index]
                                                        ['senderPhone'],
                                                    style: title(12),
                                                  ),
                                                  Text(mesRendezVous[index]
                                                      ['senderLocation']),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: PrimaryColor.withOpacity(
                                                    0.3),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: Center(
                                              child: Icon(Icons.location_on,
                                                  color: PrimaryColor),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    mesRendezVous[index]
                                                        ['recipientPhone'],
                                                    style: titlePrimary(12),
                                                  ),
                                                  Text(mesRendezVous[index]
                                                      ['recipientLocation']),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                )),
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "24/12/2012 23h59",
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    mesRendezVous[index]['typeLivraison'],
                                    style: subTitleBlack(13),
                                    textAlign: TextAlign.center,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Prix : ",
                                        textAlign: TextAlign.center,
                                      ),
                                      mesRendezVous[index]['montant'] == 0
                                          ? Text(
                                              "En cours",
                                              textAlign: TextAlign.center,
                                            )
                                          : Text(
                                              mesRendezVous[index]['montant'],
                                              style: subTitleRedBordeaux(13),
                                            )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              })
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/empty.png"),
                Text("Aucune Livraison effectuée")
              ],
            ),
    );
  }
}
