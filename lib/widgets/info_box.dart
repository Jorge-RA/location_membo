import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoBox extends StatelessWidget {
  final String text;
  final String value;
  InfoBox({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);

  final TextStyle _style = GoogleFonts.russoOne(
    fontSize: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 241, 210, 247),
              blurRadius: 10,
              offset: Offset(0, 5)
            ),
          ]),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: _style),
            const SizedBox(height: 20),
            Text(
              value,
              style: _style,
            ),
          ],
        ),
      ),
    );
  }
}
