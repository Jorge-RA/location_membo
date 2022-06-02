import 'package:shared_preferences/shared_preferences.dart';

class Preferences{
  static late SharedPreferences _prefs;

  static Future initPrefers() async{
    _prefs = await SharedPreferences.getInstance();
  }

  static void setLatestData(Map<String, double?> dataLocation){
    _prefs.setDouble('latitude', dataLocation['latitude'] ?? 0.0);
    _prefs.setDouble('longitude', dataLocation['longitude'] ?? 0.0);
    _prefs.setDouble('speed', dataLocation['speed'] ?? 0.0);
  }

  static Map<String, double> getLatestData(){
    final Map<String, double> dataLocation = {
      'latitude' : 0.0,
      'longitude' : 0.0,
      'speed' : 0.0,
    };

    dataLocation['latitude'] = _prefs.getDouble('latitude') ?? 0.0;
    dataLocation['longitude'] = _prefs.getDouble('longitude') ?? 0.0;
    dataLocation['speed'] = _prefs.getDouble('speed') ?? 0.0;

    return dataLocation;
  }



}