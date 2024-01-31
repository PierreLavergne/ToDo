// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

Future<List<Map<String, dynamic>>> getTodos(bool isJava) async {
  final url =
      isJava ? '${dotenv.env['URLJAVA']}/todos' : '${dotenv.env['URL']}/todos';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  } else {
    Logger().e(response.body);
    throw Exception('Failed to load todos');
  }
}

Future<void> postTodos(Map<String, String> todo, bool isJava) async {
  Logger().i(isJava);
  Logger().i(todo);
  final url =
      isJava ? '${dotenv.env['URLJAVA']}/todos' : '${dotenv.env['URL']}/todos';
  final response =
      await http.post(Uri.parse(url), body: jsonEncode(todo), headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  });

  if (response.statusCode != 200) {
    Logger().e(response.body);
    throw Exception('Failed to update todo');
  }
}

Future<void> putTodos(Map<String, String> todo, bool isJava) async {
  Logger().i(isJava);
  final url =
      isJava ? '${dotenv.env['URLJAVA']}/todos' : '${dotenv.env['URL']}/todos';
  final response =
      await http.put(Uri.parse(url), body: jsonEncode(todo), headers: {
    'Content-Type': 'application/json; charset=UTF-8',
  });
  if (response.statusCode != 200) {
    Logger().e(response.body);
    throw Exception('Failed to update todo');
  }
}
