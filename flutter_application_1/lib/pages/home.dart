import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/todo.dart';
import '../widgets/todo_item.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final todoList = ToDo.todoList();
  final _todoController = TextEditingController();
  List<ToDo> _foundToDo = [];

  @override
  void initState() {
    super.initState();
    _foundToDo = todoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(
                            top: 50,
                            bottom: 20,
                          ),
                          child: const Text(
                            'All ToDos',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w500,
                            ),
                          )),
                      for (ToDo todo in _foundToDo.reversed)
                        ToDoItem(
                            todo: todo,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                    child: Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    left: 20,
                    right: 20,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                      )
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    controller: _todoController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      border: InputBorder.none,
                      hintText: 'Add ToDo',
                      hintStyle: TextStyle(
                        color: tdGrey,
                        fontSize: 16,
                      ),
                    ),
                  ),
                )),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                    right: 20,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addToDoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue,
                      minimumSize: const Size(55, 55),
                      elevation: 10,
                    ),
                    child: const Text(
                      "+",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 25,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ]),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todoList.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String todoText) {
    setState(() {
      todoList.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        todoText: todoText,
      ));
      _todoController.clear();
    });
    _todoController.clear();
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];

    if (enteredKeyword.isEmpty){
      results = todoList;
    } else {
      results = todoList
          .where((item) =>
              item.todoText.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child:  TextField(
        onChanged: (value) => _runFilter(value),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(
            color: tdGrey,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
