import 'package:flutter/material.dart';
import 'package:mytask/viewmodel/favorite.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  //List<String> favoriteDataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite")),
      body: ListView.builder(
          itemCount: Favorite.favoriteDataList.length+0,
          itemBuilder: (context, snapshot) {
            return ListTile(
              title: Text(Favorite.favoriteDataList.toString()),
            );
          }),
    );
  }
}
