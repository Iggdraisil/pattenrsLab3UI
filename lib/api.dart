import 'dart:convert';

import 'package:http/http.dart';
import 'package:patternslab3/model.dart';

class Api {
  static final String url = 'http://127.0.0.1:8000/messages/';

  static Future<List<Message>> fetchAllMessages() async {
    Response response = await get(Uri.parse(url));
    if (response.statusCode < 300 && response.statusCode >= 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => Message.fromMap(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<Message> sendMessage(OutComingMessage message) async {
    Response response = await post(Uri.parse(url), body: message.json());
    if (response.statusCode < 300 && response.statusCode >= 200) {
      return Message.fromMap(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<Message> updateMessage(OutComingMessage message, int id) async {
    Response response = await put(Uri.parse('$url$id'), body: message.json());
    if (response.statusCode < 300 && response.statusCode >= 200) {
      return Message.fromMap(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  static Future<Message> deleteMessage(int id) async {
    Response response = await delete(Uri.parse('$url$id'));
    if (response.statusCode < 300 && response.statusCode >= 200) {
      return Message.fromMap(jsonDecode(response.body));
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
