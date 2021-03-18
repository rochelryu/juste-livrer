import 'package:flutter/material.dart';
import 'package:juste_livrer/Models/User.dart';
import 'package:juste_livrer/ServicesWorker/WebSocketHelper.dart';
import 'package:juste_livrer/Utils/Database.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class AppState with ChangeNotifier {
  IO.Socket _socket;
  String priceTicketTotal;
  String idLivraison;
  String idVoyage;
  String assestTorfait;
  String idOldConversation = '';
  String priceVoyageTotal;
  String forfaitEventEnum = "NOT FORFAIT";
  int numberTicket;
  int numberNotif = 0;
  List<int> placeOccupe;
  bool typing = false;
  bool livraisonCreate = false;
  dynamic conversation = {};
  AppState() {}
  void initializeSocket() async {
    _socket = IO.io("$SERVER_ADDRESS/$NAME_SPACE", <String, dynamic>{
      'transports': ['websocket'],
    });
    _socket.on('connect', (data) {
      print("connected... since appState");
    });
    _socket.on("socket_info_connected", (data) {
      //sample event
      print("socket_info_connected $data");
    });
    _socket.connect();
  }

  setTyping(bool typing, String id) {
    final jsonData = {
      "id": this.getIdOldConversation,
      "typing": typing,
      "destinate": id
    };
    _socket.emit("typing", [jsonData]);
    notifyListeners();
  }

  updateTyping(bool typing) {
    typing = typing;
  }

  setPriceTicketTotal(String priceTicket) {
    priceTicketTotal = priceTicket;
    notifyListeners();
  }

  setPriceVoyageTotal(String priceTicket) {
    priceVoyageTotal = priceTicket;
    notifyListeners();
  }

  setIdLivraison(String id) {
    idLivraison = id;
    notifyListeners();
  }

  // Notif action State
  setNumberNotif(int numberNotifFromServer) {
    numberNotif = numberNotifFromServer;
    notifyListeners();
  }

  setForfaitEventEnum(String forfaitEventString, String assestTorfait) {
    forfaitEventEnum = forfaitEventString;
    this.assestTorfait = assestTorfait;
    notifyListeners();
  }

  incrementNotif() {
    numberNotif++;
    notifyListeners();
  }

  setIdVoyage(String id) {
    idVoyage = id;
    notifyListeners();
  }

  setIdOldConversation(String id) {
    idOldConversation = id;
    notifyListeners();
  }

  setTypingUser(String id) {
    _socket.emit("typing", [id]);
    notifyListeners();
  }

  setJoinConnected(String id) {
    _socket.emit("joinConnected", [id]);
    notifyListeners();
  }

  setNumberTicket(int nbrTicket) {
    numberTicket = nbrTicket;
    notifyListeners();
  }

  setPlaceOccupe(List<int> plce) {
    placeOccupe = plce;
    notifyListeners();
  }

  String _displayText = "";

  void setSocket(IO.Socket socket) {
    _socket = _socket ?? socket;
    notifyListeners();
  }

//   void setMessage(String text) {
//     _displayText = text;
//     notifyListeners();
//   }
  void sendChatMessage(
      {String destinate,
      String id,
      String imageName = '',
      String base64 = '',
      String content = ''}) async {
    User newClient = await DBProvider.db.getClient();
    final jsonData = {
      "content": content,
      "ident": newClient.ident,
      "room": destinate,
      "base64": base64,
      "image": imageName,
      "id": id
    };
    if (_socket != null) {
      _socket.emit("message", [jsonData]);
      notifyListeners();
    } else {
      initializeSocket();
      _socket.emit("message", [jsonData]);
      notifyListeners();
    }
  }

  void changeProfilPicture({String imageName, String base64}) async {
    User newClient = await DBProvider.db.getClient();
    final jsonData = {
      "image": imageName,
      "id": newClient.ident,
      "base64": base64,
      "recovery": newClient.recovery
    };
    if (_socket != null) {
      _socket.emit("changeProfil", [jsonData]);
      notifyListeners();
    } else {
      initializeSocket();
      _socket.emit("changeProfil", [jsonData]);
      notifyListeners();
    }
  }

  void createLivraison({
    String name,
    String numeroDepart,
    String senderLocation,
    String recipientPhone,
    String recipientLocation,
  }) async {
    User newClient = await DBProvider.db.getClient();
    final jsonData = {
      "nameProduct": name,
      "owner": newClient.ident,
      "recovery": newClient.recovery,
      "senderPhone": numeroDepart,
      "senderLocation": senderLocation,
      "recipientLocation": recipientLocation,
      "recipientPhone": recipientPhone,
    };
    if (_socket != null) {
      _socket.emit("createLivraison", [jsonData]);
      notifyListeners();
    } else {
      initializeSocket();
      _socket.emit("createLivraison", [jsonData]);
      notifyListeners();
    }
  }

  clearConversation() {
    conversation = {};
    notifyListeners();
  }

  clearIdOldConversation() {
    idOldConversation = '';
    notifyListeners();
  }

  setConversation(dynamic converse) {
    conversation = converse;
    notifyListeners();
  }

  getConversation(String foreign) {
    _socket.emit('getConversation', [foreign]);
    notifyListeners();
    // User newClient = await DBProvider.db.getClient();
    // final converse = conversation.map(
    //   (value) {
    //     if ((value['userIdPrimary'] == id && value['userIdScondary'] == newClient.ident) || (value['userIdScondary'] == id && value['userIdPrimary'] == newClient.ident)) {
    //       return value;
    //     }
    //   }).toList()[0];
    //   return converse ?? {
    //     "userIdPrimary": id,
    //     "userIdScondary": newClient.ident,
    //     "content": [],
    //     "room": id,
    //   };
  }
//  void _onReceiveChatMessage(dynamic message) {
// 	print("Message from UFO: " + message);
// }

  String get getDisplayText => _displayText;
  String get getForfaitEventEnum => forfaitEventEnum;
  String get getAssestTorfait => assestTorfait;
  String get getIdLivraison => idLivraison;
  bool get getTyping => typing;
  String get getIdOldConversation => idOldConversation;
  String get getNumberTicket => numberTicket.toString();
  int get getNumberNotif => numberNotif;
  String get getPriceTicketTotal => priceTicketTotal;
  dynamic get getConversationGetter => conversation;
  IO.Socket get getSocketIO => _socket;
}