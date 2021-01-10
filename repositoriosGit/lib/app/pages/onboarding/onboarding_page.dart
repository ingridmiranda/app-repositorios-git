import 'package:fancy_on_boarding/fancy_on_boarding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'onboarding_controller.dart';

class OnboardingPage extends StatefulWidget {
  final String title;
  const OnboardingPage({Key key, this.title = "Onboarding"}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState
    extends ModularState<OnboardingPage, OnboardingController> {
  //use 'controller' variable to access controller

final pageList = [
    PageModel(
        color: const Color(0xFF293241),
        heroImagePath: 'assets/images/first.png',
        title: Text('Descubra!',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text('Quais são os 100 primeiros repositórios \n criados no GitHub',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconImagePath: 'assets/images/code.png'),
    PageModel(
        color: const Color(0xFF3D5A80),
        heroImagePath: 'assets/images/know.png',
        title: Text('Conheça!',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: Colors.white,
              fontSize: 34.0,
            )),
        body: Text(
            'Saiba quem são os desenvolvedores \n de cada repositório',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
            )),
        iconImagePath: 'assets/images/person.png'),
    PageModel(
      color: const Color(0xFF98C1D9),
      heroImagePath: 'assets/images/developers.png',
      title: Text('Acesse!',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
            fontSize: 34.0,
          )),
      body: Text('Abra e veja o repositório do seu \n interesse com apenas um clique',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          )),
          iconImagePath: 'assets/images/click.png'
    )
  ];
  
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FancyOnBoarding(
        doneButtonText: "Iniciar",
        skipButtonText: "Pular",
        pageList: pageList,
        onDoneButtonPressed: () =>
            Modular.to.pushReplacementNamed('/home'),
        onSkipButtonPressed: () =>
            Modular.to.pushReplacementNamed('/home'),
      ),
    );
  }
}
