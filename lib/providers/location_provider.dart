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
  var listernerStream;

  int get reportFrecuency => _reportFrecuency;

  set reportFrecuency(int reportFrecuency) {
    _reportFrecuency = reportFrecuency;
    //Seteo la frecuencia de los reportes dependiendo al valor del Slider
    location.changeSettings(
      interval: _reportFrecuency, //Enviar datos al Stream cada x milisegs
      distanceFilter: 0, //Cero metros
    );
  }

  bool get enableService => _enableService;

  set enableService(bool enableService) {
    _enableService = enableService;
     notifyListeners(); //Se le notifica y se le envía al StreamBuilder el Stream para que escuche los datos

    location.enableBackgroundMode(enable: enableService); //Si los servicios están iniciados, que también se inicie el BackgroundMode
    if(_enableService){
        listernerStream = location.onLocationChanged.listen(
          (event) {
            print(event);//Permitirá ver por medio de sockects la localizacion y velocidad reportada por la app
          }
        );
    }else{
      listernerStream.cancel(); //Cancelo el listener cuando se apaguen los servicios
    }
   
  }

  Future<bool> checkStatusService() async{
    _serviceEnabled = await location.serviceEnabled(); //Saber el estado del GPS ON/OFF
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();//Para habilitar el GPS del dispositivo 
      if (!_serviceEnabled) {
        //No se habilitó el servicio GPS
        return false;
      }
        //Se habilitó el servicio GPS'
    }

    _currentPermissionLocation = await location.hasPermission(); //Para saber el estado actual de los permisos de la app para acceder a tu ubicacion
    if(_currentPermissionLocation == PermissionStatus.denied){
        _currentPermissionLocation = await location.requestPermission();// PEDIR permisos para que la app para acceda a tu ubicacion
      if(_currentPermissionLocation != PermissionStatus.granted){
          //No se otorgaron los permisos
          return false;
      }
      //Todos los permisos fueron otorgados
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