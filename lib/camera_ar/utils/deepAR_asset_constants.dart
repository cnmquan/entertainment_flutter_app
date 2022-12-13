import 'package:flutter_camera_app/camera_ar/model/ar_filter_model.dart';

class DeepArEffectConstant {
  /// Asset Effect Path
  static const String _assetEffectsPath = 'assets/effects/ar';

  static const String burningEffect =
      '$_assetEffectsPath/burning_effect.deepar';
  static const String elephantTrunkEffect =
      '$_assetEffectsPath/Elephant_Trunk.deepar';
  static const String neonDevilHornsEffect =
      '$_assetEffectsPath/Neon_Devil_Horns.deepar';
  static const String emotionMeterEffect =
      '$_assetEffectsPath/Emotion_Meter.deepar';
  static const String emotionsExaggeratorEffect =
      '$_assetEffectsPath/Emotions_Exaggerator.deepar';
  static const String fireEffect = '$_assetEffectsPath/Fire_Effect.deepar';
  static const String flowerFaceEffect =
      '$_assetEffectsPath/flower_face.deepar';
  static const String galaxyBackgroundEffect =
      '$_assetEffectsPath/galaxy_background.deepar';
  static const String hopeEffect = '$_assetEffectsPath/Hope.deepar';
  static const String humanoidEffect = '$_assetEffectsPath/Humanoid.deepar';
  static const String makeUpLookEffect = '$_assetEffectsPath/MakeupLook.deepar';
  static const String splitViewLookEffect =
      '$_assetEffectsPath/Split_View_Look.deepar';
  static const String heart8BitEffect = '$_assetEffectsPath/8bitHearts.deepar';
  static const String pingPongEffect = '$_assetEffectsPath/Ping_Pong.deepar';
  static const String snailEffect = '$_assetEffectsPath/Snail.deepar';
  static const String stalloneEffect = '$_assetEffectsPath/Stallone.deepar';
  static const String vendettaMaskEffect =
      '$_assetEffectsPath/Vendetta_Mask.deepar';
  static const String vikingHelmetEffect =
      '$_assetEffectsPath/viking_helmet.deepar';
}

class DeepArImageConstant {
  /// Asset Image Path
  static const String _assetImagesPath = 'assets/images/ar';

  static const String burningImage = '$_assetImagesPath/burning_effect.png';
  static const String elephantTrunkImage =
      '$_assetImagesPath/Elephant_Trunk.png';
  static const String neonDevilHornsImage =
      '$_assetImagesPath/Neon_Devil_Horns.png';
  static const String emotionMeterImage = '$_assetImagesPath/Emotion_Meter.png';
  static const String emotionsExaggeratorImage =
      '$_assetImagesPath/Emotions_Exaggerator.png';
  static const String fireImage = '$_assetImagesPath/Fire_Effect.png';
  static const String flowerFaceImage = '$_assetImagesPath/flower_face.png';
  static const String galaxyBackgroundImage =
      '$_assetImagesPath/galaxy_background.png';
  static const String hopeImage = '$_assetImagesPath/Hope.png';
  static const String humanoidImage = '$_assetImagesPath/Humanoid.png';
  static const String makeUpLookImage = '$_assetImagesPath/MakeupLook.png';
  static const String splitViewLookImage =
      '$_assetImagesPath/Split_View_Look.png';
  static const String heart8BitImage = '$_assetImagesPath/8bitHearts.png';
  static const String pingPongImage = '$_assetImagesPath/Ping_Pong.png';
  static const String snailImage = '$_assetImagesPath/Snail.png';
  static const String stalloneImage = '$_assetImagesPath/Stallone.png';
  static const String vendettaMaskImage = '$_assetImagesPath/Vendetta_Mask.png';
  static const String vikingHelmetImage = '$_assetImagesPath/viking_helmet.png';
}

class DeepArNameConstant {
  static const String burningName = 'Burning Effect';
  static const String elephantTrunkName = 'Elephant Trunk';
  static const String neonDevilHornsName = 'Devil Horns';
  static const String emotionMeterName = 'Emotion Meter';
  static const String emotionsExaggeratorName = 'Exaggerator';
  static const String fireName = 'Fire Effect';
  static const String flowerFaceName = 'Flower Face';
  static const String galaxyBackgroundName = 'Galaxy';
  static const String hopeName = 'Hope';
  static const String humanoidName = 'Humanoid';
  static const String makeUpLookName = 'Makeup Look';
  static const String splitViewLookName = 'Split View';
  static const String heart8BitName = 'Heart 8Bit';
  static const String pingPongName = 'Ping Pong';
  static const String snailName = 'Snail';
  static const String stalloneName = 'Stallone';
  static const String vendettaMaskName = 'Vendetta Mask';
  static const String vikingHelmetName = 'Viking Helmet';
}

class ArFilterConstant {
  static const ArModel vikingHelmetFilter = ArModel(
    name: DeepArNameConstant.vikingHelmetName,
    id: 0,
    fileAr: DeepArEffectConstant.vikingHelmetEffect,
    assetName: DeepArImageConstant.vikingHelmetImage,
  );

  static const ArModel burningEffectFilter = ArModel(
    name: DeepArNameConstant.burningName,
    id: 1,
    fileAr: DeepArEffectConstant.burningEffect,
    assetName: DeepArImageConstant.burningImage,
  );

