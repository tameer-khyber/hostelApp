import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SettingsController extends GetxController {
  final isDarkMode = false.obs;
  final notificationsEnabled = true.obs;

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    Get.changeThemeMode(value ? ThemeMode.dark : ThemeMode.light);
     Get.snackbar(
      "Theme Changed", 
      value ? "Dark Mode Enabled" : "Light Mode Enabled",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: value ? Colors.white : Colors.black87,
      colorText: value ? Colors.black : Colors.white,
      duration: const Duration(milliseconds: 1000),
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
    );
  }

  void toggleNotifications(bool value) {
    notificationsEnabled.value = value;
  }
  
  void logout() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to log out?",
      textConfirm: "Yes",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      onConfirm: () {
        Get.offAllNamed(Routes.LOGIN);
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
  }
}
