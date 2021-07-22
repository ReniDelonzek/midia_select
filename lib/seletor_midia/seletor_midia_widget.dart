import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:midia_select/item_midia/item_midia_widget.dart';
import 'package:midia_select/models/item_midia.dart';
import 'package:midia_select/modules/ver_midia/ver_midia_module.dart';
import 'package:midia_select/utils/utils_midia_select.dart';
import 'package:msk_utils/msk_utils.dart';
import 'package:msk_utils/utils/navigation.dart';

import 'seletor_midia_controller.dart';

class SeletorMidiaWidget extends StatelessWidget {
  final SeletorMidiaController controller;
  final List<TipoMidiaEnum> tiposMidia;
  final double maxWidth;
  final double maxHeight;
  final Widget title;
  final Function(ItemMidia) mediaAdded;
  final Function(int) mediaExcluded;

  const SeletorMidiaWidget(this.controller,
      {this.maxWidth,
      this.maxHeight,
      this.title,
      this.tiposMidia = const [TipoMidiaEnum.IMAGEM],
      this.mediaAdded,
      this.mediaExcluded});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: (title ??
                Text(
                  'Adicione arquivos aqui',
                  style: TextStyle(fontSize: 18),
                )),
          ),
          Container(
            height: 205,
            child: Observer(builder: (_) {
              if (controller.midia
                  .where((element) => !element.deletado)
                  .isEmpty) {
                //caso a lista esteja vazia ou, todos os componentes estejam deletados
                return InkWell(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    UtilsMidiaSelect.exibirOpcoesMidia(context, tiposMidia,
                        (ItemMidia itemMidia) {
                      controller.midia.add(itemMidia);
                      mediaAdded?.call(itemMidia);
                    });
                  },
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Image.asset(
                              'imagens/add_files.png',
                              width: 100,
                              package: 'msk_widgets',
                            )),
                        Text("Toque em '+' para adicionar arquivos"),
                      ],
                    ),
                  ),
                );
              } else {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.midia.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      return Observer(
                          builder: (_) => !controller.midia[index].deletado
                              //Só exibe se não estiver deletado
                              ? Hero(
                                  tag: index,
                                  child: ItemMidiaWidget(
                                      controller.midia[index],
                                      () => _exibirOpcoesItem(context, index)),
                                )
                              //case esteja, apenas deixa um container vazio
                              : Container());
                    });
              }
            }),
          ),
          Container(
            padding: const EdgeInsets.only(top: 16),
            alignment: Alignment.centerRight,
            child: FloatingActionButton(
                heroTag: 'add_midia',
                child: Icon(Icons.add),
                onPressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  UtilsMidiaSelect.exibirOpcoesMidia(context, tiposMidia,
                      (ItemMidia itemMidia) {
                    controller.midia.add(itemMidia);
                    mediaAdded?.call(itemMidia);
                  });
                }),
          )
        ],
      ),
    );
  }

  _exibirOpcoesItem(BuildContext context, int pos) {
    showModalBottomSheet(
        context: context,
        builder: (bottomContext) => BottomSheet(
              onClosing: () {},
              builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Abrir'),
                    leading: Icon(Icons.fullscreen),
                    onTap: () {
                      Navigator.pop(bottomContext);
                      List<ItemMidia> itens = controller.midia
                          .where((element) => !element.deletado)
                          .toList();
                      int numDeletadosAteIndice = (controller.midia
                          .sublist(0, pos)
                          .where((element) => element.deletado)
                          .toList()
                          .length);
                      Navigation.push(
                          context,
                          VerMidiaModule(itens,
                              posicaoInicial: pos - numDeletadosAteIndice));
                    },
                  ),
                  ListTile(
                    title: Text('Remover'),
                    leading: Icon(Icons.close),
                    onTap: () {
                      controller.midia[pos].deletado = true;
                      mediaExcluded?.call(pos);
                      Navigator.pop(bottomContext);
                    },
                  )
                ],
              ),
            ));
  }
}
