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

            // Displays current spaceship's name and amount of money left.
            Consumer<PlayerData>(
              builder: (context, playerData, child) {
                final spaceship =
                    Spaceship.getSpaceshipByType(playerData.spaceshipType);
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          const TextSpan(
                            text: 'Ship: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white70,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(text: spaceship.name),
                        ],
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: r'Audiowide',
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          const TextSpan(
                            text: 'Money: ',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white70,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(text: '${playerData.money}'),
                        ],
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: r'Audiowide',
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: CarouselSlider.builder(
                itemCount: Spaceship.spaceships.length,
                slideBuilder: (index) {
                  final spaceship =
                      Spaceship.spaceships.entries.elementAt(index).value;
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        spaceship.assetPath,
                        width: 100,
                        height: 100,
                        fit: BoxFit.scaleDown,
                      ),
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            // const TextSpan(
                            //   text: 'Ship: ',
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.w700,
                            //     color: Colors.white70,
                            //     fontSize: 20,
                            //   ),
                            // ),
                            TextSpan(text: spaceship.name),
                          ],
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: r'Audiowide',
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            const TextSpan(
                              text: 'Speed: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(text: '${spaceship.speed.toInt()}'),
                          ],
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: r'Audiowide',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            const TextSpan(
                              text: 'Level: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(text: '${spaceship.level}'),
                          ],
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: r'Audiowide',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            const TextSpan(
                              text: 'Cost: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                            TextSpan(text: '${spaceship.cost}'),
                          ],
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: r'Audiowide',
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Consumer<PlayerData>(
                        builder: (context, playerData, child) {
                          final type =
                              Spaceship.spaceships.entries.elementAt(index).key;
                          final isEquipped = playerData.isEquipped(type);
                          final isOwned = playerData.isOwned(type);
                          final canBuy = playerData.canBuy(type);

                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 2.5,
                            height: 48,
                            child: ElevatedButton(
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
                                                backgroundColor:
                                                    Colors.red.shade400,
                                                title: const Text(
                                                  'Insufficient Balance',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white70,
                                                    fontFamily: r'Audiowide',
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                content: Text(
                                                  'Need ${spaceship.cost - playerData.money} more',
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: r'Audiowide',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isOwned
                                    ? Colors.blue.shade500
                                    : Colors.red.shade500,
                              ),
                              child: Text(
                                isEquipped
                                    ? 'Equipped'
                                    : isOwned
                                        ? 'Select'
                                        : 'Buy',
                                style: TextStyle(
                                  color: isEquipped
                                      ? Colors.green.shade500
                                      : Colors.white,
                                  fontFamily: r'Audiowide',
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            // Start button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 60,
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white70,
                ),
                child: const Text(
                  'Start',
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
            // Back button.
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
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
      ),
    );
  }
}
