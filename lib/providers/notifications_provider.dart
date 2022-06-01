import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationProvider extends ChangeNotifier{
  AppLifecycleState appState = AppLifecycleState.resumed; //saber el estado de la aplicacion
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();//Instancia general de las notificaciones
  NotificationDetails notificationDetails =  const NotificationDetails(
    android: AndroidNotificationDetails(
      'Channel ID', 
      'Channel Name',
      channelDescription: 'Channel description',
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
      subText: 'Background MEMBO',
      styleInformation: BigTextStyleInformation('')
    ),
  );



  void initialize() async{

    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: null,
      linux: null,
      macOS: null,
    );
    await flutterLocalNotificationsPlugin.initialize( //Inicializa el plugin de notificaciones
      initializationSettings,
      onSelectNotification: null,
    );



  }


}