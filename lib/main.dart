import 'package:flutter/material.dart';
import 'package:membo_test_app/providers/preferences.dart';
import 'package:membo_test_app/providers/providers.dart';
import 'package:membo_test_app/screens/screens.dart';
import 'package:provider/provider.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initPrefers();//Inicializo la instancia de mi SharedPreferences
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (context) => LocationProvider()),
      ChangeNotifierProvider(create: (context) => NotificationProvider()),
    ],
    child: const MyApp(),
    );
  }
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Membo location',
      initialRoute: 'home',
      routes: {
        'home':(context) => const HomeScreen(),
      },
    );
  }
}