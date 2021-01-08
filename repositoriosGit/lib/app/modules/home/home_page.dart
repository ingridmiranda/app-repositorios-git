import 'dart:io';
import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller
bool isConnected;

void _testConnection() async{
    try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      print('connected');
      isConnected = true;
    }} on SocketException catch (_) {
      print('not connected');
      isConnected = false;
  }}

  void initState() {
    _testConnection();
    if (isConnected == true){
      controller.getRepositorios();
    }
    print(controller.repoInfoList); //.owner.avatar_url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF3D5A80),
      body: Column(
        children: <Widget>[
          _titleText(),
          _bodyPage(),
          _bottomPage()
        ],
      ),
    );
  }

  Widget _titleText() {
    return Container(
      padding: EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: AutoSizeText(
              "Top 100: Primeiros repositórios criados no GitHub",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Image.asset(
            'assets/images/GitHub-Mark-Light-64px.png',
            scale: 1.5,
          )
        ],
      ),
    );
  }

  final options = LiveOptions(
    delay: Duration(seconds: 0),
    showItemInterval: Duration(milliseconds: 150),
    showItemDuration: Duration(milliseconds: 150),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );

  Widget buildAnimatedItem(
    BuildContext context,
    int index,
    Animation<double> animation,
  ) =>
      FadeTransition(
        opacity: Tween<double>(
          begin: 0,
          end: 1,
        ).animate(animation),
        child: SlideTransition(
          position: Tween<Offset>(
            begin: Offset(0, -0.1),
            end: Offset.zero,
          ).animate(animation),
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xFFD2E4EE),
                borderRadius: BorderRadius.circular(10)),
            child: ListTile(
                title: Text(controller.repoInfoList[index].name,
                    style: TextStyle(
                        color: Color(0xFF293241), fontWeight: FontWeight.w500)),
                subtitle: Text(controller.repoInfoList[index].owner.login,
                    style: TextStyle(color: Color(0xFF293241))),
                trailing: Text("#" + (index + 1).toString(),
                    style: TextStyle(
                        fontWeight: FontWeight.w700, color: Color(0xFFEE6C4D))),
                onTap: () =>
                    _launchURL(controller.repoInfoList[index].html_url),
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    controller.repoInfoList[index].owner.avatar_url,
                  ),
                )),
          ),
        ),
      );
  Widget _showInfo() {
    return Expanded(
      child: Observer(builder: (_) {
        return LiveList.options(
            options: options,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            padding: EdgeInsets.only(left: 30, right: 30),
            itemCount: controller.repoInfoList.length,
            itemBuilder: buildAnimatedItem);
      }),
    );
  }

  Widget _bottomPage() {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
    );
  }

  Widget _loadingPage() {
    return Center(
      heightFactor: 2.5,
      child: Container(
        child: Column(
        children: [
          LoadingBouncingGrid.square(
            backgroundColor: Color(0xFFEE6C4D),
            size: 100,
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Carregando ...".toUpperCase(),
              style: TextStyle(
                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
            ),
          )
        ],
      )),
    );
  }

  Widget _bodyPage() {
    return Observer(builder: (_) {
      return controller.repoInfoList.length == 0 ? _loadingPage() : _showInfo();
    });
  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }

  
}
