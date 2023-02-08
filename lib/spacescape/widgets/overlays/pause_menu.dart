import 'package:flutter/material.dart';

import '../../game/game.dart';
import '../../screens/spacescape_main_menu.dart';
import 'pause_button.dart';

// This class represents the pause menu overlay.
class PauseMenu extends StatelessWidget {
  static const String id = 'PauseMenu';
  final SpacescapeGame gameRef;

  const PauseMenu({Key? key, required this.gameRef}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Pause menu title.
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: Text(
              'Paused',
              style: TextStyle(
                fontSize: 50.0,
                color: Colors.grey,
                shadows: [
                  Shadow(
                    blurRadius: 20.0,
                    color: Colors.white,
                    offset: Offset(0, 0),
                  )
                ],
              ),
            ),
          ),

          // Resume button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                gameRef.resumeEngine();
                gameRef.overlays.remove(PauseMenu.id);
                gameRef.overlays.add(PauseButton.id);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70,
              ),
              child: const Text(
                'Resume',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontFamily: r'Audiowide',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          // Restart button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.id);
                gameRef.overlays.add(PauseButton.id);
                gameRef.reset();
                gameRef.resumeEngine();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70,
              ),
              child: const Text(
                'Restart',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontFamily: r'Audiowide',
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          // Exit button.
          SizedBox(
            width: MediaQuery.of(context).size.width / 2,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                gameRef.overlays.remove(PauseMenu.id);
                gameRef.reset();
                gameRef.resumeEngine();

                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const SpacescapeMainMenu(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white70,
              ),
              child: const Text(
                'Back',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontFamily: r'Audiowide',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
