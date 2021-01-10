import 'dart:async';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'splash_controller.dart';

class SplashPage extends StatefulWidget {
  final String title;
  const SplashPage({Key key, this.title = "Splash"}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends ModularState<SplashPage, SplashController> {
  //use 'controller' variable to access controller
  ReactionDisposer disposer;

  _SplashPageState(){
    new Timer(const Duration(milliseconds: 100), () async{
      await loadConfig();
    });
  }

  loadConfig() async{
  await Hive.initFlutter();
  var box = await Hive.openBox('isInitialized');
  if (box.get('number') != null){
    Modular.to.pushReplacementNamed("/home");
  } else {
    box.put('number', 0);
    Modular.to.pushReplacementNamed("/onboarding");
  }}

  @override
  void initState(){
    super.initState();
  }

  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD2E4EE),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
