import 'dart:async';

import 'package:flutter/material.dart';
import 'package:juste_livrer/Models/User.dart';
import 'package:juste_livrer/ServicesWorker/ConsumeAPI.dart';
import 'package:juste_livrer/Utils/Database.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/constant/WidgetCommon.dart';
import 'package:juste_livrer/constant/custom_surfix_icon.dart';
import 'package:juste_livrer/constant/default_button.dart';
import 'package:juste_livrer/constant/form_error.dart';
import 'package:juste_livrer/constant/size_config.dart';
import 'package:juste_livrer/pages/home/home_screen.dart';
import 'package:juste_livrer/pages/livreurHome/Home.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  PersonOfRendezVous _character = PersonOfRendezVous.notLivreur;
  bool isCliced = false;
  final _formKey = GlobalKey<FormState>();
  User user;
  String email = '';
  String name = '';
  String number = '';
  String password;
  String address;
  bool isObscure = true;

  final List<String> errors = [];

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
          buildNameFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPhoneFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildAddressFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          buildPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(10)),
          Container(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Radio(
                            value: PersonOfRendezVous.notLivreur,
                            groupValue: _character,
                            activeColor: PrimaryColor,
                            onChanged: (value) {
                              setState(() {
                                _character = value;
                              });
                            }),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Compte"),
                            Text("Standard"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Radio(
                            value: PersonOfRendezVous.isLivreur,
                            groupValue: _character,
                            activeColor: PrimaryColor,
                            onChanged: (value) {
                              setState(() {
                                _character = value;
                              });
                            }),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("Compte"),
                            Text("Livreur"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          isCliced
              ? Container(
                  height: 20,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : DefaultButton(
                  text: "Enregistrer",
                  press: () async {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      setState(() {
                        isCliced = true;
                      });
                      // if all are valid then go to success screen
                      final role = _character == PersonOfRendezVous.notLivreur
                          ? 'CUSTOMER'
                          : 'DELIVERY_MAN';
                      final res = await ConsumeAPI()
                          .signup(name, email, number, address, role, password);
                      setState(() {
                        isCliced = false;
                      });
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
                                'Bienvenue',
                                'Nous sommes heureux de vous compter parmi nous ${user.name}',
                                context),
                            barrierDismissible: false);
                        Timer(Duration(seconds: 5), () {
                          if (user.role == 'CUSTOMER') {
                            Navigator.pushNamed(context, HomeScreen.routeName);
                          } else {
                            Navigator.pushNamed(
                                context, HomeScreenLivreur.routeName);
                          }
                        });

                        // if all are valid then go to success screen

                      } else {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                DialogCustomError(
                                    'Erreur', res['error'], context),
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
        password = value;
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
        hintText: "Un mot de passe de plus de 5 caractères",
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
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "abcde@exemple.com",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
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

  TextFormField buildNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => name = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kNamelNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kNamelNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Nom Complet",
        hintText: "Nom & Prénoms",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/UserIcon.svg"),
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

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => address = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kAddressNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kAddressNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Adresse",
        hintText: "Ville, commune, quartier",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        suffixIcon:
            CustomSurffixIcon(svgIcon: "assets/icons/Location point.svg"),
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

  TextFormField buildPhoneFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => number = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPhoneNumberNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Contact",
        hintText: "01020304",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
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
