import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_app/camera_ar/logic/ar_logic.dart';
import 'package:flutter_camera_app/global/logic/secret_controller.dart';
import 'package:flutter_camera_app/global/page/home_page.dart';
import 'package:flutter_camera_app/utils/function_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import 'spacescape/model.dart' as SpacescapeModel;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  await GlobalFunctionManager.initHive();
  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<SpacescapeModel.PlayerData>(
          create: (BuildContext context) =>
              GlobalFunctionManager.getSpacescapePlayerData(),
          initialData: SpacescapeModel.PlayerData.fromMap(
              SpacescapeModel.PlayerData.defaultData),
        ),
        FutureProvider<SpacescapeModel.Settings>(
          create: (BuildContext context) =>
              GlobalFunctionManager.getSpacescapeSettings(),
          initialData: SpacescapeModel.Settings(
              soundEffects: false, backgroundMusic: false),
        ),
        FutureProvider<SecretController>(
          create: (BuildContext context) =>
              GlobalFunctionManager.getSecretValue(),
          initialData: SecretController(isAnswer: false),
        ),
        ChangeNotifierProvider<DeepArLogic>(
          create: (context) => DeepArLogic(),
        ),
      ],
      builder: (context, child) {
        // We use .value constructor here because the required objects
        // are already created by upstream FutureProviders.
        return MultiProvider(
          providers: [
            ChangeNotifierProvider<SpacescapeModel.PlayerData>.value(
              value: Provider.of<SpacescapeModel.PlayerData>(context),
            ),
            ChangeNotifierProvider<SpacescapeModel.Settings>.value(
              value: Provider.of<SpacescapeModel.Settings>(context),
            ),
            ChangeNotifierProvider<SecretController>.value(
              value: Provider.of<SecretController>(context),
            ),
          ],
          child: child,
        );
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'E&C',
        home: AnimatedSplashScreen(
          splash: const SpinKitPianoWave(
            color: Colors.white70,
            size: 60,
            itemCount: 10,
          ),
          splashIconSize: double.infinity,
          backgroundColor: Colors.black,
          splashTransition: SplashTransition.scaleTransition,
          nextScreen: const HomePage(),
        ),
      ),
    );
  }
}
