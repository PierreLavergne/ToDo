// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

Future<List<Map<String, dynamic>>> getTodos() async {
  final url = '${dotenv.env['URL']}/todos';
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  } else {
    Logger().e(response.body);
    throw Exception('Failed to load todos');
  }
}

Future<void> putTodos(Map<String, String> todo) async {
  final url = '${dotenv.env['URL']}/todos';
  final response = await http.post(Uri.parse(url), body: todo);

  if (response.statusCode != 200) {
    Logger().e(response.body);
    throw Exception('Failed to update todo');
  }
}
