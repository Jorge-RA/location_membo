import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier{

  Location location = Location();
  bool _serviceEnabled = false;
  late PermissionStatus _currentPermissionLocation;
  late LocationData _locationData;
  double? latitude = 0.0;
  double? longitude = 0.0;
  double? speed = 0.0;
  bool _enableService = false;
  int _reportFrecuency = 10; //Inicialmente es un reporte cada 10milisegundos

  int get reportFrecuency => _reportFrecuency;

  set reportFrecuency(int reportFrecuency) {
    _reportFrecuency = reportFrecuency;
    print('Setting frecuency $_reportFrecuency');
    //Seteo la frecuencia de los reportes dependiendo al valor del Slider
    location.changeSettings(
      interval: _reportFrecuency, //Enviar datos al Stream cada x milisegs
      distanceFilter: 0, //Cero metros
    );
  }

  bool get enableService => _enableService;

  set enableService(bool enableService) {
    _enableService = enableService;
    // ignore: unnecessary_this
    location.enableBackgroundMode(enable: enableService); //Si los servicios están iniciados, que también se inicie el BackgroundMode
    notifyListeners(); //Se le notifica y se le envía al StreamBuilder el Stream para que escuche los datos
  }

  Future<bool> checkStatusService() async{

    _serviceEnabled = await location.serviceEnabled(); //Saber el estado del GPS ON/OFF
    print('Service Enable: ${_serviceEnabled}');   
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();//Para habilitar el GPS del dispositivo
    print('Service Enable2: ${_serviceEnabled}');   
      if (!_serviceEnabled) {
        print('No se habilitó el servicio GPS');
      return false;
      }
        print('Se habilitó el servicio GPS');
    }

    _currentPermissionLocation = await location.hasPermission(); //Para saber el estado actual de los permisos de la app para acceder a tu ubicacion
    print('CurrentPermission: ${_currentPermissionLocation}');  
    if(_currentPermissionLocation == PermissionStatus.denied){
        _currentPermissionLocation = await location.requestPermission();// PEDIR permisos para que la app para acceda a tu ubicacion
      print('CurrentPermission2: ${_currentPermissionLocation}');  
      if(_currentPermissionLocation != PermissionStatus.granted){
          print('No se otorgaron los permisos');
          return false;
      }
      print('Todos los permisos fueron otorgados');
      return true;
    }
    return true;


  }
  
  Future getLocation() async{
    _locationData = await location.getLocation();
    latitude = _locationData.latitude;
    longitude = _locationData.longitude;
    speed = _locationData.speed;
    //notifyListeners();
  }


}