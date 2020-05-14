// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seletor_midia_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SeletorMidiaController on _SeletorMidiaBase, Store {
  final _$tempoGravacaoAtom = Atom(name: '_SeletorMidiaBase.tempoGravacao');

  @override
  int get tempoGravacao {
    _$tempoGravacaoAtom.context.enforceReadPolicy(_$tempoGravacaoAtom);
    _$tempoGravacaoAtom.reportObserved();
    return super.tempoGravacao;
  }

  @override
  set tempoGravacao(int value) {
    _$tempoGravacaoAtom.context.conditionallyRunInAction(() {
      super.tempoGravacao = value;
      _$tempoGravacaoAtom.reportChanged();
    }, _$tempoGravacaoAtom, name: '${_$tempoGravacaoAtom.name}_set');
  }

  final _$gravandoAtom = Atom(name: '_SeletorMidiaBase.gravando');

  @override
  bool get gravando {
    _$gravandoAtom.context.enforceReadPolicy(_$gravandoAtom);
    _$gravandoAtom.reportObserved();
    return super.gravando;
  }

  @override
  set gravando(bool value) {
    _$gravandoAtom.context.conditionallyRunInAction(() {
      super.gravando = value;
      _$gravandoAtom.reportChanged();
    }, _$gravandoAtom, name: '${_$gravandoAtom.name}_set');
  }

  final _$midiaAtom = Atom(name: '_SeletorMidiaBase.midia');

  @override
  ObservableList<ItemMidia> get midia {
    _$midiaAtom.context.enforceReadPolicy(_$midiaAtom);
    _$midiaAtom.reportObserved();
    return super.midia;
  }

  @override
  set midia(ObservableList<ItemMidia> value) {
    _$midiaAtom.context.conditionallyRunInAction(() {
      super.midia = value;
      _$midiaAtom.reportChanged();
    }, _$midiaAtom, name: '${_$midiaAtom.name}_set');
  }

  final _$_SeletorMidiaBaseActionController =
      ActionController(name: '_SeletorMidiaBase');

  @override
  dynamic addFoto(File file) {
    final _$actionInfo = _$_SeletorMidiaBaseActionController.startAction();
    try {
      return super.addFoto(file);
    } finally {
      _$_SeletorMidiaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addVideo(File file) {
    final _$actionInfo = _$_SeletorMidiaBaseActionController.startAction();
    try {
      return super.addVideo(file);
    } finally {
      _$_SeletorMidiaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addAudio(String path) {
    final _$actionInfo = _$_SeletorMidiaBaseActionController.startAction();
    try {
      return super.addAudio(path);
    } finally {
      _$_SeletorMidiaBaseActionController.endAction(_$actionInfo);
    }
  }
}
