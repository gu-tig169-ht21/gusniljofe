import 'package:flutter/material.dart';

class ShoppingItem {
  late String id;
  String title;
  bool status;

  ShoppingItem({required this.title, this.status = false}) {
    id = UniqueKey().toString();
  }
}