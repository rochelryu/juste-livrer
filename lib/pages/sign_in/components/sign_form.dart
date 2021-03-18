import 'dart:async';

import 'package:flutter/material.dart';
import 'package:juste_livrer/Models/User.dart';
import 'package:juste_livrer/ServicesWorker/ConsumeAPI.dart';
import 'package:juste_livrer/Utils/Database.dart';
import 'package:juste_livrer/constant/WidgetCommon.dart';
import 'package:juste_livrer/constant/custom_surfix_icon.dart';
import 'package:juste_livrer/constant/form_error.dart';
import 'package:juste_livrer/constant/size_config.dart';
import 'package:juste_livrer/pages/forgot_password/forgot_password_screen.dart';
import 'package:juste_livrer/pages/home/home_screen.dart';
import 'package:juste_livrer/pages/livreurHome/Home.dart';

import '../../../constant/Style.dart';
import '../../../constant/default_button.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  String number = "";
  User user;
  String password = "";
  bool remember = false;
  final List<String> errors = [];
  bool isObscure = true;

  @override
  void initState() {
    super.initState();
    getNewLevel();
  }

  Future getNewLevel() async {
    User newClient = await DBProvider.db.getClient();
    print("Le client ${newClient.name}");
  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(70)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                    context, ForgotPasswordScreen.routeName),
                child: Text(
                  "Mot de passe oublié ?",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(30)),
          DefaultButton(
            text: "Verifier",
            press: () async {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                final res = await ConsumeAPI().signin(number, password);
                if (res['etat']) {
                  setState(() {
                    user = res['user'];
                  });
                  await DBProvider.db.delClient();
                  await DBProvider.db.newClient(user);
                  user.role == 'CUSTOMER' ? setLevel(2) : setLevel(3);
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => DialogCustomError(
                          'De retour',
                          'Nous sommes heureux de vous revoir ${user.name}',
                          context),
                      barrierDismissible: false);
                  Timer(Duration(seconds: 5), () {
                    if (user.role == 'CUSTOMER') {
                      Navigator.pushNamed(context, HomeScreen.routeName);
                    } else {
                      Navigator.pushNamed(context, HomeScreenLivreur.routeName);
                    }
                  });

                  // if all are valid then go to success screen

                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          DialogCustomError('Erreur', res['error'], context),
                      barrierDismissible: false);
                }
              }
            },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: isObscure,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 5) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 5) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Mot de passe",
        hintText: "Votre mot de passe",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly

        suffixIcon: IconButton(
            icon: Icon(isObscure ? Icons.lock_open : Icons.lock_outline),
            onPressed: () {
              setState(() {
                isObscure = !isObscure;
              });
            }),
        fillColor: Colors.black,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => number = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        } else if (value.length == 8) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        } else if (value.length != 8) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Numero",
        hintText: "01020304",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly

        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
        fillColor: Colors.black,
        border: new OutlineInputBorder(
          borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
