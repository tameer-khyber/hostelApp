import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  // Page Controller to manage PageView
  final PageController pageController = PageController();
  
  // Observable for current page index
  final RxInt currentPage = 0.obs;

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  // Update current page index on swipe
  void onPageChanged(int index) {
    currentPage.value = index;
  }

  // Navigate to Login (Skip or Complete)
  void finishOnboarding() {
    Get.offNamed(Routes.ROLE_SELECTION);
  }

  // Go to next slide or finish
  void nextPage() {
    if (currentPage.value == 2) {
      finishOnboarding();
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300), 
        curve: Curves.easeOut,
      );
    }
  }
}
