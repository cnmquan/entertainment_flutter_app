import 'package:flame_audio/flame_audio.dart';

import '../model.dart';

class AudioManager {
  late SettingData settingData;

  AudioManager._internal();
  static final AudioManager _instance = AudioManager._internal();
  static AudioManager get instance => _instance;

  /// This method is responsible for initializing caching given list of [files],
  /// and initializing settings.
  Future<void> init(List<String> files, SettingData settingData) async {
    this.settingData = settingData;
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.loadAll(files);
  }

  // Starts the given audio file as BGM on loop.
  void startBgm(String fileName) {
    if (settingData.bgm) {
      FlameAudio.bgm.play(fileName, volume: 0.4);
    }
  }

  // Pauses currently playing BGM if any.
  void pauseBgm() {
    if (settingData.bgm) {
      FlameAudio.bgm.pause();
    }
  }

  // Resumes currently paused BGM if any.
  void resumeBgm() {
    if (settingData.bgm) {
      FlameAudio.bgm.resume();
    }
  }

  // Stops currently playing BGM if any.
  void stopBgm() {
    FlameAudio.bgm.stop();
  }

  // Plays the given audio file once.
  void playSfx(String fileName) {
    if (settingData.sfx) {
      FlameAudio.play(fileName);
    }
  }
}
