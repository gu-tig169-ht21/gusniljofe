import 'dart:developer';

import 'package:flutter/material.dart';

class ShoppingItem {
  late String id;
  late String title;
  late bool status;

  ShoppingItem({required this.title, this.status = false, this.id = ''}) {
    id = UniqueKey().toString();
  }

  @override
  String toString() {
    return 'id==>$id|title==>$title|status==>$status';
  }

  ShoppingItem.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    status = json["done"] ?? false;
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['title'] = title;
    map['done'] = status;
    return map;
  }
}

// updated