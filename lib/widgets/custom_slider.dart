import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:membo_test_app/providers/location_provider.dart';
import 'package:provider/provider.dart';

class CustomSlider extends StatefulWidget {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 10;
  @override
  Widget build(BuildContext context) {
    final _locationProvider = Provider.of<LocationProvider>(context, listen: false);
    return Column(
      children: [
        Text(
          'Frecuencia del reporte:   ${_value.toInt()} milisegundos',
          style: GoogleFonts.rajdhani(
            fontSize: 10,
            color: Colors.white,
          ),
        ),
        Slider(
          min: 0,
          max: 10000,
          value: _value, //Se pinta mejor
          divisions: 1000,
          label: '${_value.floor()} milisegundos',
          activeColor: Colors.white,
          inactiveColor: const Color.fromARGB(255, 155, 94, 89),
          onChanged: (value) {
            if(value < 10) value = 10;
            print(value);
            _value = value;
            setState(() {});
          },
          onChangeEnd: (value)async{
            _locationProvider.reportFrecuency = _value.toInt();
            
          },
          

          
        ),
      ],
    );
  }
}
