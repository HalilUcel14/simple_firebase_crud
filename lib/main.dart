import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app_constants/app_route.dart';
import 'app_constants/app_theme.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // firebase için init
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.instance.themes, // themeleri tek yerden yönetmem için
      initialRoute: AppRoute.initialRoute, 
      routes: AppRoute.appRoutes,
    );
  }
}
