// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_midia_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ItemMidiaController on _ItemMidiaBase, Store {
  final _$itemAtom = Atom(name: '_ItemMidiaBase.item');

  @override
  ItemMidia get item {
    _$itemAtom.reportRead();
    return super.item;
  }

  @override
  set item(ItemMidia value) {
    _$itemAtom.reportWrite(value, super.item, () {
      super.item = value;
    });
  }

  @override
  String toString() {
    return '''
item: ${item}
    ''';
  }
}
