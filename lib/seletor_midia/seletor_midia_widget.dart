import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:midia_select/item_midia/item_midia_widget.dart';
import 'package:midia_select/models/item_midia.dart';
import 'package:midia_select/modules/ver_midia/ver_midia_module.dart';
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
                    _exibirOpcoesMidia(context);
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

  Future<void> _exibirOpcoesFoto(BuildContext context) async {
    if (!UtilsPlatform.isMobile) {
      try {
        String ex = 'jpg, png, jpeg';
        FilePickerCross filePickerCross =
            await FilePickerCross.importFromStorage(
                type: FileTypeCross.image, fileExtension: ex);
        if (filePickerCross != null) {
          String path = filePickerCross.path;
          if (UtilsPlatform.isMacos) {
            // Corrige nomes dos arquivos errados

            path = filePickerCross.path.replaceAll(ex, '');
          }
          ItemMidia item = controller.addFoto(path);
          if (item != null) {
            mediaAdded?.call(item);
          }
        }
      } catch (e) {
        print(e);
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
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
                        PickedFile image = await ImagePicker().getImage(
                            source: ImageSource.camera,
                            maxWidth: maxWidth,
                            maxHeight: maxHeight);
                        ItemMidia item = controller.addFoto(image?.path);
                        if (item != null) {
                          mediaAdded?.call(item);
                        }
                      },
                    ),
                    ListTile(
                      title: Text('Galeria'),
                      leading: Icon(Icons.image),
                      onTap: () async {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        PickedFile image = await ImagePicker().getImage(
                            source: ImageSource.gallery,
                            maxWidth: maxWidth,
                            maxHeight: maxHeight);

                        ItemMidia item = controller.addFoto(image?.path);
                        if (item != null) {
                          mediaAdded?.call(item);
                        }
                      },
                    ),
                  ],
                ),
              ));
    }
  }

  Future<void> _exibirOpcoesVideo(BuildContext context) async {
    if (!UtilsPlatform.isMobile) {
      try {
        String ex = 'mp4, mov, 3gp';
        FilePickerCross filePickerCross =
            await FilePickerCross.importFromStorage(
                type: FileTypeCross.image, fileExtension: ex);
        if (filePickerCross != null) {
          String path = filePickerCross.path;
          if (UtilsPlatform.isMacos) {
            // Corrige nomes dos arquivos errados

            path = filePickerCross.path.replaceAll(ex, '');
          }
          ItemMidia item = controller.addVideo(path);
          if (item != null) {
            mediaAdded?.call(item);
          }
        }
      } catch (_) {}
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
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
                        PickedFile video = await ImagePicker()
                            .getVideo(source: ImageSource.camera);
                        ItemMidia item = controller.addVideo(video?.path);

                        if (item != null) {
                          mediaAdded?.call(item);
                        }
                      },
                    ),
                    ListTile(
                      title: Text('Galeria'),
                      leading: Icon(Icons.image),
                      onTap: () async {
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        PickedFile video = await ImagePicker()
                            .getVideo(source: ImageSource.gallery);
                        ItemMidia item = controller.addVideo(video?.path);

                        if (item != null) {
                          mediaAdded?.call(item);
                        }
                      },
                    ),
                  ],
                ),
              ));
    }
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
