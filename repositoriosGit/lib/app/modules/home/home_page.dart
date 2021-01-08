import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:url_launcher/url_launcher.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key key, this.title = "Home"}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {
  //use 'controller' variable to access controller

  void initState() {
    controller.getRepositorios();
    print(controller.repoInfoList); //.owner.avatar_url);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[_showInfo()],
      ),
    );
  }

  Widget _showInfo() {
    return Expanded(
          child: Observer(builder: (_) {
        return ListView.builder(
          itemCount: controller.repoInfoList.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(controller.repoInfoList[index].owner.avatar_url),
              title: Text(controller.repoInfoList[index].name),
              subtitle: Text(controller.repoInfoList[index].owner.login),
              onTap: () => _launchURL(controller.repoInfoList[index].html_url),
            );
          });
      }),
    );
  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
