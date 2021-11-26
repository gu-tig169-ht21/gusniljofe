import 'package:flutter/material.dart';
import 'package:my_first_app/widgets.dart';
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
      home: MyHomePage(title: 'Shopping list'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ListManager myListManager = ListManager();

  List<ListManager> list = <ListManager>[];
  String activeFilter = 'All';

  void _addItem(ShoppingItem Item) {
    setState(() {
      myListManager.addShoppingItem(Item);
    });
  }

  void _toggleStatus(int index) {
    setState(() {
      myListManager.markStatus(index: index);
    });
  }

  void _removeItem(int index) {
    setState(() {
      myListManager.removeShoppingItem(
          id: myListManager.ShoppingItems[index].id);
    });
  }

  Icon _getCheckboxIcon(int index) {
    return myListManager.ShoppingItems[index].status
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
    var filteredList = _filter(myListManager.ShoppingItems);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            PopupMenuButton(
                itemBuilder: (context) => [
                      const PopupMenuItem(child: Text('All'), value: 'All'),
                      const PopupMenuItem(child: Text('Done'), value: 'Done'),
                      const PopupMenuItem(
                          child: Text('Undone'), value: 'Undone'),
                    ],
                onSelected: (String value) {
                  setState(() {
                    activeFilter = value;
                  });
                }),
          ],
        ),
        body: _buildbody(filteredList),
        floatingActionButton: PopupForm(callback: _addItem));
  }

  Widget _buildbody(List<ShoppingItem> filteredList) {
    return ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return Card(
            key: UniqueKey(),
            child: ListTile(
              title: Text(
                filteredList[index].title,
                style: filteredList[index].status
                    ? TextStyle(decoration: TextDecoration.lineThrough)
                    : TextStyle(decoration: TextDecoration.none),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: _getCheckboxIcon(index),
                    onPressed: () {
                      _toggleStatus(index);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.delete_outline,
                      size: 20.0,
                      color: Colors.lightBlue[400],
                    ),
                    onPressed: () {
                      _removeItem(index);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<ShoppingItem> _filter(List<ShoppingItem> listToFilter) {
    if (activeFilter == 'Done') {
      return listToFilter
          .where((ShoppingItem item) => item.status == true)
          .toList();
    }
    if (activeFilter == 'Undone') {
      return listToFilter
          .where((ShoppingItem item) => item.status == false)
          .toList();
    }
    return listToFilter;
  }

  void setComplete(ShoppingItem check) {
    setState(() {
      check.status = !check.status;
    });
  }
}
