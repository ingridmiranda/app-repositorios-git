import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:repositoriosGit/app/modules/home/repo_info.dart';

part 'home_controller.g.dart';

@Injectable()
class HomeController = _HomeControllerBase with _$HomeController;

abstract class _HomeControllerBase with Store {
  @observable
  int value = 0;

  ObservableList<RepoInfo> repoInfoList = ObservableList<RepoInfo>();

  @action
  void increment() {
    value++;
  }

  @action
  Future getRepositorios() async{
    try {
      Response response = await Dio().get('https://api.github.com/repositories');
      print(response);
      print("Status code: " + response.statusCode.toString());

      if (response.statusCode == 200){
      List<RepoInfo> repoList = List<RepoInfo>(100);
      repoList = (response.data as List)
        .map((e) => new RepoInfo.fromMap(e as Map<String, dynamic>))
        .toList();
      repoInfoList.addAll(repoList);
      }
    } catch (e) {
      print(e);
    }
  }
}
