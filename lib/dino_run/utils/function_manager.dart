import 'package:hive/hive.dart';

import '../model.dart';
import '../utils.dart';

class FunctionManager {
  /// This method reads [PlayerData] from the hive box.
  static Future<PlayerData> readPlayerData() async {
    final playerDataBox =
        await Hive.openBox<PlayerData>(ConstantManager.dinoPlayerDataBox);
    final playerData = playerDataBox.get(ConstantManager.dinoPlayerData);

    // If data is null, this is probably a fresh launch of the game.
    if (playerData == null) {
      // In such cases store default values in hive.
      await playerDataBox.put(ConstantManager.dinoPlayerData, PlayerData());
    }

    // Now it is safe to return the stored value.
    return playerDataBox.get(ConstantManager.dinoPlayerData)!;
  }

  /// This method reads [Settings] from the hive box.
  static Future<SettingData> readSettings() async {
    final settingsBox =
        await Hive.openBox<SettingData>(ConstantManager.dinoSettingDataBox);
    final settings = settingsBox.get(ConstantManager.dinoSettingData);

    // If data is null, this is probably a fresh launch of the game.
    if (settings == null) {
      // In such cases store default values in hive.
      await settingsBox.put(
        ConstantManager.dinoSettingData,
        SettingData(bgm: true, sfx: true),
      );
    }

    // Now it is safe to return the stored value.
    return settingsBox.get(ConstantManager.dinoSettingData)!;
  }
}
