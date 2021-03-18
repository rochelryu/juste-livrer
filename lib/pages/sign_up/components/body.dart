import 'package:flutter/material.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/constant/size_config.dart';

import 'sign_up_form.dart';

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
                SizedBox(height: SizeConfig.screenHeight * 0.04), // 4%
                Text("Inscrption", style: headingStyle),

                SizedBox(height: SizeConfig.screenHeight * 0.04),
                SignUpForm(),

                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  'En cliquant sur Enregristrer \nvous êtes d\'accord avec nos Termes et Conditions',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.caption,
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
