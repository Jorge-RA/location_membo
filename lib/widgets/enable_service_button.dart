import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:membo_test_app/providers/location_provider.dart';
import 'package:provider/provider.dart';

class EnableServiceButton extends StatefulWidget {
  const EnableServiceButton({Key? key}) : super(key: key);

  @override
  State<EnableServiceButton> createState() => _EnableServiceButtonState();
}

class _EnableServiceButtonState extends State<EnableServiceButton> {
  Color buttonColor = Colors.green;
  String textButton = 'Iniciar servicios';
  bool enable = false;

  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(enable ? Colors.red : Colors.green),
      ),
      child: Text(
        enable ? 'Apagar servicios' : 'Iniciar servicios',
        style: GoogleFonts.russoOne(
          letterSpacing: 1,
        ),
      ),
      onPressed: () async {
        if (await locationProvider.checkStatusService()) {
          enable = !enable;
          locationProvider.enableService = enable;
          setState(() {});
        }
      },
    );
  }
}
