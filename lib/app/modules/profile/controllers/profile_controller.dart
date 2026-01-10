import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ProfileController extends GetxController {
  final name = "Tameer Fullstack".obs;
  final email = "tameer@example.com".obs;
  final phone = "+1 234 567 8900".obs;
  
  void editProfile() {
    Get.snackbar('Coming Soon', 'Edit Profile feature');
  }

  void changePassword() {
    // Navigate to Reset Password or a dedicated Change Password screen
    // For now reusing the Reset Password route as it fits the user request
    Get.toNamed(Routes.RESET_PASSWORD);
  }

  void logout() {
    Get.defaultDialog(
      title: "Logout",
      middleText: "Are you sure you want to logout?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back(); // Close dialog
        Get.offAllNamed(Routes.LOGIN);
      },
    );
  }
}
