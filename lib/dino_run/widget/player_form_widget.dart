import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_camera_app/dino_run/utils.dart';
import 'package:provider/provider.dart';

import '../logic/dino_game.dart';
import '../model.dart';
import '../widget.dart';

class PlayerFormWidget extends StatelessWidget {
  static const id = ConstantManager.playerFormWidgetId;
  const PlayerFormWidget(
    this.gameRef, {
    Key? key,
  }) : super(key: key);

  final DinoGame gameRef;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: gameRef.settingData,
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              color: Colors.black.withAlpha(100),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      TranslateManager.chooseFormText,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                    Selector<SettingData, int>(
                        selector: (_, settings) => settings.form ?? 0,
                        builder: (context, form, _) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.72,
                            height: 100,
                            child: Center(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: playerGifList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Provider.of<SettingData>(context,
                                              listen: false)
                                          .form = index;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Container(
                                        width: 100,
                                        height: 84,
                                        decoration: BoxDecoration(
                                          color: index == form
                                              ? Colors.white24
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: index == form
                                              ? null
                                              : Border.all(
                                                  color: Colors.white54),
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Image.asset(
                                          playerGifList[index],
                                          fit: BoxFit.contain,
                                          width: 100,
                                          height: 80,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                    const Text(
                      TranslateManager.chooseLevelText,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Colors.white70,
                      ),
                    ),
                    Selector<SettingData, int>(
                        selector: (_, settings) => settings.level ?? 1,
                        builder: (context, level, _) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width * 0.72,
                            height: 60,
                            child: Center(
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      Provider.of<SettingData>(context,
                                              listen: false)
                                          .level = index + 1;
                                      Provider.of<PlayerData>(context,
                                              listen: false)
                                          .lives = 5 - index;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 8),
                                      child: Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: index + 1 == level
                                              ? Colors.white24
                                              : Colors.transparent,
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: index + 1 == level
                                              ? null
                                              : Border.all(
                                                  color: Colors.white54),
                                        ),
                                        padding: const EdgeInsets.all(12),
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16,
                                            color: Colors.white70,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            gameRef.overlays.remove(PlayerFormWidget.id);
                            gameRef.overlays.add(MainMenuWidget.id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white30,
                          ),
                          child: const Text(
                            TranslateManager.backText,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            gameRef.startGamePlay();
                            gameRef.overlays.remove(PlayerFormWidget.id);
                            gameRef.overlays.add(HudWidget.id);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white30,
                          ),
                          child: const Text(
                            'Play',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
