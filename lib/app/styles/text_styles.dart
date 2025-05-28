import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static final headingLarge = GoogleFonts.poppins(
    fontSize: 34,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final headingMedium = GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static final subtitle = GoogleFonts.poppins(
    fontSize: 22,
    fontWeight: FontWeight.w500,
    color: const Color(0xFF2C3E50),
  );

  static final body = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: const Color(0xFF2C3E50),
  );

  static final button = GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
