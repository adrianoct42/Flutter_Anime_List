import 'package:animelistapp/models/anime_model.dart';
import 'package:animelistapp/models/hive_db.dart';
import 'package:animelistapp/screens/anime_list.dart';
import 'package:animelistapp/screens/new_anime_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box boxAnime;
  late HiveDB hiveDB;
  var _animes = <AnimeModel>[];

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  void carregarDados() async {
    // Checa se a box existe ou está aberta, e abre caso não esteja:
    hiveDB = await HiveDB.iniciar();
    _animes = hiveDB.obterAnimes();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: Colors.teal,
          initialActiveIndex: 0,
          items: const [
            TabItem(icon: Icons.home, title: "Home"),
            TabItem(icon: Icons.list_alt, title: "Anime List")
          ],
          onTap: (index) {
            if (index == 0) {
              setState(() {
                Get.to(() => HomeScreen());
              });
            } else if (index == 1) {
              setState(() {
                Get.to(() => AnimeListScreen(hiveDB, _animes));
              });
            }
          },
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/HOME.jpg"), fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    "Olá! Bem-vindo(a) ao app!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                        backgroundColor: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text(
                    "Comece a adicionar animes clicando no botão abaixo!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                        backgroundColor: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple[300],
          onPressed: () {
            Get.to(() => NewAnimeScreen(hiveDB));
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
