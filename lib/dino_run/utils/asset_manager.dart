class ImageManager {
  static const String _assetPath = 'dino';
  static const String dinoDoux = '$_assetPath/player/dinoSprites/doux.png';
  static const String dinoMort = '$_assetPath/player/dinoSprites/mort.png';
  static const String dinoTard = '$_assetPath/player/dinoSprites/tard.png';
  static const String dinoVita = '$_assetPath/player/dinoSprites/vita.png';
  static const String dinoDouxGif =
      'assets/images/$_assetPath/player/dinoGif/doux.gif';
  static const String dinoMortGif =
      'assets/images/$_assetPath/player/dinoGif/mort.gif';
  static const String dinoTardGif =
      'assets/images/$_assetPath/player/dinoGif/tard.gif';
  static const String dinoVitaGif =
      'assets/images/$_assetPath/player/dinoGif/vita.gif';
  static const String parallax1 = '$_assetPath/parallax/plx-1.png';
  static const String parallax2 = '$_assetPath/parallax/plx-2.png';
  static const String parallax3 = '$_assetPath/parallax/plx-3.png';
  static const String parallax4 = '$_assetPath/parallax/plx-4.png';
  static const String parallax5 = '$_assetPath/parallax/plx-5.png';
  static const String parallax6 = '$_assetPath/parallax/plx-6.png';
  static const String enemyAngryPig = '$_assetPath/enemies/angryPig/walk.png';
  static const String enemyBat = '$_assetPath/enemies/bat/flying.png';
  static const String enemyRino = '$_assetPath/enemies/rino/run.png';
  static const String enemyVirtualGuy = '$_assetPath/enemies/vGuy/run.png';
  static const String enemyPinkMan = '$_assetPath/enemies/pMan/run.png';
  static const String enemyBird = '$_assetPath/enemies/bird/flying.png';
  static const String enemyChicken = '$_assetPath/enemies/chicken/run.png';
  static const String enemyGhost = '$_assetPath/enemies/ghost/run.png';
  static const String enemyRandish = '$_assetPath/enemies/randish/run.png';
  static const String enemySlime = '$_assetPath/enemies/slime/run.png';
  static const String enemySnail = '$_assetPath/enemies/snail/walk.png';
  static const String enemyBunny = '$_assetPath/enemies/bunny/run.png';
  static const String enemyTrunk = '$_assetPath/enemies/trunk/run.png';
  static const String enemyNinjaFrog = '$_assetPath/enemies/nFrog/run.png';
  static const String enemyMaskedDude = '$_assetPath/enemies/mDude/run.png';
}

class SoundManager {
  static const String _soundPath = 'dino';
  static const String audioHurt = '$_soundPath/hurt.wav';
  static const String audioJump = '$_soundPath/jump.wav';
  static const String audio8BitPlatform = '$_soundPath/8bitPlatform.wav';
}

const List<String> imageList = [
  ImageManager.dinoDoux,
  ImageManager.dinoMort,
  ImageManager.dinoTard,
  ImageManager.dinoVita,
  ImageManager.parallax1,
  ImageManager.parallax2,
  ImageManager.parallax3,
  ImageManager.parallax4,
  ImageManager.parallax5,
  ImageManager.parallax6,
  ImageManager.enemyAngryPig,
  ImageManager.enemyBat,
  ImageManager.enemyRino,
  ImageManager.enemyVirtualGuy,
  ImageManager.enemyPinkMan,
  ImageManager.enemyBird,
  ImageManager.enemyBunny,
  ImageManager.enemyChicken,
  ImageManager.enemyGhost,
  ImageManager.enemyRandish,
  ImageManager.enemySlime,
  ImageManager.enemySnail,
  ImageManager.enemyTrunk,
  ImageManager.enemyNinjaFrog,
  ImageManager.enemyMaskedDude,
];

const List<String> playerGifList = [
  ImageManager.dinoDouxGif,
  ImageManager.dinoMortGif,
  ImageManager.dinoTardGif,
  ImageManager.dinoVitaGif,
];

const List<String> playerImageList = [
  ImageManager.dinoDoux,
  ImageManager.dinoMort,
  ImageManager.dinoTard,
  ImageManager.dinoVita,
];

const List<String> audioList = [
  SoundManager.audioHurt,
  SoundManager.audioJump,
  SoundManager.audio8BitPlatform,
];