  static const ArModel elephantTrunkFilter = ArModel(
    name: DeepArNameConstant.elephantTrunkName,
    id: 2,
    fileAr: DeepArEffectConstant.elephantTrunkEffect,
    assetName: DeepArImageConstant.elephantTrunkImage,
  );

  static const ArModel neonDevilHornsFilter = ArModel(
    name: DeepArNameConstant.neonDevilHornsName,
    id: 3,
    fileAr: DeepArEffectConstant.neonDevilHornsEffect,
    assetName: DeepArImageConstant.neonDevilHornsImage,
  );

  static const ArModel emotionMeterFilter = ArModel(
    name: DeepArNameConstant.emotionMeterName,
    id: 4,
    fileAr: DeepArEffectConstant.emotionMeterEffect,
    assetName: DeepArImageConstant.emotionMeterImage,
  );

  static const ArModel emotionsExaggeratorFilter = ArModel(
    name: DeepArNameConstant.emotionsExaggeratorName,
    id: 5,
    fileAr: DeepArEffectConstant.emotionsExaggeratorEffect,
    assetName: DeepArImageConstant.emotionsExaggeratorImage,
  );

  static const ArModel fireFilter = ArModel(
    name: DeepArNameConstant.fireName,
    id: 6,
    fileAr: DeepArEffectConstant.fireEffect,
    assetName: DeepArImageConstant.fireImage,
  );

  static const ArModel flowerFaceFilter = ArModel(
    name: DeepArNameConstant.flowerFaceName,
    id: 7,
    fileAr: DeepArEffectConstant.flowerFaceEffect,
    assetName: DeepArImageConstant.flowerFaceImage,
  );

  static const ArModel galaxyBackgroundFilter = ArModel(
    name: DeepArNameConstant.galaxyBackgroundName,
    id: 8,
    fileAr: DeepArEffectConstant.galaxyBackgroundEffect,
    assetName: DeepArImageConstant.galaxyBackgroundImage,
  );

  static const ArModel hopeFilter = ArModel(
    name: DeepArNameConstant.hopeName,
    id: 9,
    fileAr: DeepArEffectConstant.hopeEffect,
    assetName: DeepArImageConstant.hopeImage,
  );

  static const ArModel humanoidFilter = ArModel(
    name: DeepArNameConstant.humanoidName,
    id: 10,
    fileAr: DeepArEffectConstant.humanoidEffect,
    assetName: DeepArImageConstant.humanoidImage,
  );

  static const ArModel makeUpLookFilter = ArModel(
    name: DeepArNameConstant.makeUpLookName,
    id: 11,
    fileAr: DeepArEffectConstant.makeUpLookEffect,
    assetName: DeepArImageConstant.makeUpLookImage,
  );

  static const ArModel splitViewLookFilter = ArModel(
    name: DeepArNameConstant.splitViewLookName,
    id: 12,
    fileAr: DeepArEffectConstant.splitViewLookEffect,
    assetName: DeepArImageConstant.splitViewLookImage,
  );

  static const ArModel heart8BitFilter = ArModel(
    name: DeepArNameConstant.heart8BitName,
    id: 13,
    fileAr: DeepArEffectConstant.heart8BitEffect,
    assetName: DeepArImageConstant.heart8BitImage,
  );

  static const ArModel pingPongFilter = ArModel(
    name: DeepArNameConstant.pingPongName,
    id: 14,
    fileAr: DeepArEffectConstant.pingPongEffect,
    assetName: DeepArImageConstant.pingPongImage,
  );

  static const ArModel snailFilter = ArModel(
    name: DeepArNameConstant.snailName,
    id: 15,
    fileAr: DeepArEffectConstant.snailEffect,
    assetName: DeepArImageConstant.snailImage,
  );

  static const ArModel stalloneFilter = ArModel(
    name: DeepArNameConstant.stalloneName,
    id: 16,
    fileAr: DeepArEffectConstant.stalloneEffect,
    assetName: DeepArImageConstant.stalloneImage,
  );

  static const ArModel vendettaMaskFilter = ArModel(
    name: DeepArNameConstant.vendettaMaskName,
    id: 17,
    fileAr: DeepArEffectConstant.vendettaMaskEffect,
    assetName: DeepArImageConstant.vendettaMaskImage,
  );
}

List<ArModel> arFilterList = [
  ArFilterConstant.vikingHelmetFilter,
  ArFilterConstant.burningEffectFilter,
  ArFilterConstant.elephantTrunkFilter,
  ArFilterConstant.neonDevilHornsFilter,
  ArFilterConstant.emotionMeterFilter,
  ArFilterConstant.emotionsExaggeratorFilter,
  ArFilterConstant.fireFilter,
  ArFilterConstant.flowerFaceFilter,
  ArFilterConstant.galaxyBackgroundFilter,
  ArFilterConstant.hopeFilter,
  ArFilterConstant.humanoidFilter,
  ArFilterConstant.makeUpLookFilter,
  ArFilterConstant.splitViewLookFilter,
  ArFilterConstant.heart8BitFilter,
  ArFilterConstant.pingPongFilter,
  ArFilterConstant.snailFilter,
  ArFilterConstant.stalloneFilter,
  ArFilterConstant.vendettaMaskFilter,
];
