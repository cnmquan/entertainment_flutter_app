import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../logic/dino_game.dart';
import '../model.dart';
import '../utils.dart';
import '../widget.dart';

// This represents the settings menu overlay.
class SettingsWidget extends StatelessWidget {
  // An unique identified for this overlay.
  static const id = ConstantManager.settingsWidgetId;

  // Reference to parent game.
  final DinoGame gameRef;

  const SettingsWidget(this.gameRef, {Key? key}) : super(key: key);

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
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Selector<SettingData, bool>(
                      selector: (_, settings) => settings.bgm,
                      builder: (context, bgm, __) {
                        return SwitchListTile(
                          title: const Text(
                            TranslateManager.musicText,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          value: bgm,
                          onChanged: (bool value) {
                            Provider.of<SettingData>(context, listen: false)
                                .bgm = value;
                            if (value) {
                              AudioManager.instance
                                  .startBgm(SoundManager.audio8BitPlatform);
                            } else {
                              AudioManager.instance.stopBgm();
                            }
                          },
                        );
                      },
                    ),
                    Selector<SettingData, bool>(
                      selector: (_, settings) => settings.sfx,
                      builder: (context, sfx, __) {
                        return SwitchListTile(
                          title: const Text(
                            TranslateManager.effectText,
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                            ),
                          ),
                          value: sfx,
                          onChanged: (bool value) {
                            Provider.of<SettingData>(context, listen: false)
                                .sfx = value;
                          },
                        );
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        gameRef.overlays.remove(SettingsWidget.id);
                        gameRef.overlays.add(MainMenuWidget.id);
                      },
                      child: const Icon(Icons.arrow_back_ios_rounded),
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
