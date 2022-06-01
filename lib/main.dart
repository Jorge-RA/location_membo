import 'package:flutter/material.dart';
import 'package:membo_test_app/providers/location_provider.dart';
import 'package:membo_test_app/screens/screens.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => LocationProvider()),
    ],
    child: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Membo location',
      initialRoute: 'home',
      routes: {
        'home':(context) => HomeScreen(),
      },
    );
  }
}