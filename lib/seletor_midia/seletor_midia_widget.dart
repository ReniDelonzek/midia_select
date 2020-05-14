import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:midia_select/item_midia/item_midia_widget.dart';
import 'package:midia_select/models/item_midia.dart';
import 'package:midia_select/modules/ver_midia/ver_midia_module.dart';
import 'package:msk_utils/utils/navigation.dart';

import 'seletor_midia_controller.dart';

class SeletorMidiaWidget extends StatelessWidget {
  final SeletorMidiaController controller;
  final List<TipoMidiaEnum> tiposMidia;
  final double maxWidth;
  final double maxHeight;

  const SeletorMidiaWidget(this.controller,
      {this.maxWidth,
      this.maxHeight,
      this.tiposMidia = const [TipoMidiaEnum.IMAGEM]});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Adicione arquivos aqui',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Container(
            height: 200,
            child: Observer(builder: (_) {
              if (controller.midia
                  .where((element) => !element.deletado)
                  .isEmpty) {
                //caso a lista esteja vazia ou, todos os componentes estejam deletados
                return Center(
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
              child: Icon(Icons.add),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                _exibirOpcoesMidia(context);
              },
            ),
          )
        ],
      ),
    );
  }

  _exibirOpcoesMidia(BuildContext buildContext) {
    if (tiposMidia.length == 1) {
      switch (tiposMidia.first) {
        case TipoMidiaEnum.IMAGEM:
          _exibirOpcoesFoto(buildContext);
          break;
        case TipoMidiaEnum.VIDEO:
          _exibirOpcoesVideo(buildContext);
          break;
        case TipoMidiaEnum.AUDIO:
          break;
      }
    } else {
      showModalBottomSheet(
          context: buildContext,
          builder: (context) => BottomSheet(
                builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    tiposMidia.contains(TipoMidiaEnum.IMAGEM)
                        ? ListTile(
                            title: Text('Foto'),
                            leading: Icon(Icons.camera),
                            onTap: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                              _exibirOpcoesFoto(buildContext);
                            })
                        : Container(),
                    tiposMidia.contains(TipoMidiaEnum.VIDEO)
                        ? ListTile(
                            title: Text('Vídeo'),
                            leading: Icon(Icons.videocam),
                            onTap: () {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                              _exibirOpcoesVideo(buildContext);
                            })
                        : Container(),
                  ],
                ),
                onClosing: () {},
              ));
    }
  }

  void _exibirOpcoesFoto(BuildContext context) {
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Selecione a forma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Câmera'),
                leading: Icon(Icons.camera),
                onTap: () async {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  var image = await ImagePicker.pickImage(
                      source: ImageSource.camera,
                      maxWidth: maxWidth,
                      maxHeight: maxHeight);
                  controller.addFoto(image);
                },
              ),
              ListTile(
                title: Text('Galeria'),
                leading: Icon(Icons.image),
                onTap: () async {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  var image = await ImagePicker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: maxWidth,
                      maxHeight: maxHeight);

                  controller.addFoto(image);
                },
              ),
            ],
          ),
        ));
  }

  void _exibirOpcoesVideo(BuildContext context) {
    showDialog(
        context: context,
        child: AlertDialog(
          title: Text('Selecione a forma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Câmera'),
                leading: Icon(Icons.camera),
                onTap: () async {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  var image =
                      await ImagePicker.pickVideo(source: ImageSource.camera);
                  controller.addVideo(image);
                },
              ),
              ListTile(
                title: Text('Galeria'),
                leading: Icon(Icons.image),
                onTap: () async {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  var image =
                      await ImagePicker.pickVideo(source: ImageSource.gallery);
                  controller.addVideo(image);
                },
              ),
            ],
          ),
        ));
  }

  _exibirOpcoesItem(BuildContext context, int pos) {
    showModalBottomSheet(
        context: context,
        builder: (_) => BottomSheet(
              onClosing: () {},
              builder: (_) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text('Abrir'),
                    leading: Icon(Icons.fullscreen),
                    onTap: () {
                      Navigator.pop(context);
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
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ));
  }
}
