import 'package:juste_livrer/Models/User.dart';
import 'package:juste_livrer/Utils/Database.dart';
import 'package:juste_livrer/Utils/network_util.dart';

class ConsumeAPI {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL =
      "https://moneyshelper.com"; // 192.168.1.100 127.0.0.1 172.20.10.4 // ngboador 192.168.1.27 // unknow mobile 192.168.43.4
  static final SIGNIN_URL = BASE_URL + "/auth/login";
  static final SIGNUP_URL = BASE_URL + "/auth/register";
  static final CREATELIVRAISON = BASE_URL + "/user/createLivraison";
  static final GETPROFIL = BASE_URL + "/client/getProfil";
  static final GETHISTORY = BASE_URL + "/user/myListLivraison";
  static final CREATEREDVFIRST = BASE_URL + "/client/createRendezVousStandard";
  static final CREATEREDVLAST =
      BASE_URL + "/client/finaliserRendezVousStandard";
  static final PHARMA_URL =
      "https://cameroun.meandyouassociation.com/API/V1/FOCUS/pharma";

  // Assets File URL
  static final AssetProfilServer = BASE_URL + "/assets/images/avatars/profils/";
  static final AssetProfilDoctorServer =
      BASE_URL + "/assets/images/avatars/profils/";
  static final AssetProductServer = BASE_URL + "/store/";
  static final AssetEventServer = BASE_URL + "/event/";
  static final AssetBuyEventServer = BASE_URL + "/event/buy/";
  static final AssetCovoiturageServer = BASE_URL + "/covoiturage/";
  static final AssetPublicServer = BASE_URL + "/public/";
  static final AssetConversationServer = BASE_URL + "/public/conversation/";
  static final _API_KEY = "somerandomkey";

  // For signin
  signin(String phone, String password) {
    return _netUtil.post(SIGNIN_URL,
        body: {"phone": phone, "password": password}).then((dynamic res) {
      print(res);
      if (res["etat"]) {
        return {'user': User.fromJson(res["result"]), 'etat': true};
      } else {
        return res;
      }
    });
  }

  signup(
    String name,
    String email,
    String phone,
    String address,
    String role,
    String password,
  ) {
    return _netUtil.post(SIGNUP_URL, body: {
      "name": name,
      "email": email,
      "phone": phone,
      "address": address,
      "role": role,
      "password": password,
    }).then((dynamic res) {
      print(res);
      if (res["etat"] == true) {
        return {'user': User.fromJson(res["user"]), 'etat': res["etat"]};
      } else {
        return res;
      }
    });
  }

  createLivraison({
    String name,
    String numeroDepart,
    String senderLocation,
    String recipientPhone,
    String recipientLocation,
    String typeLivraison,
  }) async {
    User newClient = await DBProvider.db.getClient();
    return _netUtil.post(CREATELIVRAISON, body: {
      "nameProduct": name,
      "owner": newClient.ident,
      "recovery": newClient.recovery,
      "senderPhone": numeroDepart,
      "senderLocation": senderLocation,
      "recipientLocation": recipientLocation,
      "recipientPhone": recipientPhone,
      "typeLivraison": typeLivraison,
    }).then((dynamic res) {
      print(res);
      return res;
    });
  }

//  signinSecondStep(dynamic images, dynamic base64, List<String> choice) async {
//    User newClient = await DBProvider.db.getClient();
//    return _netUtil.post(SIGINSECONDSTEP_URL, body: {
//      "id": newClient.ident,
//      "images": images,
//      "base64": base64,
//      "name": newClient.name,
//      "choice": choice.join(' '),
//      "recovery": newClient.recovery
//    }).then((dynamic res) {
//      if (res["etat"] == "found") {
//        return {'user': User.fromJson(res["result"]), 'etat': res["etat"]};
//      } else {
//        return {'etat': res["etat"]};
//      }
//    });
//  }

  Future<Map<dynamic, dynamic>> getAllInfoProfil(
      String _id, String recovery) async {
    final res = await _netUtil.get('$GETPROFIL?_id=$_id&recovery=$recovery');
    return res;
  }

  Future<Map<dynamic, dynamic>> getHistory(String _id, String recovery) async {
    print('history');
    final res = await _netUtil.get('$GETHISTORY?id=$_id&recovery=$recovery');
    print(res);
    return res;
  }

// For communication

}
