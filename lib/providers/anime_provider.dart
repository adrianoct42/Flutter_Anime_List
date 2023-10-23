import "package:animelistapp/models/anime_model.dart";
import "package:animelistapp/models/hive_db.dart";
import "package:flutter/material.dart";
import "package:hive/hive.dart";

class AnimeProvider extends ChangeNotifier {
  Box box = Hive.box("animebox");
  List<AnimeModel> animes = <AnimeModel>[];

  void getFavoritos() {
    var lista = box.values.cast<AnimeModel>().toList();
  }
}
