import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/controllers/nav_controllers.dart';

void main() {
  Get.put(NavController()); // Use NavController instead
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'NomNom',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialRoute: Routes.SPLASH,
      getPages: AppPages.routes,
    );
  }
}