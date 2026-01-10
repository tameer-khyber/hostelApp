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
      theme: ThemeData(
        // textTheme: GoogleFonts.interTextTheme(),
        primarySwatch: Colors.orange,
      ),
    ),
  );
}
