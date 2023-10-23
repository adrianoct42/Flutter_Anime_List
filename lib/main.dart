import 'package:animelistapp/models/anime_model.dart';
import 'package:animelistapp/models/hive_db.dart';
import 'package:animelistapp/providers/anime_provider.dart';
import 'package:animelistapp/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import "package:path_provider/path_provider.dart" as path_provider;
import 'package:provider/provider.dart';

void main() async {
/*   // Iniciando HIVE:
  await Hive.initFlutter();
  // Iniciando a box:
  var box = await Hive.openBox("animebox"); */
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(AnimeModelAdapter());
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => AnimeProvider())],
      child: const GetMaterialApp(home: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anime App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(0),
    );
  }
}
