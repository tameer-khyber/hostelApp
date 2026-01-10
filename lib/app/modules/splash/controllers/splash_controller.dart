import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToLogin();
  }

  void _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 4)); // 4 seconds splash
    Get.offNamed(Routes.ONBOARDING);
  }
}
