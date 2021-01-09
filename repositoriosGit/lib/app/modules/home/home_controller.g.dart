// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// InjectionGenerator
// **************************************************************************

final $HomeController = BindInject(
  (i) => HomeController(),
  singleton: true,
  lazy: true,
);

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeController on _HomeControllerBase, Store {
  final _$valueAtom = Atom(name: '_HomeControllerBase.value');

  @override
  int get value {
    _$valueAtom.reportRead();
    return super.value;
  }

  @override
  set value(int value) {
    _$valueAtom.reportWrite(value, super.value, () {
      super.value = value;
    });
  }

  final _$isTimeoutAtom = Atom(name: '_HomeControllerBase.isTimeout');

  @override
  bool get isTimeout {
    _$isTimeoutAtom.reportRead();
    return super.isTimeout;
  }

  @override
  set isTimeout(bool value) {
    _$isTimeoutAtom.reportWrite(value, super.isTimeout, () {
      super.isTimeout = value;
    });
  }

  final _$getRepositoriosAsyncAction =
      AsyncAction('_HomeControllerBase.getRepositorios');

  @override
  Future<dynamic> getRepositorios() {
    return _$getRepositoriosAsyncAction.run(() => super.getRepositorios());
  }

  final _$_HomeControllerBaseActionController =
      ActionController(name: '_HomeControllerBase');

  @override
  void setTimeout(bool timeout) {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.setTimeout');
    try {
      return super.setTimeout(timeout);
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void increment() {
    final _$actionInfo = _$_HomeControllerBaseActionController.startAction(
        name: '_HomeControllerBase.increment');
    try {
      return super.increment();
    } finally {
      _$_HomeControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
value: ${value},
isTimeout: ${isTimeout}
    ''';
  }
}
