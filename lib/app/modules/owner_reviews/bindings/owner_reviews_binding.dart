import 'package:get/get.dart';
import '../controllers/owner_reviews_controller.dart';

class OwnerReviewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OwnerReviewsController>(
      () => OwnerReviewsController(),
    );
  }
}
