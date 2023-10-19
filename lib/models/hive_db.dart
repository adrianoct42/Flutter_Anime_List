import 'package:animelistapp/models/anime_model.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class HiveDB {
  static late Box _box;

  HiveDB._criar();

  static Future<HiveDB> iniciar() async {
    if (Hive.isBoxOpen("animebox")) {
      _box = Hive.box("animebox");
    } else {
      _box = await Hive.openBox("animebox");
    }

    return HiveDB._criar();
  }

  List<AnimeModel> obterAnimes() {
    return _box.values.cast<AnimeModel>().toList();
  }

  void salvar(AnimeModel animeModel) {
    _box.add(animeModel);
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
