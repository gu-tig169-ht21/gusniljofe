import './additem.dart';
 
class ListManager {
  List<ShoppingItem> shoppingItems = [];
 
  void addShoppingItem(ShoppingItem item) {
    shoppingItems.add(item);
  }
 
  void removeShoppingItem({required String id}) {
    shoppingItems.removeWhere((element) => element.id == id);
  }
 
  void markAsComplete({required String id}) {
    shoppingItems.firstWhere((element) => element.id == id).status = true;
  }
 
  void markAsIncomplete({required String id}) {
    shoppingItems.firstWhere((element) => element.id == id).status = false;
  }
 
  void markStatus({required int index}) {
    shoppingItems[index].status = !shoppingItems[index].status;
  }
}

