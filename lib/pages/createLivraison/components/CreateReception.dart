import 'package:flutter/material.dart';
import 'package:juste_livrer/Provider/AppState.dart';
import 'package:juste_livrer/ServicesWorker/ConsumeAPI.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/constant/WidgetCommon.dart';
import 'package:juste_livrer/constant/default_button.dart';
import 'package:juste_livrer/pages/livreurHome/components/DetailsLivraison.dart';
import 'package:provider/provider.dart';

class CreateReception extends StatefulWidget {
  @override
  _CreateReceptionState createState() => _CreateReceptionState();
}

class _CreateReceptionState extends State<CreateReception> {
  AppState appState;
  String name;
  String numeroDepart;
  String senderLocation;
  String recipientLocation;
  String recipientPhone;
  bool isLunch = false;

  @override
  Widget build(BuildContext context) {
    appState = Provider.of<AppState>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("RECEPTION"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text("RECEVEZ TOUT ET DE PARTOUT",
                    textAlign: TextAlign.center, style: title(17))),

            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (newValue) => name = newValue,
                onChanged: (value) {
                  setState(() {
                    name = value;
                  });
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Nom de la commande",
                  hintText: "Qu'est-ce que vous recevez",
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  fillColor: Colors.black,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (newValue) => numeroDepart = newValue,
                onChanged: (value) {
                  setState(() {
                    numeroDepart = value;
                  });
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Point de depart",
                  hintText: "Le numero à appeler",
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  fillColor: Colors.black,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (newValue) => senderLocation = newValue,
                onChanged: (value) {
                  setState(() {
                    senderLocation = value;
                  });
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Point de depart",
                  hintText: "Le lieu(ex: Cocody, Rivera palmeraie) ",
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  fillColor: Colors.black,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
//            Container(
//              padding: EdgeInsets.symmetric(vertical: 20),
//              width: MediaQuery.of(context).size.width * 0.84,
//              child: FlatButton(
//                onPressed: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(
//                      builder: (context) => PlacePicker(
//                        apiKey: APIKeys, // Put YOUR OWN KEY here.
//                        onPlacePicked: (result) {
//                          print("ICI C'est zo ${result.geometry}");
//                          Navigator.of(context).pop();
//                        },
//                        initialPosition:
//                            LatLng(5.383173999999999, -3.945240799999999),
//                        useCurrentLocation: true,
//                      ),
//                    ),
//                  );
//                },
//                child: Text("OK"),
//              ),
//            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (newValue) => recipientPhone = newValue,
                onChanged: (value) {
                  setState(() {
                    recipientPhone = value;
                  });
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Point d'arrivé",
                  hintText: "Le numero à appeler",
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  fillColor: Colors.black,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              width: MediaQuery.of(context).size.width * 0.84,
              child: TextFormField(
                keyboardType: TextInputType.text,
                onSaved: (newValue) => recipientLocation = newValue,
                onChanged: (value) {
                  setState(() {
                    recipientLocation = value;
                  });
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Point d'arrivé",
                  hintText: "Le lieu(ex: Cocody, Rivera palmeraie)",
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  fillColor: Colors.black,
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(25.0),
                    borderSide: new BorderSide(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10),
              width: MediaQuery.of(context).size.width * 0.84,
              child: isLunch
                  ? Container(
                      height: 20,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : DefaultButton(
                      text: "Enregistrer Commande",
                      press: () async {
                        setState(() {
                          isLunch = true;
                        });
                        print('save');
                        final res = await ConsumeAPI().createLivraison(
                            name: name,
                            numeroDepart: numeroDepart,
                            senderLocation: senderLocation,
                            recipientLocation: recipientLocation,
                            recipientPhone: recipientPhone,
                            typeLivraison: "RECEPTION");

                        setState(() {
                          isLunch = false;
                        });
                        if (res['etat']) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsLivraison(
                                    id: res['result']['delevery']['_id']),
                              ));
                        } else {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) => DialogCustomError(
                                  'Erreur',
                                  "Problème de connexion. Veuillez ressayer ultérieurement",
                                  context),
                              barrierDismissible: false);
                        }
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
