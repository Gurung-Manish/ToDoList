import 'package:flutter/material.dart';
import 'package:to_do_list/ToDoList/ToDo_Model.dart';
import 'package:to_do_list/ToDoList/todo_storage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(
        appTitle: "To Do",
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.appTitle});
  final String appTitle;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> _toDoList = [];
  final ToDoStorage toDoStorage = ToDoStorage();

  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    loadTodos();
  }

  Future<void> saveTodos() async {
    await toDoStorage.saveTodos(_toDoList);
  }

  Future<void> loadTodos() async {
    final loadedTodos = await toDoStorage.getTodos();
    setState(() {
      _toDoList = loadedTodos;
    });
  }

  Future<void> removeTodoAtIndex(int index) async {
    setState(() {
      _toDoList.removeAt(index);
    });
    await saveTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              setState(() {
                _toDoList.add(
                    Todo(title: "New title", description: "New Description"));
              });
              saveTodos();
            },
          )
        ],
      ),
      body: ListView.builder(
          key: _key,
          itemCount: _toDoList.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.blue[200],
              child: Dismissible(
                key: UniqueKey(),
                background: Container(
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) {
                  setState(() {
                    removeTodoAtIndex(index);
                  });
                },
                child: ListTile(
                  title: Text("${_toDoList[index].title}" " ${index + 1}"),
                ),
              ),
            );
          }),
    );
  }
}
