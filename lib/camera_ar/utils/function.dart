import 'dart:convert';

import 'package:flutter/material.dart';

import 'deepAR_asset_constants.dart';

class DeepArFunction {
  static const String _assetEffectsPath = 'assets/effects/';

  static List<String> initEffect() {
    final List<String> effectList = [];
    effectList.add(DeepArEffectConstant.burningEffect);
    effectList.add(DeepArEffectConstant.elephantTrunkEffect);
    effectList.add(DeepArEffectConstant.neonDevilHornsEffect);
    effectList.add(DeepArEffectConstant.emotionMeterEffect);
    effectList.add(DeepArEffectConstant.emotionsExaggeratorEffect);
    effectList.add(DeepArEffectConstant.fireEffect);
    effectList.add(DeepArEffectConstant.flowerFaceEffect);
    effectList.add(DeepArEffectConstant.galaxyBackgroundEffect);
    effectList.add(DeepArEffectConstant.hopeEffect);
    effectList.add(DeepArEffectConstant.humanoidEffect);
    effectList.add(DeepArEffectConstant.makeUpLookEffect);
    effectList.add(DeepArEffectConstant.splitViewLookEffect);
    effectList.add(DeepArEffectConstant.heart8BitEffect);
    effectList.add(DeepArEffectConstant.pingPongEffect);
    effectList.add(DeepArEffectConstant.snailEffect);
    effectList.add(DeepArEffectConstant.stalloneEffect);
    effectList.add(DeepArEffectConstant.vendettaMaskEffect);
    effectList.add(DeepArEffectConstant.vikingHelmetEffect);
    return effectList;
  }

  static Future<List<String>> getEffectsFromAssets(BuildContext context) async {
    final manifestContent =
        await DefaultAssetBundle.of(context).loadString('AssetManifest.json');
    final Map<String, dynamic> manifestMap = json.decode(manifestContent);
    final filePaths = manifestMap.keys
        .where((path) => path.startsWith(_assetEffectsPath))
        .toList();
    return filePaths;
  }
}
