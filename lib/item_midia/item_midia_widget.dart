import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:midia_select/models/item_midia.dart';
import 'package:msk_utils/utils/utils_platform.dart';

import 'item_midia_controller.dart';

class ItemMidiaWidget extends StatelessWidget {
  static const double HEIGHT = 140;
  static const double WIDTH = 110;

  final controller = ItemMidiaController();
  final VoidCallback _onTap;

  ItemMidiaWidget(ItemMidia itemFoto, this._onTap) {
    controller.item = itemFoto;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Container(
          width: 110,
          height: 180,
          child: Card(
            child: InkWell(
              onTap: _onTap,
              child: Column(
                children: <Widget>[
                  Container(
                    width: 110,
                    height: 140,
                    child: Stack(children: [
                      Container(width: 110, height: 180, child: _getMidia()),
                      Container(
                        width: 110,
                        height: 140,
                        color: controller.item.deletado == true
                            ? Colors.white70
                            : Colors.transparent,
                      ),
                    ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      controller.item.deletado
                          ? 'Removida'
                          : controller.item.strings.values.first ?? '',
                      overflow: TextOverflow.clip,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: controller.item.deletado
                          ? TextStyle(color: Colors.red)
                          : null,
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }

  Widget _getMidia() {
    switch (controller.item.tipoMidia) {
      case TipoMidiaEnum.IMAGEM:
        return _getImagem();
      case TipoMidiaEnum.AUDIO:
        return _getWidgetOutrasMidias(Image.asset(
          'imagens/icone_audio.png',
          width: WIDTH - 30,
          height: HEIGHT - 30,
        ));
      case TipoMidiaEnum.VIDEO:
        return _getWidgetOutrasMidias(Image.asset('imagens/icone_video.png'));
      default:
        return _getWidgetOutrasMidias(Image.asset('imagens/icone_video.png'));
    }
  }

  Widget _getWidgetOutrasMidias(Widget icone) {
    return Container(
      width: WIDTH,
      height: HEIGHT,
      child: Center(
        child: icone,
      ),
    );
  }

  _getImagem() {
    if (controller.item.url?.isNotEmpty == true) {
      if (UtilsPlatform.isWindows || UtilsPlatform.isWeb) {
        return Image.network(
          controller.item.url,
          width: WIDTH,
          height: HEIGHT,
          fit: BoxFit.cover,
        );
      } else
        return CachedNetworkImage(
          width: WIDTH,
          height: HEIGHT,
          fit: BoxFit.cover,
          errorWidget: (_, _a, _b) {
            return Text('Falha ao carregar imagem');
          },
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          imageUrl: controller.item.url,
        );
    } else {
      return Image.file(File(controller.item?.path),
          fit: BoxFit.cover, width: WIDTH, height: HEIGHT);
    }
  }
}
