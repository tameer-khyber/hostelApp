import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'app/routes/app_pages.dart';
import 'app/data/services/property_service.dart';

import 'dart:ui';

void main() {
  Get.put(PropertyService());
  runApp(
    GetMaterialApp(
      title: "Hostel Management",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      themeMode: ThemeMode.light, // Default
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        primarySwatch: Colors.teal,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black87),
          bodyMedium: TextStyle(color: Colors.black87),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212), // Material Dark Standard
        primarySwatch: Colors.teal,
        canvasColor: const Color(0xFF1A1A1A), // For cards and sheets
        cardColor: const Color(0xFF1E1E1E), // Slightly lighter surface
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFEDEDED)), // Off-white
          bodyMedium: TextStyle(color: Color(0xFFB3B3B3)), // Light grey
          titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Color(0xFFEDEDED)),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        colorScheme: const ColorScheme.dark(
          primary: Colors.tealAccent, // Vibrant accent
          secondary: Colors.deepPurpleAccent,
          surface: Color(0xFF1E1E1E),
          background: Color(0xFF121212),
          onPrimary: Colors.black,
          onSurface: Color(0xFFEDEDED),
        ),
      ),
    ),
  );
}
