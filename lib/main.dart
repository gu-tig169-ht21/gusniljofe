import 'package:flutter/material.dart';
import 'package:my_first_app/widgets.dart';
import './itemmanager.dart';
import 'additem.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
  ListManager myListManager = new ListManager();

  void _addItem(AddItem Item) {
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
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            _dropDownMenu(),
          ],
        ),
        body: ListView.builder(
            itemCount: myListManager.ShoppingItems.length,
            itemBuilder: (context, index) {
              return Card(
                key: UniqueKey(),
                child: ListTile(
                  title: Text(
                    myListManager.ShoppingItems[index].title,
                    style: myListManager.ShoppingItems[index].status
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
            }),
        floatingActionButton: PopupForm(callback: _addItem));
  }
}

Widget _dropDownMenu() {
  List<String> filterBy = ['all', 'done', 'undone'];

  return PopupMenuButton<String>(
      icon: Icon(Icons.filter_list),
      onSelected: altAction,
      itemBuilder: (BuildContext context) {
        return filterBy.map((String alt) {
          return PopupMenuItem(
            value: alt,
            child: Text(alt),
          );
        }).toList();
      });
}

void altAction(String alt) {
  if (alt == 'all') {
    print('all items');
  } else if (alt == 'done') {
    print('done items');
  } else if (alt == 'undone') {
    print('undone items');
  }
}


/*
void altAction(String filterBy) {
  if (filterBy == 'all') {
    return ;
  } else if (filterBy == 'done') {
    var list;
    return list.where((item) =>);
  } else if (filterBy == 'undone') {
    return;
  }
}

*/