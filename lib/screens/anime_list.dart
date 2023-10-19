import 'package:animelistapp/models/anime_model.dart';
import 'package:animelistapp/models/hive_db.dart';
import 'package:animelistapp/screens/anime_details_screen.dart';
import 'package:animelistapp/screens/edit_anime_screen.dart';
import 'package:animelistapp/screens/home_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AnimeListScreen extends StatefulWidget {
  AnimeListScreen(this.hiveDB, this._animes, {super.key});

  HiveDB hiveDB;
  List<AnimeModel> _animes;

  @override
  State<AnimeListScreen> createState() => _AnimeListScreenState();
}

class _AnimeListScreenState extends State<AnimeListScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: ConvexAppBar(
          initialActiveIndex: 1,
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
                Get.to(() => AnimeListScreen(widget.hiveDB, widget._animes));
              });
            }
          },
        ),
        body: widget._animes.isEmpty
            ? Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/LIST.jpg"), fit: BoxFit.cover),
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
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/LIST.jpg"), fit: BoxFit.cover),
                ),
                child: ListView.builder(
                  itemCount: widget._animes.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (DismissDirection dismissDirection) async {
                        widget.hiveDB.excluir(widget._animes[index]);
                        setState(() {});
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
                                                    BorderRadius.circular(18.0),
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Get.to(() => EditAnimeScreen(
                                                widget.hiveDB,
                                                widget._animes[index]));
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
                                              Get.to(() => AnimeDetailsScreen(
                                                  widget._animes[index]));
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
                          color: Colors.amber[100],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          margin: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(36),
                                child: Text(
                                  widget._animes[index].name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
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
    );
  }
}
