import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../dino_run/model.dart';

class GlobalFunctionManager {
  // This function will initialize hive with apps documents directory.
// Additionally it will also register all the hive adapters.
  static Future<void> initHive() async {
    // For web hive does not need to be initialized.
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      Hive.init(dir.path);
    }

    Hive.registerAdapter<PlayerData>(PlayerDataAdapter());
    Hive.registerAdapter<SettingData>(SettingDataAdapter());
  }
}
