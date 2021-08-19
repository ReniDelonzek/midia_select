import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:midia_select/models/item_midia.dart';
import 'package:msk_utils/utils/utils_platform.dart';
import 'package:path/path.dart';

class UtilsMidiaSelect {
  static ItemMidia getItemMidiaImage({String path, String url, dynamic obj}) {
    ItemMidia itemMidia =
        UtilsMidiaSelect.getItemMidia(path: path, url: url, obj: obj);
    itemMidia?.tipoMidia = TipoMidiaEnum.IMAGEM;
    return itemMidia;
  }

  static ItemMidia getItemMidiaVideo({String path, String url, dynamic obj}) {
    ItemMidia itemMidia =
        UtilsMidiaSelect.getItemMidia(path: path, url: url, obj: obj);
    itemMidia?.tipoMidia = TipoMidiaEnum.VIDEO;
    return itemMidia;
  }

  static ItemMidia getItemMidiaAudio({String path, String url, dynamic obj}) {
    ItemMidia itemMidia =
        UtilsMidiaSelect.getItemMidia(path: path, url: url, obj: obj);
    itemMidia?.tipoMidia = TipoMidiaEnum.AUDIO;
    return itemMidia;
  }

  static ItemMidia getItemMidia({String path, String url, dynamic obj}) {
    if (path != null || url != null) {
      ItemMidia item = ItemMidia();
      item.strings = Map();
      if (path != null) {
        item.strings['file'] = basename(path);
      }
      item.path = path;
      item.url = url;
      item.object = obj;
      return item;
    }
    return null;
  }

  static exibirOpcoesMidia(BuildContext buildContext,
      List<TipoMidiaEnum> tiposMidia, final Function(ItemMidia) midiaAdded) {
    if (tiposMidia.length == 1) {
      switch (tiposMidia.first) {
        case TipoMidiaEnum.IMAGEM:
          _exibirOpcoesFoto(buildContext, midiaAdded);
          break;
        case TipoMidiaEnum.VIDEO:
          _exibirOpcoesVideo(buildContext, midiaAdded);
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
                              _exibirOpcoesFoto(buildContext, midiaAdded);
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
                              _exibirOpcoesVideo(buildContext, midiaAdded);
                            })
                        : Container(),
                  ],
                ),
                onClosing: () {},
              ));
    }
  }

  static Future<void> _exibirOpcoesFoto(
      BuildContext context, final Function(ItemMidia) midiaAdded,
      {double maxWidth, double maxHeight}) async {
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
          ItemMidia item = getItemMidiaImage(path: path);
          if (item != null) {
            midiaAdded?.call(item);
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
                        ItemMidia item = getItemMidiaImage(path: image?.path);
                        if (item != null) {
                          midiaAdded?.call(item);
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

                        ItemMidia item = getItemMidiaImage(path: image?.path);
                        if (item != null) {
                          midiaAdded?.call(item);
                        }
                      },
                    ),
                  ],
                ),
              ));
    }
  }

  static Future<void> _exibirOpcoesVideo(
      BuildContext context, final Function(ItemMidia) midiaAdded) async {
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
          ItemMidia item = getItemMidiaVideo(path: path);
          if (item != null) {
            midiaAdded?.call(item);
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
                        ItemMidia item = getItemMidiaVideo(path: video?.path);

                        if (item != null) {
                          midiaAdded?.call(item);
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
                        ItemMidia item = getItemMidiaVideo(path: video?.path);

                        if (item != null) {
                          midiaAdded?.call(item);
                        }
                      },
                    ),
                  ],
                ),
              ));
    }
  }
}