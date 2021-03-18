import "package:flutter/material.dart";
import 'package:juste_livrer/constant/bodyOnBoarding.dart';
import 'package:juste_livrer/constant/size_config.dart';

class OnBoading extends StatelessWidget {
  static String routeName = "/onBoarding";
  const OnBoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: BodyOnborading(),
    );
  }
}
