import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'additem.dart';
import 'api.dart';
import './additem.dart';
import './api.dart';
 

// updated

class ShoppingNotifier extends ChangeNotifier {
  List<ShoppingItem> _cachedList = [];
  List<ShoppingItem> list = [];
  ValueNotifier<String> filterText = ValueNotifier('All');
  bool fatching = false;
  Future getShoppingItem() async {
    fatching = true;
    list = await Api.getItems();
    _cachedList = list;
    fatching = false;
    notifyListeners();
  }

  void addShoppingItem(ShoppingItem todo) async {
    await Api.addShoppingItem(todo);
    await getShoppingItem();
  }

  Future<void> setDoneShoppingItem(ShoppingItem todo) async {
    todo.status = !todo.status;
    await Api.updateShoppingItem(todo);
    await getShoppingItem();
  }

  void removeShoppingItem(ShoppingItem todo) async {
    await Api.removeTodoModel(todo.id);
    await getShoppingItem();
  }

  void filterShoppingItem(String filterValue) {
    filterText.value = filterValue;
    list = _cachedList.where((element) {
      if (filterValue == 'Done') return element.status;
      if (filterValue == 'Undone') return !element.status;
      return true;
    }).toList();
    notifyListeners();
  }
}
