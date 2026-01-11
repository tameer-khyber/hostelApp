import 'package:get/get.dart';
import '../controllers/owner_payments_controller.dart';

class OwnerPaymentsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerPaymentsController>(
      () => OwnerPaymentsController(),
    );
  }
}
