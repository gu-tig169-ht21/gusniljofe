import 'dart:developer';
import 'package:flutter/material.dart';
import './api.dart';
import './shopping_notifier.dart';
import './widgets.dart';
import 'package:provider/provider.dart';
import './itemmanager.dart';
import 'additem.dart';
 
void main() {
  runApp(const MyApp());
}
 
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: ChangeNotifierProvider<ShoppingNotifier>(
        create: (context) => ShoppingNotifier(),
        child: const MyHomePage(title: 'Shopping list'),
      ),
    );
  }
}
 
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
 
  final String title;
 
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
 
class _MyHomePageState extends State<MyHomePage> {
  ListManager myListManager = ListManager();
 
  List<ListManager> list = <ListManager>[];
  String activeFilter = 'All';
 
  @override
  void initState() {
    var provider = context.read<ShoppingNotifier>();
    provider.getShoppingItem();
    provider.filterText.addListener(() {
      setState(() {
        activeFilter = provider.filterText.value;
      });
    });
 
    super.initState();
  }
 
  void _addItem(ShoppingItem item) async {
    context.read<ShoppingNotifier>().addShoppingItem(item);
  }
 
  void _toggleStatus(ShoppingItem shoppingItem) async {
    await context.read<ShoppingNotifier>().setDoneShoppingItem(shoppingItem);
  }
 
  void _removeItem(ShoppingItem item) {
    context.read<ShoppingNotifier>().removeShoppingItem(item);
  }
 
  Icon _getCheckboxIcon(bool state) {
    return state
        ? Icon(
            Icons.check_box_outlined,
            size: 20.0,
            color: Colors.lightBlue[400],
          )
        : Icon(
            Icons.check_box_outline_blank,
            size: 20.0,
            color: Colors.lightBlue[400],
          );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      PopupMenuItem(
                          child: Text(
                            'All',
                            style: TextStyle(
                                fontWeight: activeFilter == 'All'
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                          value: 'All'),
                      PopupMenuItem(
                          child: Text(
                            'Done',
                            style: TextStyle(
                                fontWeight: activeFilter == 'Done'
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                          value: 'Done'),
                      PopupMenuItem(
                          child: Text(
                            'Undone',
                            style: TextStyle(
                                fontWeight: activeFilter == 'Undone'
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                          value: 'Undone'),
                    ],
                onSelected: (String value) {
                  setState(() {
                    context.read<ShoppingNotifier>().filterShoppingItem(value);
                  });
                }),
          ],
        ),
        body: _buildbody(),
        floatingActionButton: PopupForm(callback: _addItem));
  }
 
  Widget _buildbody() {
    return Consumer<ShoppingNotifier>(
      builder: (context, value, child) => value.fatching
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: value.list.length,
              itemBuilder: (context, index) {
                var item = value.list[index];
                return Card(
                  key: UniqueKey(),
                  child: ListTile(
                    title: Text(
                      item.title,
                      style: item.status
                          ? const TextStyle(
                              decoration: TextDecoration.lineThrough)
                          : const TextStyle(decoration: TextDecoration.none),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: _getCheckboxIcon(item.status),
                          onPressed: () {
                            _toggleStatus(item);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete_outline,
                            size: 20.0,
                            color: Colors.lightBlue[400],
                          ),
                          onPressed: () {
                            _removeItem(item);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }),
    );
  }
 
  void changeState(ShoppingItem check) {
    setState(() {
      check.status = !check.status;
    });
  }
}
