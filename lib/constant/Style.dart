import 'dart:io';

import 'package:flutter/material.dart';
import 'package:juste_livrer/constant/size_config.dart';
import 'package:path_provider/path_provider.dart';

const PrimaryColor = Color(0xFF310100);
const SecondaryColor = Color(0xFFFB9303);
const APIKeys = "AIzaSyA9GXXmu_ibKPwoO4ZUdBk656Putwuao-A";
//const LinearGrandiantColor = LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFFFA53E), PrimaryColor]);
const PrimaryLigthColor = Color(0xFF979797);
const TextColor = Color(0xFF757575);
enum PersonOfRendezVous { isLivreur, notLivreur }
// Animation
const AnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Email invalide";
const String kInvalidEmailError = "Email invalide";
const String kPassNullError = "Mot de passe invalide";
const String kShortPassError = "Mot de passe trop faible";
const String kMatchPassError =
    "Mot de passe et la confirmation \nne se corresponde pas";
const String kNamelNullError = "Nom invalide";
const String kPhoneNumberNullError = "Numero invalide";
const String kAddressNullError = "Adresse invalide";

final otpInputDecoration = InputDecoration(
  contentPadding:
      EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);

OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: TextColor),
  );
}

TextStyle title(double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w700,
    fontFamily: "Montserrat",
    color: SecondaryColor,
  );
}

TextStyle titlePrimary(double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w700,
    fontFamily: "Montserrat",
    color: PrimaryColor,
  );
}

TextStyle titleWhite(double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.w700,
    fontFamily: "Montserrat",
    color: Colors.white,
  );
}

TextStyle titleColorBlack(double size) {
  return TextStyle(
    fontSize: size,
    fontWeight: FontWeight.bold,
    fontFamily: "Montserrat",
    color: Colors.black,
  );
}

TextStyle simpleText(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "Oswald",
    color: PrimaryLigthColor,
  );
}

TextStyle simpleTextBlackOpacity(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "Oswald",
    color: Colors.black54,
  );
}

TextStyle subTitleWhite(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "Oswald",
    color: Colors.white,
  );
}

TextStyle subTitleRedBordeaux(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "Oswald",
    color: Colors.redAccent,
  );
}

TextStyle subTitleBlack(double size) {
  return TextStyle(
    fontSize: size,
    fontFamily: "Oswald",
    color: Colors.black,
  );
}

TextStyle menuSlideBarHistory(bool activate) {
  return TextStyle(
    fontSize: 18,
    fontWeight: activate ? FontWeight.bold : FontWeight.normal,
    fontFamily: "Oswald",
    color: activate ? SecondaryColor : PrimaryLigthColor,
  );
}

// pur function

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localLevel async {
  final path = await _localPath;
  return File('$path/level.txt');
}

Future<int> getLevel() async {
  try {
    final file = await _localLevel;
    String level = await file.readAsString() ?? '0';
    return int.parse(level);
  } catch (e) {
    return 0;
  }
}

Future<File> setLevel(int level) async {
  final file = await _localLevel;
  return file.writeAsString('$level');
}
