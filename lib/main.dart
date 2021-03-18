import 'package:flutter/material.dart';
import 'package:juste_livrer/Provider/AppState.dart';
import 'package:juste_livrer/ServicesWorker/WebSocketHelper.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/constant/routes.dart';
import 'package:juste_livrer/pages/OnBoarding.dart';
import 'package:juste_livrer/pages/home/home_screen.dart';
import 'package:juste_livrer/pages/livreurHome/Home.dart';
import 'package:juste_livrer/pages/sign_in/sign_in_screen.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'Models/User.dart';
import 'Utils/Database.dart';
import 'constant/size_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => AppState(),
      lazy: false,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'SANTE DE FER',
          theme: ThemeData(
            primaryColor: PrimaryColor,
            primaryColorDark: Colors.amber,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: "Montserrat",
            textTheme: TextTheme(
              bodyText1: TextStyle(color: TextColor),
              bodyText2: TextStyle(color: TextColor),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          initialRoute: '/', //OnBoading.routeName,
          routes: routes,
          home: MyHomePage()),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int level = 15;
  AppState appState;
  IO.Socket socket;

  @override
  void initState() {
    super.initState();
    getNewLevel();
    initializeSocket();
  }

  void initializeSocket() async {
    socket = IO.io("$SERVER_ADDRESS/$NAME_SPACE", <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.on('connect', (data) async {
      print("connected...");
      appState = Provider.of<AppState>(context, listen: false);
      appState.setSocket(socket);
      if (level >= 2) {
        final client = await DBProvider.db.getClient();
        socket.emit('loadNotif', [client.ident]);
      }
    });
    socket.on("reponseChangeProfil", (data) async {
      //sample event
      print('change avec success');
    });
    socket.on("MsToClient", (data) async {
      //sample event
      print('ici hein ${appState.getIdOldConversation} == ${data['_id']}');
      if (appState.getIdOldConversation == data['_id'] ||
          appState.getIdOldConversation == '') {
        appState.setConversation(data);
      } else {
        print(
            "${data['author']} vient de vous ecrire pour un deals allez Voir");
      }
    });
    socket.on("receivedConversation", (data) {
      //sample event
      print("receivedConversation ${data['etat']}");
      if (data['etat'] == 'found') {
        appState.setConversation(data['result']);
        appState.setIdOldConversation(data['result']['_id']);
      }
    });
    socket.on("receivedNotification", (data) {
      //sample event
      print("receivedNotification ${data}");

      appState.setNumberNotif(data);
    });
    socket.on("livraisonCreated", (data) async {
      //sample event
    });
    socket.on("typingResponse", (data) async {
      //sample event
      User newClient = await DBProvider.db.getClient();
      print('${data} ok');
      if (newClient.ident != data['destinate'] &&
          appState.getIdOldConversation == data['id']) {
        // for user which have created the roomsConversation
        appState.updateTyping(data['typing'] as bool);
        // print('${data['destinate']} est entrain de write');
      }
    });

    socket.on('disconnect', (_) => print('disconnect'));
    //socket.connect();
  }

  Future getNewLevel() async {
    try {
      int level = await getLevel();
      print("fake de ${level.toString()}");
      setState(() {
        this.level = level;
      });
    } catch (e) {
      print("Erreur $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return (socket != null) ? LevelUser(level) : LoadHide();
  }

  Widget LevelUser(int level) {
    switch (level) {
      case 0:
        return OnBoading();
        break;
      case 1:
        return SignInScreen();
        break;
      case 2:
        return HomeScreen();
        break;
      case 3:
        return HomeScreenLivreur();
        break;
      default:
        return LoadHide();
        break;
    }
  }
}

class LoadHide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(),
    );
  }
}
