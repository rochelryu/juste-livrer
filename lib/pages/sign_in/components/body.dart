import 'package:flutter/material.dart';
import 'package:juste_livrer/constant/no_account_text.dart';
import 'package:juste_livrer/constant/size_config.dart';
import 'package:juste_livrer/constant/socal_card.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Connexion",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: getProportionateScreenWidth(28),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.04),
                Text(
                  "Vous vous êtes déjà inscrit chez nous ? Alors connectez-vous",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                SignForm(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                NoAccountText(),
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
