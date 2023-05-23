import 'package:flutter/material.dart';

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
  final _toDoList = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  //adding function
  void _addItem() {
    _toDoList.insert(
        _toDoList.length, "This is item no. ${_toDoList.length + 1}");
    _key.currentState!.insertItem(
      _toDoList.length - 1,
      duration: const Duration(milliseconds: 300),
    );
  }

  //remove function
  void _removeItem(int index) {
    _key.currentState!.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: Card(
          color: Colors.red[100],
          margin: const EdgeInsets.all(5),
          child: const ListTile(
            title: Text("Completed"),
          ),
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );
    _toDoList.removeAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        actions: [
          IconButton(
              // onPressed: () {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(content: Text('This is a snackbar')));
              // },
              onPressed: _addItem,
              icon: const Icon(Icons.add_circle))
        ],
      ),
      body: AnimatedList(
          key: _key,
          initialItemCount: 0,
          itemBuilder: (context, index, animation) {
            return SizeTransition(
              sizeFactor: animation,
              key: UniqueKey(),
              child: Card(
                color: Colors.blue[200],
                child: ListTile(
                  title: Text(_toDoList[index]),
                  trailing: IconButton(
                    onPressed: () {
                      _removeItem(index);
                    },
                    icon: const Icon(Icons.check_circle),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
