import 'package:flutter/material.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/pages/livreurHome/components/ShowLivreur.dart';
import 'package:juste_livrer/pages/profil/ProfilLivreur.dart';

class HomeScreenLivreur extends StatefulWidget {
  static String routeName = "/homeLivreur";

  @override
  _HomeScreenLivreurState createState() => _HomeScreenLivreurState();
}

class _HomeScreenLivreurState extends State<HomeScreenLivreur> {
  int currentPageIndex = 1;
  List<Widget> page = [ContentPage(), ShowLivreur(), ProfilLivreurScreen()];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: page[currentPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: PrimaryColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            title: Text("Historique"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_bike),
            title: Text("Demande"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervised_user_circle),
            title: Text("Profil"),
          ),
        ],
        currentIndex: currentPageIndex,
        selectedItemColor: SecondaryColor,
        onTap: press,
        unselectedItemColor: PrimaryLigthColor,
      ),
    ));
  }

  void press(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }
}

class ContentPage extends StatelessWidget {
  const ContentPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("TEXT DATA"),
      ),
    );
  }
}
