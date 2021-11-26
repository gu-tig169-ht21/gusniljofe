import 'additem.dart';

class ListManager {
  List<AddItem> ShoppingItems = [];

  ListManager();

  void addShoppingItem(AddItem item) {
    ShoppingItems.add(item);
  }

  void removeShoppingItem({id: String}) {
    ShoppingItems.removeWhere((element) => element.id == id);
  }

  void markAsComplete({id: String}) {
    ShoppingItems.firstWhere((element) => element.id == id).status = true;
  }

  void markAsIncomplete({id: String}) {
    ShoppingItems.firstWhere((element) => element.id == id).status = false;
  }

  void markStatus({index: int}) {
    ShoppingItems[index].status = !ShoppingItems[index].status;
  }
}
