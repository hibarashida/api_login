import 'package:cabzing_driver_app_hiba/PROVIDER/Login_Provider.dart';
import 'package:cabzing_driver_app_hiba/PROVIDER/dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'PROVIDER/Main_Provider.dart';
import 'VIEW_SCREENS/Splash_Screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MainProvider(),),
        ChangeNotifierProvider(create: (context) => LoginProvider(),),
        ChangeNotifierProvider(create: (context) => SalesProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vikn codes',
        theme: ThemeData(


          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  SplashScreen(),
      ),
    );
  }
}
