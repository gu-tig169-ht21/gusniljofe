import 'package:flutter/material.dart';
import 'additem.dart';

class PopupForm extends StatefulWidget {
  Function callback;
  PopupForm({Key? key, required this.callback}) : super(key: key);

  @override
  _PopupFormState createState() => _PopupFormState();
}

class _PopupFormState extends State<PopupForm> {
  var titleController = new TextEditingController();

  void _addItem() {
    var item = ShoppingItem(title: titleController.text, status: false);

    setState(() {
      titleController.clear();
    });
    widget.callback(item);
    Navigator.pop(context);
  }

  Widget _openDialog() {
    return AlertDialog(
      scrollable: true,
      title: const Text('Add item'),
      content: Center(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'Item',
                  icon: Icon(Icons.task),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            _addItem();
          },
          child: const Text('Add'),
        ),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(context: context, builder: (_) => _openDialog());
      },
      tooltip: 'Add item',
      child: const Icon(Icons.shopping_cart),
    );
  }
}