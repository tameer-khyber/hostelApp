import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/data/services/property_service.dart';
import 'app/modules/settings/controllers/settings_controller.dart';
import 'app/config/theme/app_theme.dart';

void main() {
  Get.put(SettingsController(), permanent: true);
  Get.put(PropertyService());
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsController = Get.find<SettingsController>();
    
    return Obx(() => GetMaterialApp(
      title: "Hostel Management",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      
      // Theme Configuration
      themeMode: settingsController.isDarkMode.value 
          ? ThemeMode.dark 
          : ThemeMode.light,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
    ));
  }
}
