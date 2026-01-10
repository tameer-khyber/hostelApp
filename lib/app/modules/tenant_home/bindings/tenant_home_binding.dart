import 'package:get/get.dart';
import '../controllers/tenant_home_controller.dart';

class TenantHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TenantHomeController>(
      TenantHomeController(),
    );
  }
}
