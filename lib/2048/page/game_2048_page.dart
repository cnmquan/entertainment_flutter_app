import 'package:flutter/material.dart';

import '../page.dart';

class Game2048HomePage extends StatelessWidget {
  const Game2048HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        fontFamily: r'StarJedi',
      ),
      child: const HomePage(),
    );
  }
}
