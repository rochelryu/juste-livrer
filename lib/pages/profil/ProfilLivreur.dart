import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:juste_livrer/Models/User.dart';
import 'package:juste_livrer/ServicesWorker/ConsumeAPI.dart';
import 'package:juste_livrer/Utils/Database.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/constant/WidgetCommon.dart';
import 'package:juste_livrer/pages/sign_in/sign_in_screen.dart';

class ProfilLivreurScreen extends StatefulWidget {
  static String routeName = "/profilLivreur";
  ProfilLivreurScreen({Key key}) : super(key: key);

  @override
  _ProfilLivreurScreenState createState() => _ProfilLivreurScreenState();
}

class _ProfilLivreurScreenState extends State<ProfilLivreurScreen> {
  bool isEditable = true;
  bool isChangePhoto = false;
  int currentPageEditable = 0;
  User newClient;
  Map<dynamic, dynamic> user;

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text("Information Personnelle", style: title(18)),
              Divider(color: PrimaryLigthColor),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 4,
                      child: Container(
                        height: 95,
                        width: 95,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage("assets/images/Profile Image.png"),
//                                !isChangePhoto
//                                    ? NetworkImage(
//                                        "${ConsumeAPI.AssetProfilServer}${newClient != null ? newClient.images : ''}")
//                                    : AssetImage(
//                                        ("assets/images/Profile Image.png"))
                        )),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: InkWell(
                                onTap: () {
                                  print("ChangePhoto");
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                      color: PrimaryColor.withOpacity(0.95),
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        print("Change Photo");
                                      },
                                      icon: Icon(
                                        Icons.linked_camera,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: ViewInfoPersonel(
                        newClient != null ? newClient.name : '',
                        user != null ? user['result']['address'] : 'Cocody',
                        user != null ? user['result']['numero'] : '48803377',
                        user != null
                            ? user['result']['email']
                            : 'core.irie@gmail.com',
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 3,
                              right: 5,
                              child: IconButton(
                                  icon: Icon(isEditable
                                      ? Icons.mode_edit
                                      : Icons.check_circle_outline),
                                  onPressed: () {
                                    setState(() {
                                      isEditable = !isEditable;
                                    });
                                  }),
                            )
                          ],
                        )),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text("Information Système", style: title(18)),
              Divider(color: PrimaryLigthColor),
              ListTile(
                leading: Icon(Icons.directions_bike),
                title: Text("Nombre de livraison Terminé Aujourdhui",
                    style: subTitleBlack(15)),
                subtitle: Text(
                  user != null ? user['result']['groupeSanguin'] : '0',
                ),
              ),
              ListTile(
                leading: Icon(Icons.file_download),
                title:
                    Text("Nombre de livraison total", style: subTitleBlack(15)),
                subtitle: Text(
                  user != null
                      ? '${user['result']['mesRendezVous'].length.toString()}'
                      : '0',
                ),
              ),
              ListTile(
                leading: Icon(Icons.mood_bad),
                title:
                    Text("Nombre de demande échoué", style: subTitleBlack(15)),
                subtitle: Text(
                  user != null
                      ? '${user['result']['numberRdvNever'].toString()}'
                      : '0',
                ),
              ),
              SizedBox(height: 20),
              Text("Information Confidentielle", style: title(18)),
              Divider(color: PrimaryLigthColor),
              ListTile(
                leading: Icon(Icons.security),
                title: Text("Changer mot de passe", style: subTitleBlack(15)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: RaisedButton(
                      onPressed: () async {
                        await DBProvider.db.delClient();
                        setLevel(1);
                        Navigator.pushNamed(context, SignInScreen.routeName);
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0)),
                      color: PrimaryColor,
                      textColor: Colors.white,
                      elevation: 5.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.exit_to_app, color: Colors.white),
                          Text("Deconnexion", style: subTitleWhite(16)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void toogleEditInfo() {
    setState(() {
      if (isEditable) {
        currentPageEditable = 1;
      } else {
        currentPageEditable = 0;
      }
      isEditable = !isEditable;
    });
  }
}
