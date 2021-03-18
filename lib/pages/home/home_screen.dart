import 'package:flutter/material.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:juste_livrer/Models/User.dart';
import 'package:juste_livrer/Utils/Database.dart';
import 'package:juste_livrer/constant/CustomSideBar.dart';

import 'components/body.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/home";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FSBStatus status;
  User newClient;

  @override
  void initState() {
    super.initState();
    getNewLevel();
  }

  Future getNewLevel() async {
    User user = await DBProvider.db.getClient();

    setState(() {
      newClient = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: FoldableSidebarBuilder(
          status: status,
          drawer: CustomSlideBar(
              name: newClient != null ? newClient.name : '',
              picture: newClient != null ? newClient.picture : ''),
          screenContents: Body(
            press: press,
          )),
    ));
  }

  press() {
    setState(() {
      status = status == FSBStatus.FSB_OPEN
          ? FSBStatus.FSB_CLOSE
          : FSBStatus.FSB_OPEN;
    });
  }
}
