import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera_app/global/page/home_page.dart';
import 'package:flutter_camera_app/utils/function_manager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E&C',
      home: AnimatedSplashScreen(
        splash: const Icon(
          Icons.home,
          color: Colors.white,
        ),
        splashIconSize: double.infinity,
        backgroundColor: Colors.black,
        splashTransition: SplashTransition.scaleTransition,
        nextScreen: const HomePage(),
      ),
    );
  }
}
