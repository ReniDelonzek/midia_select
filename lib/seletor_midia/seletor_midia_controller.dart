import 'package:midia_select/models/item_midia.dart';
import 'package:mobx/mobx.dart';

part 'seletor_midia_controller.g.dart';

class SeletorMidiaController = _SeletorMidiaBase with _$SeletorMidiaController;

abstract class _SeletorMidiaBase with Store {
  @observable
  int tempoGravacao = 0;
  @observable
  bool gravando = false;
  @observable
  ObservableList<ItemMidia> midia = ObservableList();
}
