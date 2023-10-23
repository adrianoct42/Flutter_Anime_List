import 'package:animelistapp/models/anime_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDB {
  HiveDB.criar();

  List<AnimeModel> obterAnimes(Box box, bool favorito) {
    if (favorito) {
      return box.values
          .cast<AnimeModel>()
          .where((element) => element.favorite == true)
          .toList();
    }
    return box.values.cast<AnimeModel>().toList();
  }

  void salvar(Box box, AnimeModel animeModel) {
    box.add(animeModel);
  }

  alterar(AnimeModel animeModel) {
    animeModel.save();
  }

  excluir(AnimeModel animeModel) {
    animeModel.delete();
  }

/*   // FIRST TIME EVER OPENING THE APP ONLY:
  void createInitialData() {
    animeList = [
      AnimeModel(
          "Legend of the Galactic Heroes",
          "https://www.themoviedb.org/t/p/original/j6amUPH88lc7cJf54MKZCf4a9NA.jpg",
          10,
          "Pure Perfection!",
          true)
    ];
  } */
}
