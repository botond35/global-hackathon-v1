import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_bro/pages/start_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GYM BRO',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.oswaldTextTheme(),
        colorScheme: const ColorScheme.light(
          primary: Colors.white,
          secondary: Colors.black,
          surface: Colors.white,
          onPrimary: Colors.black,
          onSecondary: Colors.white,
          onSurface: Colors.black,
        ),
      ),
      home: StartPage(),
    );
  }
}
