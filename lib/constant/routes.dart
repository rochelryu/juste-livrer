import "package:flutter/widgets.dart";
import 'package:juste_livrer/pages/OnBoarding.dart';
import 'package:juste_livrer/pages/complete_profile/complete_profile_screen.dart';
import 'package:juste_livrer/pages/forgot_password/forgot_password_screen.dart';
import 'package:juste_livrer/pages/history/history_screen.dart';
import 'package:juste_livrer/pages/home/home_screen.dart';
import 'package:juste_livrer/pages/livreurHome/Home.dart';
import 'package:juste_livrer/pages/otp/otp_screen.dart';
import 'package:juste_livrer/pages/profil/ProfilScreen.dart';
import 'package:juste_livrer/pages/sign_in/sign_in_screen.dart';
import 'package:juste_livrer/pages/sign_up/sign_up_screen.dart';

// All Routes.

final Map<String, WidgetBuilder> routes = {
  OnBoading.routeName: (context) => OnBoading(),
  SignInScreen.routeName: (context) => SignInScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  HistoryScreen.routeName: (context) => HistoryScreen(),
  ProfilScreen.routeName: (context) => ProfilScreen(),
  HomeScreenLivreur.routeName: (context) => HomeScreenLivreur(),
};
