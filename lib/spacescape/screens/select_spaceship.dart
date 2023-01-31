import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

import '../models/player_data.dart';
import '../models/spaceship_details.dart';

import 'game_play.dart';
import 'spacescape_main_menu.dart';

// Represents the spaceship selection menu from where player can
// change current spaceship or buy a new one.
class SelectSpaceship extends StatelessWidget {
  const SelectSpaceship({Key? key}) : super(key: key);

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
                'Select',
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

            // Displays current spaceship's name and amount of money left.
            Consumer<PlayerData>(
              builder: (context, playerData, child) {
                final spaceship =
                    Spaceship.getSpaceshipByType(playerData.spaceshipType);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Ship: ${spaceship.name}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Text(
                      'Money: ${playerData.money}',
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                );
              },
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: CarouselSlider.builder(
                itemCount: Spaceship.spaceships.length,
                slideBuilder: (index) {
                  final spaceship =
                      Spaceship.spaceships.entries.elementAt(index).value;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(spaceship.assetPath),
                      Text(
                        spaceship.name,
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Speed: ${spaceship.speed}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Level: ${spaceship.level}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Cost: ${spaceship.cost}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      Consumer<PlayerData>(
                        builder: (context, playerData, child) {
                          final type =
                              Spaceship.spaceships.entries.elementAt(index).key;
                          final isEquipped = playerData.isEquipped(type);
                          final isOwned = playerData.isOwned(type);
                          final canBuy = playerData.canBuy(type);

                          return ElevatedButton(
                            onPressed: isEquipped
                                ? null
                                : () {
                                    if (isOwned) {
                                      playerData.equip(type);
                                    } else {
                                      if (canBuy) {
                                        playerData.buy(type);
                                      } else {
                                        // Displays an alert if player
                                        // does not have enough money.
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              backgroundColor: Colors.red,
                                              title: const Text(
                                                'Insufficient Balance',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              content: Text(
                                                'Need ${spaceship.cost - playerData.money} more',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  },
                            child: Text(
                              isEquipped
                                  ? 'Equipped'
                                  : isOwned
                                      ? 'Select'
                                      : 'Buy',
                              style: const TextStyle(color: Colors.white),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),

            // Start button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  // Push and replace current screen (i.e MainMenu) with
                  // GamePlay, because back press will be blocked by GamePlay.
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const GamePlay(),
                    ),
                  );
                },
                child: const Text('Start'),
              ),
            ),

            // Back button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SpacescapeMainMenu(),
                    ),
                  );
                },
                child: const Icon(Icons.arrow_back),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
