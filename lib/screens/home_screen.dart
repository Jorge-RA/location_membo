import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:location/location.dart';
import 'package:membo_test_app/providers/location_provider.dart';
import 'package:membo_test_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _locationProvider = Provider.of<LocationProvider>(context);

    return Scaffold(
      backgroundColor: Colors.black,
      //Tiempo: Luego de 10 milisegundos se reportan los datos
      body: StreamBuilder<LocationData>(
        stream: _locationProvider.enableService 
            ? _locationProvider.location.onLocationChanged
            : null,
        builder: (context, snapshot) {
          print('SNAPSHOT: ${snapshot.data}');
          if (snapshot.hasData || snapshot.data == null) {//Siempre entrará
            _locationProvider.getLocation(); //Traigo la nueva ubicacion siempre que el listen del Stream envíe un nuevo dato, esos datos los centralizo en mi Provider
            List<Widget> myObjects = [
              InfoBox(text: 'Latitud',value:'${_locationProvider.latitude!.toStringAsFixed(7)}°'), //despues de haber seteado los nuevos datos, traigo los datos desde mi Provider
              InfoBox(text: 'Longitud',value: '${_locationProvider.longitude!.toStringAsFixed(7)}°'),
              InfoBox(text: 'Velocidad',value: '${_locationProvider.speed!.toStringAsFixed(4)} Km/h'),
              const EnableServiceButton(),
              const SizedBox(),
            ];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'MEMBO',
                  style: GoogleFonts.rajdhani(
                    fontSize: 60,
                    fontWeight: FontWeight.w800,
                    color: Color.fromARGB(255, 255, 30, 14),
                  ),
                ),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: myObjects.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (_, index) {
                    return myObjects[index];
                  },
                ),
                const CustomSlider(),
                Text('Desing by Jorge Ramos',
                  style: GoogleFonts.rajdhani(
                    fontSize: 10,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          } else {
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          }
        },
      ),
    );
  }
}
