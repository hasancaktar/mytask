import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../model/news_model.dart';

class NewsServiceClass {
  static NewsServiceClass _newsServiceClass = NewsServiceClass._internal();

  NewsServiceClass._internal();

  factory NewsServiceClass() {
    return _newsServiceClass;
  }

  static Future<List<Articles>?> datas() async {
    String url =
        "https://newsapi.org/v2/everything?q=apple&from=2022-07-19&to=2022-07-19&sortBy=popularity&apiKey=e07b64f4a9d64f62b1a2f839b9b1acb4";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode==200) {
      final responseJson = jsonDecode(response.body);
      NewsModel newsModel = NewsModel.fromJson(responseJson);
      return newsModel.articles;
    } else {
      throw Exception("istek durumu başarısız oldu${response.statusCode}");

    }
  }
}
