import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class RoleSelectionController extends GetxController {
  
  void selectOwner() {
    _navigateToLogin(isOwner: true);
  }

  void selectTenant() {
    _navigateToLogin(isOwner: false);
  }

  void _navigateToLogin({required bool isOwner}) {
    // Passing argument to Login to customize experience later
    Get.toNamed(Routes.LOGIN, arguments: {'isOwner': isOwner});
  }
}
