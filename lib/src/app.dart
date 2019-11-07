import 'package:codelab_first_app/src/ui/random_words_list.dart';
import 'package:flutter/material.dart';

class StartupNamer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Startup Name',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: RandomWords(),
    );
  }
}
