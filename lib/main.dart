import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_quizzes/screens/register/register.dart';
import 'package:realtime_quizzes/shared/constants.dart';
import 'package:realtime_quizzes/shared/shared.dart';

import 'customization/theme.dart';
import 'firebase_options.dart';
import 'layouts/home/home.dart';
import 'main_controller.dart';
import 'network/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Get.put(MainController());
  late Widget startWidget;

  //navigate to games or register based on auth state
  if (auth.currentUser != null) {
    startWidget = HomeScreen();
  } else {
    startWidget = RegisterScreen();
  }

  runApp(MyApp(startWidget));
}

class MyApp extends StatefulWidget {
  final Widget startWidget;

  const MyApp(this.startWidget, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final MainController mainController = Get.find<MainController>();
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      mainController.changeUserStatus(true);
      debugPrint('user online ');
    } else {
      debugPrint('user offline  ${state.toString()}');
      mainController.changeUserStatus(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz',
      locale: const Locale('en', 'US'),
      translationsKeys: Constants.translation,
      theme: MyTheme.lighTheme,
      home: widget.startWidget,
    );
  }
}
