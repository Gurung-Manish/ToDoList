import 'dart:convert';
import 'package:to_do_list/ToDoList/ToDo_Model.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

class ToDoStorage {
  static const _todosKey = 'todos';

  Future<List<Todo>> getTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getStringList(_todosKey) ?? [];
    return todosJson.map((json) => Todo.fromMap(jsonDecode(json))).toList();
  }

  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = todos.map((todo) => jsonEncode(todo.toMap())).toList();
    await prefs.setStringList(_todosKey, todosJson);
  }
}
