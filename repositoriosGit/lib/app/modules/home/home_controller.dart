import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }

  @action
  Future getRepositorios() async{
    try {
      Response response = await Dio().get('https://api.github.com/repositories');
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
