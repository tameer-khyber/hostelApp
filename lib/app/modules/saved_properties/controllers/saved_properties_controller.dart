import 'package:get/get.dart';
import '../../../data/models/property_model.dart';
import '../../../data/services/property_service.dart';

class SavedPropertiesController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();

  // Filter properties where isFavorite is true
  // This needs to be reactive.
  // allProperties is RxList, so we can derive a list from it.
  // But standard .where() returns Iterable. We need it to be reactive.
  // We can use a getter that accesses the RxList to register dependencies if used in Obx.
  
  List<PropertyModel> get savedProperties => _propertyService.savedProperties;
}
