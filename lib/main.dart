import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:playground/data/viewmodels/character_viewmodel.dart';
import 'package:provider/provider.dart';

import 'ui/characters/charactespage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => CharacterViewModel())],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: () {
          return MaterialApp(
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const CharactersPage(),
          );
        },
      ),
    );
  }
}
