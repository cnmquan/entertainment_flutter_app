import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_app/spacescape/models/settings.dart';
import 'package:provider/provider.dart';

// This class represents the settings menu.
class SettingsMenu extends StatelessWidget {
  const SettingsMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Game title.
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 50.0),
                child: Text(
                  'Settings',
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

              // Switch for sound effects.
              Selector<Settings, bool>(
                selector: (context, settings) => settings.soundEffects,
                builder: (context, value, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Sound Effects',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white70,
                          fontFamily: r'Audiowide',
                        ),
                      ),
                      CupertinoSwitch(
                        value: value,
                        onChanged: (bool newValue) {
                          Provider.of<Settings>(context, listen: false)
                              .soundEffects = newValue;
                        },
                        activeColor: CupertinoColors.opaqueSeparator,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 36,
              ),
              // Switch for background music.
              Selector<Settings, bool>(
                selector: (context, settings) => settings.backgroundMusic,
                builder: (context, value, child) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Background Music',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white70,
                          fontFamily: r'Audiowide',
                        ),
                      ),
                      CupertinoSwitch(
                        value: value,
                        onChanged: (bool newValue) {
                          Provider.of<Settings>(context, listen: false)
                              .backgroundMusic = newValue;
                        },
                        activeColor: CupertinoColors.opaqueSeparator,
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 40,
              ),
              // Back button.
              SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
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
      ),
    );
  }
}
