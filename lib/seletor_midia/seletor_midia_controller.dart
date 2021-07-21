import 'package:midia_select/models/item_midia.dart';
import 'package:mobx/mobx.dart';
import 'package:path/path.dart';

part 'seletor_midia_controller.g.dart';

class SeletorMidiaController = _SeletorMidiaBase with _$SeletorMidiaController;

abstract class _SeletorMidiaBase with Store {
  @observable
  int tempoGravacao = 0;
  @observable
  bool gravando = false;
  @observable
  ObservableList<ItemMidia> midia = ObservableList();

  ItemMidia addFoto(String path, {String url, dynamic obj}) {
    if (path != null) {
      ItemMidia item = ItemMidia();
      item.strings = Map();
      item.strings['file'] = basename(path);
      item.path = path;
      item.url = url;
      item.object = obj;
      item.tipoMidia = TipoMidiaEnum.IMAGEM;
      midia.add(item);
      return item;
    }
    return null;
  }

  ItemMidia addVideo(String path, {String url, dynamic obj}) {
    if (path != null) {
      ItemMidia item = ItemMidia();
      item.strings = Map();
      item.strings['file'] = basename(path);
      item.path = path;
      item.url = url;
      item.object = obj;
      item.tipoMidia = TipoMidiaEnum.VIDEO;
      midia.add(item);
      return item;
    }
    return null;
  }

  addAudio(String path, {String url, dynamic obj}) {
    ItemMidia item = ItemMidia();
    item.strings = Map();
    item.strings['file'] = basename(path);
    item.path = path;
    item.url = url;
    item.object = obj;
    item.tipoMidia = TipoMidiaEnum.AUDIO;
    midia.add(item);
  }
}
