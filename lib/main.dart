// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import 'core/routes/app_routes.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return ScreenUtilInit(
//       designSize: Size(390, 852),
//       child: MaterialApp.router(
//         theme: ThemeData(scaffoldBackgroundColor: Color(0xffebf2f8)),
//         title: 'Chess Game',
//         debugShowCheckedModeBanner: false,
//         routeInformationParser: AppRoutes.goRouter.routeInformationParser,
//         routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
//         routerDelegate: AppRoutes.goRouter.routerDelegate,
//       ),
//     );
//   }
// }





import 'package:chess/pregentaition/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:squares/squares.dart' as squares;
import 'package:bishop/bishop.dart' as bishop;

import 'bloc/game/game_bloc.dart';
import 'bloc/game/game_state.dart';
import 'core/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 852),
      child: MaterialApp.router(
        title: 'Chess Game',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: Color(0xffebf2f8)),
        routeInformationParser: AppRoutes.goRouter.routeInformationParser,
        routeInformationProvider: AppRoutes.goRouter.routeInformationProvider,
        routerDelegate: AppRoutes.goRouter.routerDelegate,
      ),
    );
  }
}
