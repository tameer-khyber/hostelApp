import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/models/property_model.dart';
import '../../../data/services/property_service.dart';

class AdminManagePropertiesController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();
  
  // Filter options
  final filter = 'All'.obs; // All, Pending, Verified, Blocked
  final properties = <PropertyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    properties.bindStream(_propertyService.allProperties.stream);
    // Actually need to filter based on selection. Let's do a computed list or reactive filter.
  }
  
  List<PropertyModel> get filteredProperties {
    if (filter.value == 'All') return _propertyService.allProperties;
    return _propertyService.allProperties.where((p) => p.verificationStatus == filter.value).toList();
  }

  void setFilter(String val) => filter.value = val;

  void verifyProperty(PropertyModel property) {
    _updateStatus(property, 'Verified');
    Get.snackbar("Success", "${property.name} has been verified.", backgroundColor: Colors.green, colorText: Colors.white);
  }

  void blockProperty(PropertyModel property, String reason) {
    _updateStatus(property, 'Blocked', reason: reason);
    Get.back(); // Close dialog
    Get.snackbar("Blocked", "${property.name} has been blocked.", backgroundColor: Colors.red, colorText: Colors.white);
  }
  
  void _updateStatus(PropertyModel property, String status, {String? reason}) {
     final index = _propertyService.allProperties.indexWhere((p) => p.id == property.id);
     if (index != -1) {
       final old = _propertyService.allProperties[index];
       final updated = PropertyModel(
         old.name, old.location, old.price, old.rating, old.imageUrl,
         id: old.id,
         isFavorite: old.isFavorite,
         reviews: old.reviews,
         description: old.description,
         images: old.images,
         amenities: old.amenities,
         rules: old.rules,
         ownerName: old.ownerName,
         ownerContact: old.ownerContact,
         ownerRating: old.ownerRating,
         latitude: old.latitude,
         longitude: old.longitude,
         securityDeposit: old.securityDeposit,
         isVisible: status != 'Blocked', // Hide if blocked, or keep visible but marked? Usually hidden.
         verificationStatus: status,
         blockReason: reason
       );
       _propertyService.allProperties[index] = updated;
     }
  }
}
