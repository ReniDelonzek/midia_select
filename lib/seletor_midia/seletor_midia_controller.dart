import 'dart:io';

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

  @action
  addFoto(File file) {
    if (file != null) {
      ItemMidia item = ItemMidia();
      item.strings = Map();
      item.strings['file'] = basename(file.absolute.path);
      item.path = file.absolute.path;
      item.tipoMidia = TipoMidiaEnum.IMAGEM;
      midia.add(item);
    }
  }

  @action
  addVideo(File file) {
    if (file != null) {
      ItemMidia item = ItemMidia();
      item.strings = Map();
      item.strings['file'] = basename(file.absolute.path);
      item.path = file.absolute.path;
      item.tipoMidia = TipoMidiaEnum.VIDEO;
      midia.add(item);
    }
  }

  @action
  addAudio(String path) {
    ItemMidia item = ItemMidia();
    item.strings = Map();
    item.strings['file'] = basename(path);
    item.path = path;
    item.tipoMidia = TipoMidiaEnum.AUDIO;
    midia.add(item);
  }
}
