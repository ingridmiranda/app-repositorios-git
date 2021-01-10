import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:repositoriosGit/app/modules/home/home_controller.dart';
import 'package:repositoriosGit/app/modules/home/home_module.dart';

void main() {
  initModule(HomeModule());
   HomeController home;
  
  setUp(() {
         home = HomeModule.to.get<HomeController>();
  });

  group('HomeController Test', () {
       test("First Test", () {
         expect(home, isInstanceOf<HomeController>());
       });

       test("Set Value", () {
         expect(home.value, equals(0));
         home.increment();
         expect(home.value, equals(1));
       });

       test("Set Timeout", () {
         home.setTimeout(true);
         expect(home.isTimeout, equals(true));
         home.setTimeout(false);
         expect(home.isTimeout, equals(false));
       });

       test("Get 100 repositories", () async{
         await home.getRepositorios();
         expect(home.repoInfoList.length, equals(100));
       });
  });
}
