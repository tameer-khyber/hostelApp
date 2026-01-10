import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading = false.obs;

  void sendResetLink() async {
    if (emailController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter your email', 
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Simulate API
    isLoading.value = false;
    
    // Logic: Navigate to OTP or Show Confirmation
    // User requested "OTP Verification" next, so we will likely navigate there next.
    Get.snackbar('Success', 'Reset link sent to your email',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
     // Note: API for OTP flow to be added later
     Get.toNamed(Routes.OTP);
  }
  
  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
