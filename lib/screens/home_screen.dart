import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:membo_test_app/widgets/widgets.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
    body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'MEMBO',
              style: GoogleFonts.rajdhani(
                fontSize: 60,
                fontWeight: FontWeight.w800,
                color: const Color.fromARGB(255, 255, 30, 14),
              ),
            ),
            const GridViewStream(),
            const CustomSlider(),
            Text('Desing by Jorge Ramos',
              style: GoogleFonts.rajdhani(
                  fontSize: 10,
                  color: Colors.white,
                ),
            ),
          ],
         ),
    );
  }
}


