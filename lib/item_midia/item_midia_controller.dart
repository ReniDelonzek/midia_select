import 'package:midia_select/models/item_midia.dart';
import 'package:mobx/mobx.dart';

part 'item_midia_controller.g.dart';

class ItemMidiaController = _ItemMidiaBase with _$ItemMidiaController;

abstract class _ItemMidiaBase with Store {
  @observable
  ItemMidia item;
}
