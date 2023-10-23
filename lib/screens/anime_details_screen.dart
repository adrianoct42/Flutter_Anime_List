import 'dart:io';
import 'package:animelistapp/models/anime_model.dart';
import 'package:flutter/material.dart';

class AnimeDetailsScreen extends StatelessWidget {
  AnimeDetailsScreen(this.animeEntry, {super.key});

  AnimeModel animeEntry;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/DETAILS.jpg"), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: const Text(
                      "DETALHES DA OBRA",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.amber[100],
                      borderRadius: BorderRadius.circular(12)),
                  child: (animeEntry.image.startsWith("http")
                      ? Image.network(
                          animeEntry.image,
                          height: 450,
                          width: 450,
                        )
                      : Image.file(
                          File(animeEntry.image),
                          height: 450,
                          width: 450,
                        )),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Text("Nome: ${animeEntry.name}"),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Text("Nota: ${animeEntry.score}"),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Text("Análise: ${animeEntry.review}"),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                        color: Colors.amber[100],
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(
                        "Favorito: ${(animeEntry.favorite == true ? "Sim! ⭐" : "Não! ❌")}"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
