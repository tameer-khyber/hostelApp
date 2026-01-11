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
  
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  void updatePassword() {
    if (newPasswordController.text != confirmNewPasswordController.text) {
      Get.snackbar("Error", "Passwords do not match", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    if (newPasswordController.text.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    // Simulate API call
    Get.defaultDialog(
      title: "Processing",
      content: const CircularProgressIndicator(),
      barrierDismissible: false,
    );
    Future.delayed(const Duration(seconds: 2), () {
      Get.back(); // Close dialog
      Get.back(); // Close screen
      Get.snackbar("Success", "Password updated successfully", backgroundColor: Colors.green, colorText: Colors.white);
      currentPasswordController.clear();
      newPasswordController.clear();
      confirmNewPasswordController.clear();
    });
  }

  void logout() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to log out?",
      textConfirm: "Yes",
      textCancel: "Cancel",
      confirmTextColor: Colors.white,
      buttonColor: Colors.teal,
      onConfirm: () {
        Get.offAllNamed(Routes.LOGIN);
      },
    );
  }

  @override
  void onClose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
  }
}
