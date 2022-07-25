import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mytask/viewmodel/favorite.dart';
import 'package:mytask/view/favorites_page.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../model/news_model.dart';

class NewsPage extends StatefulWidget {
  String? newsUrl = "";

  NewsPage({this.newsUrl});

  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  @override
  void initState() {
    super.initState();
    // Enable virtual display.
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  List<Articles> articles = [];
  static List<String?> favoriteDataList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
            onPressed: () {
             // print("Favori index+++++");

            //  print("Favori index" + Favorite.favoriteIndex.toString());
              // print("Favori " + Favorite.favoriteDataList[]..toString());
              Favorite
                  .favoriteDataList
                  .add(articles[Favorite.favoriteIndex].title??"hasan");
            },
            icon: Icon(Icons.favorite)),
        IconButton(onPressed: () {}, icon: Icon(Icons.share))
      ], title: Text("Detail")),
      body: WebView(
        initialUrl: widget.newsUrl,
      ),
    );
  }
}
