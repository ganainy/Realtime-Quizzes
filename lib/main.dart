import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:realtime_quizzes/models/user.dart';
import 'package:realtime_quizzes/screens/login/login.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:realtime_quizzes/shared/constants.dart';
import 'package:realtime_quizzes/shared/shared.dart';

import 'customization/theme.dart';
import 'firebase_options.dart';
import 'layouts/home/home.dart';
import 'main_controller.dart';
import 'network/dio_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await dotenv.load(fileName: ".env");
    await DioHelper.init();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    Get.put(MainController());
  } catch (e) {
    debugPrint('Initialization error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  MainController? mainController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    try {
      mainController = Get.find<MainController>();
    } catch (e) {
      debugPrint('MainController not found: $e');
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (mainController == null) return;

    if (state == AppLifecycleState.resumed) {
      mainController!.changeUserStatus(true);
      debugPrint('user online ');
    } else {
      debugPrint('user offline  ${state.toString()}');
      mainController!.changeUserStatus(false);
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
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Show loading while checking auth state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Loading...',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            );
          }

          // Handle errors
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error_outline,
                        size: 48, color: Colors.red),
                    const SizedBox(height: 16),
                    Text('Error: ${snapshot.error}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
            );
          }

          // User is logged in
          if (snapshot.hasData && snapshot.data != null) {
            Shared.loggedUser = UserModel(email: snapshot.data!.email);
            Future.delayed(Duration.zero, () {
              mainController?.changeUserStatus(true);
            });
            return HomeScreen();
          }

          // User is not logged in
          return LoginScreen();
        },
      ),
    );
  }
}
