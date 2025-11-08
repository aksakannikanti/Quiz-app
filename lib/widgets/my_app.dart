import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/configs/app_colors.dart';
import 'package:quiz/widgets/home_screen/home_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // FIX: Added const constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: AppColors.darkSlateGray,
          secondary: AppColors.dodgerBlue,
          surface: AppColors.darkSlateGray, // FIX: background → surface
        ),
        scaffoldBackgroundColor: AppColors.darkSlateGray,
        textTheme: GoogleFonts.oxygenTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
      ),
      home: const Scaffold( // FIX: Added const
        body: SafeArea(
          child: HomeScreen(), // FIX: Added const
        ),
      ),
    );
  }
}