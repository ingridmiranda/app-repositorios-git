import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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
  bool isTimeout;
  int times = 0;
  Duration timeout = const Duration(seconds: 3);
  Duration ms = const Duration(milliseconds: 1);

  void _testConnection() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        isConnected = true;
        if (times == 0){
          print("times");
          controller.getRepositorios();
          times = 1;
        }
      } 
    } on SocketException catch (_) {
      print('not connected');
      isConnected = false;
    }
  }

  void initState() {
    _testConnection();
    print(controller.repoInfoList);
    super.initState();
  }

  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Atenção'),
        content: Text('Você realmente deseja sair?'),
        actions: [
          FlatButton(
            child: Text('Sim'),
            onPressed: () => Navigator.pop(c, true),
          ),
          FlatButton(
            child: Text('Não'),
            onPressed: () => Navigator.pop(c, false),
          ),
        ],
      ),
    ),
      child: Scaffold(
        backgroundColor: Color(0xFF3D5A80),
        body: Observer(builder: (_) {
          return Column(
            children: <Widget>[
              (controller.repoInfoList.length == 0 || isConnected == false) ? SizedBox() : _titleText(),
              _bodyPage(),
              _bottomPage()
            ],
          );
        }),
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
  ) {
    _testConnection();
     return FadeTransition(
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
                leading: ClipOval(
                    child: isConnected == true ? CachedNetworkImage(
                    imageUrl: controller.repoInfoList[index].owner.avatar_url,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    placeholder: (context, url) => CircularProgressIndicator(),
                    ) : Image.asset('assets/images/person.png')))
          ),
        ),
      );}

  Widget _showInfo() {
    return  isConnected == true ? Expanded(
      child: Observer(builder: (_) {
        _testConnection();
        return LiveList.options(
            options: options,
            separatorBuilder: (BuildContext context, int index) => Divider(),
            padding: EdgeInsets.only(left: 30, right: 30),
            itemCount: controller.repoInfoList.length,
            itemBuilder: buildAnimatedItem);
      }),
    ) : _showDialog();
  }

  Widget _bottomPage() {
    return Padding(
      padding: EdgeInsets.only(bottom: 30),
    );
  }

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }

  void handleTimeout() {
    // callback function
    if (isConnected == false) {
      print("timeout");
      controller.setTimeout(true);
    } else {
      controller.setTimeout(false);
    }
  }

  Widget _showDialog(){
   return AlertDialog(
                  title: Text("Ops! Sem conexão com a internet...",
                      style: TextStyle(color: Color(0xFF3D5A80))),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  contentPadding: EdgeInsets.all(20),
                  buttonPadding: EdgeInsets.only(bottom: 10, right: 10),
                  backgroundColor: Color(0xFFD2E4EE),
                  content: Container(
                      height: 35,
                      child: Image.asset(
                          'assets/images/toppng.com-no-internet-connection-icon-no-internet-connection-icon.png')),
                  actions: [
                    FlatButton(
                        child: Text("Tentar novamente",
                            style: TextStyle(color: Color(0xFFEE6C4D))),
                        onPressed: () =>
                            Modular.to.pushReplacementNamed("/home")),
                  ],
                );
  }

  Widget _loadingPage() {
    startTimeout(3000);
    handleTimeout();
    return Observer(builder: (_) {
      return Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height / 3.5),
          alignment: Alignment.center,
          child: controller.isTimeout == false
              ? Container(
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
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    // )
                  ],
                ))
              : _showDialog());
    });
  }

  Widget _bodyPage() {
    return Observer(builder: (_) {
      return controller.repoInfoList.length == 0 ? _loadingPage() : _showInfo() ;
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
