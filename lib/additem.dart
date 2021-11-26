import 'package:flutter/material.dart';

class AddItem {
  late String id;
  String title;
  bool status;

  AddItem({required this.title, this.status = false}) {
    id = UniqueKey().toString();
  }
}


/*
class myState extends ChangeNotifier {
  List<myListManager> _list = [];
  String _filterBy = 'all';

  List<myListManager> get list => _list;

  String get filterBy => _filterBy;

  void setFilterBy(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }
}

*/