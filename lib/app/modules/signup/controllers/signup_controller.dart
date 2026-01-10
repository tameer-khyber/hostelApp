import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  
  final isPasswordVisible = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void signup() async {
    if (nameController.text.isEmpty || 
        emailController.text.isEmpty || 
        phoneController.text.isEmpty || 
        passwordController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields', 
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Simulate API
    isLoading.value = false;
    
    // For now, go to Home or OTP (Next Step)
    // As per flow, maybe go to Login or Home? Let's go to Home for now or remain here.
    // User asked for "OTP Verification" next. So logic will be updated later.
    Get.snackbar('Success', 'Account Created',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
  
  void goToLogin() {
    Get.back(); // Go back to Login
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
