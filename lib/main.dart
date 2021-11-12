import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainView(),
    );
  }
}

class MainView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Center(
            child: Padding(
          padding: const EdgeInsets.only(left: 55.0),
          child: Text('Shopping List'),
        )
        ),
        actions: [
          _dropdownMenu(),
             ],           
      ),
    
      body: ListView(children: [
        _checkbox('Milk'),
        _checkbox('Eggs'),
        _checkbox('Sriracha'),
        _checkbox('Instant noodles'),
      ]
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
        onPressed: () {
          print('add items page11');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SecondView()));
        },
      ),
    );
  }
}



Widget _dropdownMenu() {
  List<String> alt = ['Create new list', 'Check all', 'Uncheck all', 'Delete list'];

  return PopupMenuButton<String>(
    icon: Icon(Icons.filter_list),
    onSelected: altAction,
        itemBuilder: (BuildContext context) {
          return alt.map((String alt) {
            return PopupMenuItem(
              value: alt,
              child: Text(alt),
            );
          }).toList();
        }
      );
    }
 
    
    class SecondView extends StatelessWidget {
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.lightBlue,
              title: Center(
                child: Text('Add groceries'),
              )
              ),
          body: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                _textField(),
                Padding(
                  padding: EdgeInsets.only(left: 105.0, top: 30),
                  child: Row(children: [
                    _plusIcon(),
                    _textBox(),
                  ]),
                ),
              ],
            ),
          ),
        );
      }
    }
  
    Widget _textBox() {
      return Text('Add item');
    }
    
    Widget _plusIcon() {
      return IconButton(
        icon: Icon(Icons.add),
        onPressed: () {},
      );
    }
    
    Widget _textField() {
      return TextField(
          decoration: InputDecoration(
              hintText: 'Add groceries', border: const OutlineInputBorder()
              )
           );
    }
    
    Widget _checkbox(String toDo) {
      return CheckboxListTile(
          title: Text(toDo),
          value: false,
          onChanged: (value) {
            print('under construction');
          });
    }
    
    void altAction(String alt) {
      if (alt == 'Create new list') {
        print('New list Created');
        } 
        else if(alt == 'Check all') {
          print('All items checked');
        } 
        else if(alt == 'Uncheck all') {
          print('List unchecked');
        }
        else if(alt == 'Delete list'){
          print('List deleted');
        }
    }