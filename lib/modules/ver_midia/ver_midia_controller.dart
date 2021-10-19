import 'package:flutter/material.dart';
import 'package:midia_select/models/item_midia.dart';
import 'package:mobx/mobx.dart';

part 'ver_midia_controller.g.dart';

class VerMidiaController = _VerMidiaBase with _$VerMidiaController;

abstract class _VerMidiaBase with Store {
  List<ItemMidia> itens;
  int? posicao;
  final Color? backgroundColor;
  final Color? appBarColor;

  _VerMidiaBase(this.itens,
      {this.posicao = 0, this.backgroundColor, this.appBarColor});
}
