import 'package:animelistapp/models/anime_model.dart';
import 'package:animelistapp/models/hive_db.dart';
import 'package:animelistapp/providers/anime_provider.dart';
import 'package:animelistapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class NewAnimeScreen extends StatefulWidget {
  NewAnimeScreen({super.key});

  @override
  State<NewAnimeScreen> createState() => _NewAnimeScreenState();
}

class _NewAnimeScreenState extends State<NewAnimeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController reviewController = TextEditingController();
  TextEditingController notaController = TextEditingController();
  TextEditingController imagemWeb = TextEditingController();
  String imgPath = "";
  final ImagePicker _picker = ImagePicker();
  XFile? photo;
  bool favorite = false;
  Box box = Hive.box("animebox");

  @override
  Widget build(BuildContext context) {
    return Consumer<AnimeProvider>(
      builder: (context, animeProvider, child) => SafeArea(
        child: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/ADD_EDIT.png"), fit: BoxFit.cover),
          ),
          child: Scaffold(
            // Macete para que o teclado não esprema a imagem do Container acima:
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Add Anime",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Digite o nome do anime."),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: reviewController,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Escreva um pouco do que achou."),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: TextField(
                        controller: notaController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Dê uma nota de 1 a 10."),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Marcar como favorito?"),
                          const SizedBox(width: 50),
                          Switch(
                              value: favorite,
                              activeColor: Colors.red,
                              onChanged: (bool value) {
                                setState(() {
                                  favorite = value;
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        children: [
                          TextButton(
                            child: const Text(
                              "Adicione uma imagem para a obra! (Armazenamento Interno)",
                              textAlign: TextAlign.center,
                            ),
                            onPressed: () async {
                              photo = await _picker.pickImage(
                                  source: ImageSource.gallery);
                              if (photo != null) {
                                imgPath = photo!.path;
                              }
                            },
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "OU",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                          TextField(
                            controller: imagemWeb,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Coloque um link da imagem da Web"),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                          color: Colors.amber[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: OutlinedButton(
                        child: const Text("Salvar"),
                        onPressed: () {
                          if (nameController.text != "" &&
                              reviewController.text != "" &&
                              (int.parse(notaController.text) > 0 &&
                                  int.parse(notaController.text) <= 10) &&
                              (imgPath != "" || imagemWeb.text != "")) {
                            box.add(AnimeModel(
                                nameController.text,
                                imgPath == "" ? imagemWeb.text : imgPath,
                                int.parse(notaController.text),
                                reviewController.text,
                                favorite));
                            Get.to(() => HomeScreen(0));
                          } else if (imgPath != "" && imagemWeb.text != "") {
                            Get.snackbar("Imagem de duas fontes!",
                                "Por favor, não preencha 2 imagens.\nPreencha UM CAMPO ou OUTRO CAMPO",
                                duration: const Duration(seconds: 7),
                                backgroundColor: Colors.purple[300],
                                snackPosition: SnackPosition.BOTTOM);
                          } else {
                            Get.snackbar("Atenção!",
                                "Todos os campos são obrigatórios!\nPor favor tenha certeza de que os preencheu corretamente!",
                                duration: const Duration(seconds: 7),
                                backgroundColor: Colors.red[300],
                                snackPosition: SnackPosition.BOTTOM);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
