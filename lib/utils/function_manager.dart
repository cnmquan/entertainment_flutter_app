import 'package:flutter/foundation.dart';
import 'package:flutter_camera_app/global/logic/secret_controller.dart';
import 'package:flutter_camera_app/spacescape/models/settings.dart';
import 'package:flutter_camera_app/two_zero_four_eight/model/board_adapter_model.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../dino_run/model.dart' as dinoModel;
import '../spacescape/model.dart' as SpacescapeModel;

class GlobalFunctionManager {
  // This function will initialize hive with apps documents directory.
// Additionally it will also register all the hive adapters.
  static Future<void> initHive() async {
    // For web hive does not need to be initialized.
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }

    Hive.registerAdapter<dinoModel.PlayerData>(dinoModel.PlayerDataAdapter());
    Hive.registerAdapter<dinoModel.SettingData>(dinoModel.SettingDataAdapter());
    Hive.registerAdapter(SpacescapeModel.PlayerDataAdapter());
    Hive.registerAdapter(SpacescapeModel.SpaceshipTypeAdapter());
    Hive.registerAdapter(SpacescapeModel.SettingsAdapter());
    Hive.registerAdapter(BoardAdapterModel());
    Hive.registerAdapter(SecretControllerAdapter());
  }

  /// This function reads the stored [PlayerData] from disk.
  static Future<SpacescapeModel.PlayerData> getSpacescapePlayerData() async {
    // Open the player data box and read player data from it.
    final box = await Hive.openBox<SpacescapeModel.PlayerData>(
        SpacescapeModel.PlayerData.playerDataBox);
    final playerData = box.get(SpacescapeModel.PlayerData.playerDataKey);

    // If player data is null, it means this is a fresh launch
    // of the game. In such case, we first store the default
    // player data in the player data box and then return the same.
    if (playerData == null) {
      box.put(
        SpacescapeModel.PlayerData.playerDataKey,
        SpacescapeModel.PlayerData.fromMap(
            SpacescapeModel.PlayerData.defaultData),
      );
    }

    return box.get(SpacescapeModel.PlayerData.playerDataKey)!;
  }

  /// This function reads the stored [Settings] from disk.
  static Future<Settings> getSpacescapeSettings() async {
    // Open the settings box and read settings from it.
    final box = await Hive.openBox<Settings>(Settings.settingsBox);
    final settings = box.get(Settings.settingsKey);

    // If settings is null, it means this is a fresh launch
    // of the game. In such case, we first store the default
    // settings in the settings box and then return the same.
    if (settings == null) {
      box.put(Settings.settingsKey,
          Settings(soundEffects: true, backgroundMusic: true));
    }

    return box.get(Settings.settingsKey)!;
  }

  static Future<SecretController> getSecretValue() async {
    final box = await Hive.openBox<SecretController>("secret");
    final secret = box.get("secretKey");

    if (secret == null) {
      box.put("secretKey", SecretController(isAnswer: false));
    }

    return box.get("secretKey")!;
  }
}
