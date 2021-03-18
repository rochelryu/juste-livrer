import 'package:flutter/material.dart';
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/constant/size_config.dart';
import 'package:juste_livrer/pages/sign_up/sign_up_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Pas de Compte ? ",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Inscrivez-vous",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: SecondaryColor),
          ),
        ),
      ],
    );
  }
}
