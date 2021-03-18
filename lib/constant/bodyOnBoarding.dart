import "package:flutter/material.dart";
import 'package:juste_livrer/constant/Style.dart';
import 'package:juste_livrer/constant/default_button.dart';
import 'package:juste_livrer/constant/size_config.dart';
import 'package:juste_livrer/pages/sign_in/sign_in_screen.dart';

class BodyOnborading extends StatefulWidget {
  BodyOnborading({Key key}) : super(key: key);

  @override
  _BodyOnboradingState createState() => _BodyOnboradingState();
}

class _BodyOnboradingState extends State<BodyOnborading> {
  int currentPage = 0;
  List<Map<String, String>> onBoardingData = [
    {
      "title": "LIVREURE",
      "subtitle":
          "Avez vous un outils de transport rapide pour vous deplacer afin de remettre des colis ? Alors Juste Livrer vous offres embauche imédiatement.",
      "image": "assets/images/livreur.png"
    },
    {
      "title": "RECEVEUR",
      "subtitle":
          "Recevez ce que vous voulez dans les plus brief delais. Suivez même où se trouve votre colis à chaque instant.",
      "image": "assets/images/receive.png"
    },
    {
      "title": "VERIFICATION",
      "subtitle":
          "Verifier l'état de votre colis avant de payer votre livraison car votre satisfaction, notre mission.",
      "image": "assets/images/meet.png"
    },
    {
      "title": "BIENVENUE",
      "subtitle":
          "L'equipe de JUSTE LIVRER vous souhaite la bienvenue parmie les membres de sa communauté.",
      "image": "assets/images/logo.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  itemCount: onBoardingData.length,
                  itemBuilder: (context, index) => OnBoradinContent(
                    image: onBoardingData[currentPage]["image"],
                    title: onBoardingData[currentPage]["title"],
                    subtitle: onBoardingData[currentPage]["subtitle"],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Column(children: <Widget>[
                    Spacer(),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(onBoardingData.length,
                            (index) => buildDotIndication(index: index))),
                    Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: getProportionateScreenHeight(56),
                      child: DefaultButton(
                        text: currentPage == 3 ? "MERCI" : "SUIVANT",
                        press: nextStep,
                      ),
                    )
                  ]),
                )),
          ],
        ),
      ),
    );
  }

  nextStep() {
    if (currentPage == 3) {
      setLevel(1);
      Navigator.pushNamed(context, SignInScreen.routeName);
    } else {
      setState(() {
        currentPage++;
      });
    }
  }

  AnimatedContainer buildDotIndication({int index}) {
    return AnimatedContainer(
        duration: AnimationDuration,
        margin: EdgeInsets.only(right: 5),
        height: 6,
        width: currentPage == index ? 20 : 6,
        decoration: BoxDecoration(
          color: currentPage == index ? PrimaryColor : PrimaryLigthColor,
          borderRadius: BorderRadius.circular(3),
        ));
  }
}

class OnBoradinContent extends StatelessWidget {
  final title, subtitle, image;
  const OnBoradinContent({
    Key key,
    this.title,
    this.subtitle,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Spacer(),
        Text(
          title,
          style: TextStyle(
              color: SecondaryColor,
              fontWeight: FontWeight.bold,
              fontSize: getProportionateScreenWidth(36)),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 17),
          child: Text(subtitle, textAlign: TextAlign.center),
        ),
        Spacer(),
        Image.asset(
          image,
          height: getProportionateScreenHeight(325),
          width: getProportionateScreenWidth(305),
        )
      ],
    );
  }
}
