import 'package:mobx/mobx.dart';
import 'package:msk_utils/models/item_select.dart';

part 'item_midia.g.dart';

class ItemMidia extends _ItemMidia with _$ItemMidia {
  ItemMidia(
      {String? url,
      String? path,
      TipoMidiaEnum tipoMidia = TipoMidiaEnum.IMAGEM,
      dynamic controlador})
      : super(
            path: path,
            url: url,
            tipoMidia: tipoMidia,
            controlador: controlador);
}

abstract class _ItemMidia extends ItemSelect with Store {
  String? url;
  String? path;
  TipoMidiaEnum tipoMidia;
  dynamic controlador;
  _ItemMidia(
      {this.path,
      this.url,
      this.tipoMidia = TipoMidiaEnum.IMAGEM,
      this.controlador});
}

enum TipoMidiaEnum { AUDIO, IMAGEM, VIDEO }

int getIntTipoMidia(TipoMidiaEnum tipo) {
  switch (tipo) {
    case TipoMidiaEnum.IMAGEM:
      return 1;
    case TipoMidiaEnum.VIDEO:
      return 2;
    case TipoMidiaEnum.AUDIO:
      return 3;
    default:
      return -1;
  }
}
