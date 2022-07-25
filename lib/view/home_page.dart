import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mytask/viewmodel/favorite.dart';
import 'package:mytask/model/news_model.dart';
import 'package:mytask/service/news_service.dart';
import 'package:mytask/view/news_page.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  List<Articles> articles = [];
  List<Articles> ulist = [];
  List<Articles> userLists = [];
  final _debouncer = Debouncer();
 static int favoriIndex =0;

  @override
  void initState() {
    NewsServiceClass.datas().then((value) {
      articles = value!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NewsApp"),
        ),
        body: FutureBuilder(
          future: NewsServiceClass.datas(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
           //   var items = snapshot.data as List<Articles>;
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: TextField(
                      textInputAction: TextInputAction.search,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        suffixIcon: InkWell(
                          child: Icon(Icons.search),
                        ),
                        contentPadding: EdgeInsets.all(15.0),
                        hintText: 'Search ',
                      ),
                      onChanged: (string) {
                        searchMethod(string);
                      },
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: articles.length + 0,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: NewsListTitle(index),
                          onTap: () {
                            Favorite.favoriteIndex=index;
                            print("indexim"+index.toString());
                            print("favori indexim"+index.toString());
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => NewsPage(
                                          newsUrl: "${articles[index].url}",
                                        )));
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }

  void searchMethod(String string) {
    _debouncer.run(() {
      setState(() {
         articles
            .where(
              (u) => (u.title!.toLowerCase().contains(
                    string.toLowerCase(),
                  )),
            )
            .toList();
      });
    });
  }

  ListTile NewsListTitle(int index) {
    return ListTile(
      title: Text("${articles[index].title}"),
      subtitle: Text("${articles[index].content}",),
      trailing: Image.network("${articles[index].urlToImage}"),
     // leading: Text("$index"),
    );
  }
}

class Debouncer {
  int? milliseconds;
  VoidCallback? action;
  Timer? timer;

  run(VoidCallback action) {
    if (null != timer) {
      timer!.cancel();
    }
    timer = Timer(
      Duration(milliseconds: Duration.millisecondsPerSecond),
      action,
    );
  }
}
