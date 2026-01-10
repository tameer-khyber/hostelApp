import 'package:get/get.dart';
import '../../../data/models/property_model.dart';
 

import '../../../data/services/property_service.dart';

class PropertyListingController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();

  RxList<PropertyModel> get properties => _propertyService.allProperties;
}
