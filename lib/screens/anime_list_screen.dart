import 'package:animelistapp/models/anime_model.dart';
import 'package:animelistapp/models/hive_db.dart';
import 'package:animelistapp/providers/anime_provider.dart';
import 'package:animelistapp/screens/anime_details_screen.dart';
import 'package:animelistapp/screens/edit_anime_screen.dart';
import 'package:animelistapp/screens/home_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class AnimeListScreen extends StatefulWidget {
  AnimeListScreen(this.selectedIndex, {super.key});

  int selectedIndex;

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  // Inicializando sem nada o hiveDB:
  HiveDB hiveDB = HiveDB.criar();
  List<AnimeModel> animes = <AnimeModel>[];
  List<AnimeModel> animesFavoritos = <AnimeModel>[];
  Box box = Hive.box("animebox");
  bool favorite = false;

  @override
  void initState() {
    carregarDados();
    super.initState();
  }

  void carregarDados() {
    setState(() {
      animes = hiveDB.obterAnimes(box, false);
      animesFavoritos = animes.where((anime) => anime.favorite).toList();
    });
  }

  void _onItemTapped(int index) {
    widget.selectedIndex = index;
    if (widget.selectedIndex == 0) {
      setState(() {
        Get.to(() => HomeScreen(widget.selectedIndex));
      });
    } else if (widget.selectedIndex == 1) {
      setState(() {
        Get.to(() => AnimeListScreen(widget.selectedIndex));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimeProvider>(
      builder: (context, animeProvider, child) => SafeArea(
        child: Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blue[300],
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'Anime List',
              ),
            ],
            currentIndex: widget.selectedIndex,
            onTap: _onItemTapped,
          ),
          body: animes.isEmpty
              ? Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/LIST.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: Center(
                    child: (Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        padding: const EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                            color: Colors.amber[100],
                            borderRadius: BorderRadius.circular(12)),
                        child: const Text(
                          "Nenhum anime adicionado!\nComece adicionando na página Home. :)",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )),
                  ),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/LIST.jpg"),
                        fit: BoxFit.cover),
                  ),
                  child: ListView.builder(
                    itemCount: animes.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (DismissDirection dismissDirection) async {
                          // o onDismissed já AUTOMATICAMENTE chama um setState
                          // após sua execução.
                          hiveDB.excluir(animes[index]);
                        },
                        child: InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext bc) {
                                  return AlertDialog(
                                    title: const Text(
                                      "O que deseja fazer?",
                                      textAlign: TextAlign.center,
                                    ),
                                    actionsAlignment: MainAxisAlignment.center,
                                    backgroundColor: Colors.green[200],
                                    actions: [
                                      Column(
                                        children: [
                                          const SizedBox(height: 20),
                                          OutlinedButton(
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          18.0),
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                              setState(() {
                                                Get.to(() => EditAnimeScreen(
                                                    hiveDB, animes[index]));
                                              });
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.all(16.0),
                                              child: Text(
                                                "Editar",
                                                style: TextStyle(
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 40),
                                          OutlinedButton(
                                              style: ButtonStyle(
                                                shape:
                                                    MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                setState(() {
                                                  Get.to(() =>
                                                      AnimeDetailsScreen(
                                                          animes[index]));
                                                });
                                              },
                                              child: const Padding(
                                                padding: EdgeInsets.all(16.0),
                                                child: Text(
                                                  "Detalhes",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              )),
                                          const SizedBox(height: 40),
                                        ],
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Card(
                            elevation: 8,
                            color: Colors.purple[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)),
                            margin: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 12),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(36),
                                  child: ListTile(
                                    title: Text(
                                      animes[index].name,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                    trailing: Switch(
                                      activeColor: Colors.amber[100],
                                      onChanged: (bool value) async {
                                        animes[index].favorite = value;
                                        hiveDB.alterar(animes[index]);
                                        hiveDB.obterAnimes(box, value);
                                        setState(() {});
                                      },
                                      value: animes[index].favorite,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
