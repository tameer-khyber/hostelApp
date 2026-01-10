import 'package:get/get.dart';
import '../controllers/bookings_history_controller.dart';

class BookingsHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingsHistoryController>(
      () => BookingsHistoryController(),
    );
  }
}
