import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';
import 'package:membo_test_app/providers/location_provider.dart';
import 'package:membo_test_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class GridViewStream extends StatefulWidget {
   const GridViewStream({
    Key? key,
  }) : super(key: key);

  @override
  State<GridViewStream> createState() => _GridViewStreamState();
}

class _GridViewStreamState extends State<GridViewStream> with WidgetsBindingObserver{
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);//Agregamos esto para escuchar el estado de la aplicacion
  }
  
  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);//Debemos remover el Observer cuando se destuya el widget
  }


  @override
  void didChangeDependencies() async{
    super.didChangeDependencies();
    const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: null,
      linux: null,
      macOS: null,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: null,
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if(state == AppLifecycleState.paused){ //Si la aplicacion está en segundo plano, envíe la notificación
      final locationProvider = Provider.of<LocationProvider>(context, listen: false);
      flutterLocalNotificationsPlugin.show(
        0, 
        'ÚLTIMOS DATOS EN PRIMER PLANO', 
        '''Latitud: ${locationProvider.latitude!.toStringAsFixed(7)}°\nLongitud: ${locationProvider.longitude!.toStringAsFixed(7)}°\nVelocidad: ${locationProvider.speed!.toStringAsFixed(4)} Km/h''', 
        notificationDetails,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context);

    return StreamBuilder<LocationData>(
      stream: locationProvider.enableService ? locationProvider.location.onLocationChanged : null,
      builder: (context, snapshot) {
        if (snapshot.hasData || snapshot.data == null) {//Siempre entrará
          if(snapshot.hasData) locationProvider.getLocation(); //Traigo la nueva ubicacion siempre que el listen del Stream envíe un nuevo dato, esos datos los centralizo en mi Provider
          List<Widget> myObjects = [
            InfoBox(text: 'Latitud',value:'${locationProvider.latitude!.toStringAsFixed(7)}°'), //despues de haber seteado los nuevos datos, traigo los datos desde mi Provider
            InfoBox(text: 'Longitud',value: '${locationProvider.longitude!.toStringAsFixed(7)}°'),
            InfoBox(text: 'Velocidad',value: '${locationProvider.speed!.toStringAsFixed(4)} Km/h'),
            const EnableServiceButton(),
            const SizedBox(),
            ];
          return GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: myObjects.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (_, index) {
              return myObjects[index];//Renderiza los objetos de la lista con los nuevos valores
            },
          );
        }
        else{
          return const Center(child: CircularProgressIndicator(color: Colors.white));
        }
      }
    );
  }
}