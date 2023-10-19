import 'package:hive_flutter/adapters.dart';

part 'anime_model.g.dart';

@HiveType(typeId: 0)
class AnimeModel extends HiveObject {
  AnimeModel(this.name, this.image, this.score, this.review, this.favorite);

  @HiveField(0)
  String name;

  @HiveField(1)
  String image;

  @HiveField(2)
  int score;

  @HiveField(3)
  String review;

  @HiveField(4)
  bool favorite;
}
