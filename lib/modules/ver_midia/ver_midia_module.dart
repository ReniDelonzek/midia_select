import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:midia_select/models/item_midia.dart';

import 'ver_midia_controller.dart';
import 'ver_midia_page.dart';

class VerMidiaModule extends ModuleWidget {
  final List<ItemMidia> itens;
  final int posicaoInicial;
  final Color? backgroundColor;
  final Color? appBarColor;

  VerMidiaModule(this.itens,
      {this.posicaoInicial = 0, this.backgroundColor, this.appBarColor});
  @override
  List<Bloc> get blocs => [
        Bloc((i) => VerMidiaController(this.itens,
            posicao: this.posicaoInicial,
            backgroundColor: backgroundColor,
            appBarColor: appBarColor))
      ];

  @override
  List<Dependency> get dependencies => [];

  @override
  Widget get view => VerMidiaPage();

  static Inject get to => Inject<VerMidiaModule>.of();
}
