import 'package:flutter/material.dart';
import 'package:juste_livrer/pages/createLivraison/components/CreateLivraison.dart';
import 'package:juste_livrer/pages/createLivraison/components/CreateReception.dart';

class CreateLivraisonScreen extends StatelessWidget {
  final int type;
  const CreateLivraisonScreen({
    Key key,
    @required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return type == 0 ? CreateLivraison() : CreateReception();
  }
}
