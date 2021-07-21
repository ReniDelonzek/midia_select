// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seletor_midia_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$SeletorMidiaController on _SeletorMidiaBase, Store {
  final _$tempoGravacaoAtom = Atom(name: '_SeletorMidiaBase.tempoGravacao');

  @override
  int get tempoGravacao {
    _$tempoGravacaoAtom.reportRead();
    return super.tempoGravacao;
  }

  @override
  set tempoGravacao(int value) {
    _$tempoGravacaoAtom.reportWrite(value, super.tempoGravacao, () {
      super.tempoGravacao = value;
    });
  }

  final _$gravandoAtom = Atom(name: '_SeletorMidiaBase.gravando');

  @override
  bool get gravando {
    _$gravandoAtom.reportRead();
    return super.gravando;
  }

  @override
  set gravando(bool value) {
    _$gravandoAtom.reportWrite(value, super.gravando, () {
      super.gravando = value;
    });
  }

  final _$midiaAtom = Atom(name: '_SeletorMidiaBase.midia');

  @override
  ObservableList<ItemMidia> get midia {
    _$midiaAtom.reportRead();
    return super.midia;
  }

  @override
  set midia(ObservableList<ItemMidia> value) {
    _$midiaAtom.reportWrite(value, super.midia, () {
      super.midia = value;
    });
  }

  final _$_SeletorMidiaBaseActionController =
      ActionController(name: '_SeletorMidiaBase');

  @override
  dynamic addFoto(String path) {
    final _$actionInfo = _$_SeletorMidiaBaseActionController.startAction(
        name: '_SeletorMidiaBase.addFoto');
    try {
      return super.addFoto(path);
    } finally {
      _$_SeletorMidiaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addVideo(String path) {
    final _$actionInfo = _$_SeletorMidiaBaseActionController.startAction(
        name: '_SeletorMidiaBase.addVideo');
    try {
      return super.addVideo(path);
    } finally {
      _$_SeletorMidiaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic addAudio(String path) {
    final _$actionInfo = _$_SeletorMidiaBaseActionController.startAction(
        name: '_SeletorMidiaBase.addAudio');
    try {
      return super.addAudio(path);
    } finally {
      _$_SeletorMidiaBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
tempoGravacao: ${tempoGravacao},
gravando: ${gravando},
midia: ${midia}
    ''';
  }
}
