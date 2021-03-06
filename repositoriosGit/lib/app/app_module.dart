import 'package:repositoriosGit/app/pages/onboarding/onboarding_page.dart';
import 'package:repositoriosGit/app/pages/splash/splash_page.dart';
import 'pages/splash/splash_controller.dart';
import 'pages/onboarding/onboarding_controller.dart';
import 'app_controller.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/material.dart';
import 'package:repositoriosGit/app/app_widget.dart';
import 'package:repositoriosGit/app/modules/home/home_module.dart';

class AppModule extends MainModule {
  @override
  List<Bind> get binds => [
        $SplashController,
        $OnboardingController,
        $AppController,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, args) => SplashPage()),
        ModularRouter('/home', module: HomeModule()),
        ModularRouter('/onboarding', child: (_, args) => OnboardingPage()),
      ];

  @override
  Widget get bootstrap => AppWidget();

  static Inject get to => Inject<AppModule>.of();
}
