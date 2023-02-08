import 'package:flutter/material.dart';

import 'select_spaceship.dart';
import 'settings_menu.dart';

// Represents the main menu screen of Spacescape, allowing
// players to start the game or modify in-game settings.
class SpacescapeMainMenu extends StatelessWidget {
  const SpacescapeMainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Game title.
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 50.0),
              child: Text(
                r'Spacescape',
                style: TextStyle(
                  fontSize: 50.0,
                  color: Colors.grey,
                  fontFamily: r'Audiowide',
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

            // Play button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  // Push and replace current screen (i.e MainMenu) with
                  // SelectSpaceship(), so that player can select a spaceship.
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SelectSpaceship(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                ),
                child: const Text(
                  'Play',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontFamily: r'Audiowide',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsMenu(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                ),
                child: const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontFamily: r'Audiowide',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).maybePop();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                ),
                child: const Text(
                  'Exit',
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
      ),
    );
  }
}
