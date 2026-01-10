import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class OtpController extends GetxController {
  // We'll use a single controller for simplicity or focus nodes for individual fields?
  // Let's use 4 separate controllers for a nice UI experience without extra deps
  final List<TextEditingController> otpControllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  
  final isLoading = false.obs;
  final timerText = "00:30".obs;
  final isResendEnabled = false.obs;
  Timer? _timer;
  int _start = 30;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    isResendEnabled.value = false;
    _start = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        isResendEnabled.value = true;
        timer.cancel();
      } else {
        _start--;
        int minutes = _start ~/ 60;
        int seconds = _start % 60;
        timerText.value = "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
      }
    });
  }

  void verifyOtp() async {
    String otp = otpControllers.map((e) => e.text).join();
    if (otp.length < 4) {
      Get.snackbar('Error', 'Please enter a valid 4-digit code', 
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
      return;
    }

    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2)); // Simulate API
    isLoading.value = false;
    
    // Navigate to Reset Password
    Get.toNamed(Routes.RESET_PASSWORD);
  }

  void resendCode() {
    if (isResendEnabled.value) {
      startTimer();
      Get.snackbar('Success', 'Code resent successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }
  
  @override
  void onClose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }
}
