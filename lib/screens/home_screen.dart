import 'package:animelistapp/models/anime_model.dart';
import 'package:animelistapp/models/hive_db.dart';
import 'package:animelistapp/screens/anime_list_screen.dart';
import 'package:animelistapp/screens/new_anime_screen.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen(this.selectedIndex, {Key? key}) : super(key: key);

  int selectedIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controllerPageView = PageController(initialPage: 0);
  @override
  void initState() {
    abreCaixa();
    super.initState();
  }

  void abreCaixa() async {
    if (Hive.isBoxOpen("animebox")) {
      Hive.box("animebox");
    } else {
      await Hive.openBox("animebox");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      widget.selectedIndex = index;
      if (widget.selectedIndex == 0) {
        Get.to(() => HomeScreen(widget.selectedIndex));
        setState(() {});
      } else if (widget.selectedIndex == 1) {
        Get.to(() => AnimeListScreen(widget.selectedIndex));
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: widget.selectedIndex,
          selectedItemColor: Colors.teal[200],
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
          onTap: _onItemTapped,
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
                      color: Colors.amberAccent[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "Olá! Bem-vindo(a) ao app!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                        backgroundColor: Colors.amberAccent[100]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.amberAccent[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: Text(
                    "Comece a adicionar animes clicando no botão abaixo!",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w100,
                        backgroundColor: Colors.amberAccent[100]),
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
            Get.to(() => NewAnimeScreen());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
