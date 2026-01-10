import 'package:get/get.dart';
import '../controllers/property_listing_controller.dart';

class PropertyListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyListingController>(
      () => PropertyListingController(),
    );
  }
}
