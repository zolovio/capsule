import 'package:capsule_new/src/features/home/exam_history/exam_binding.dart';
import 'package:capsule_new/src/features/home/homescreen/home_binding.dart';
import 'package:capsule_new/src/features/home/mcq_topics/mcq_topics_binding.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'src/core/configs/routes.dart';
import 'src/core/constants/palette.dart';
import 'src/features/auth/login/login_binding.dart';

late SharedPreferences preferences;
late bool firstLogin;

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  //
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // ).then((value) => Get.put(AuthRepository()));
  //
  // preferences = await SharedPreferences.getInstance();
  //
  // bool? firstLog = preferences.getBool("firstLogin");
  //
  // if (firstLog != null) {
  //   firstLogin = firstLog;
  // } else {
  //   firstLogin = true;
  // }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          theme: ThemeData(
            fontFamily: 'OpenSans',
            primarySwatch: Colors.pink,
            colorScheme: const ColorScheme.light(
              primary: AppColors.pinkGrade2,
            ),
            scaffoldBackgroundColor: AppColors.white,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.white,
              elevation: 0,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              elevation: 3,
              backgroundColor: AppColors.white,
            ),
          ),
          debugShowCheckedModeBanner: false,
          smartManagement: SmartManagement.full,
          initialRoute: AppRoutes.getHomeScreenRoute(),
          // !firstLogin ? AppRoutes.getLoginRoute() : AppRoutes.getIntroRoute(),
          initialBinding: HomeBinding(),
          // !firstLogin ? LoginBinding() : IntroBinding(),
          getPages: AppRoutes.getPages(),
          onGenerateRoute: (settings) => AppRoutes.generateRoute(settings),
        );
      },
    );
  }
}
