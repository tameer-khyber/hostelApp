import 'package:get/get.dart';
import '../controllers/owner_booking_requests_controller.dart';

class OwnerBookingRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerBookingRequestsController>(
      () => OwnerBookingRequestsController(),
    );
  }
}
