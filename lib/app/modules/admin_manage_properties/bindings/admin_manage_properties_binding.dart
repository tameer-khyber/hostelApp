import 'package:get/get.dart';
import '../controllers/admin_manage_properties_controller.dart';

class AdminManagePropertiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminManagePropertiesController>(
      () => AdminManagePropertiesController(),
    );
  }
}
