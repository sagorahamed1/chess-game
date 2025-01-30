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






import 'package:chess/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseService.setUpFirebase();
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


