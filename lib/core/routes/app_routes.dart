
import 'package:chess/pregentaition/screens/play_online/play_online_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/main.dart';

import '../../pregentaition/screens/home_screen/home_screen.dart';
import '../../pregentaition/screens/login/log_in_screen.dart';

class AppRoutes {
  ///===================routes Path===================>>>

  static const String splashScreen = "/splashScreen";
  static const String loginScreen = "/loginScreen";
  static const String homeScreen = "/HomeScreen";
  static const String playOnlineScreen = "/PlayOnlineScreen";


  static final GoRouter goRouter = GoRouter(
      initialLocation: homeScreen,
      routes: [

        // ///===================Splash Screen=================>>>
        // GoRoute(
        //   path: splashScreen,
        //   name: splashScreen,
        //   builder: (context, state) =>const SplashScreen(),
        //   redirect: (context, state) {
        //     Future.delayed(const Duration(seconds: 3), (){
        //       AppRoutes.goRouter.replaceNamed(AppRoutes.loginScreen);
        //     });
        //     return null;
        //   },
        // ),


        GoRoute(
          path: loginScreen,
          name: loginScreen,
          builder: (context, state) =>  LogInScreen(),
        ),


        GoRoute(
          path: homeScreen,
          name: homeScreen,
          builder: (context, state) => HomeScreen(),
        ),


        GoRoute(
          path: playOnlineScreen,
          name: playOnlineScreen,
          builder: (context, state) => PlayOnlineScreen(),
        ),


      ]
  );
}