import 'package:mobx/mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'onboarding_controller.g.dart';

@Injectable()
class OnboardingController = _OnboardingControllerBase
    with _$OnboardingController;

abstract class _OnboardingControllerBase with Store {
  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
