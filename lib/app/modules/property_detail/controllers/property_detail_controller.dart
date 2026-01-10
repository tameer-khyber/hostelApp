import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/property_model.dart';
import '../../../data/services/property_service.dart';

class PropertyDetailController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();
  
  // Use Rx<PropertyModel> to make the whole object reactive if replaced
  late Rx<PropertyModel> property;

  @override
  void onInit() {
    super.onInit();
    // Retrieve property from arguments
    final argProperty = Get.arguments as PropertyModel;
    
    // Find the live instance in the service to ensure we observe updates
    property = argProperty.obs;
    
    // Listen to allProperties changes to update our local 'property' reference if it changes
    ever(_propertyService.allProperties, (List<PropertyModel> all) {
       final updated = all.firstWhere((p) => p.name == property.value.name, orElse: () => property.value);
       property.value = updated;
    });
  }
  
  bool get isFavorite {
    return property.value.isFavorite; 
  }

  void toggleFavorite() {
    _propertyService.toggleFavorite(property.value);
  }

  void addReview(double rating, String text) {
     final newReview = ReviewModel(
       authorName: "You", // Mock user
       date: "Just now",
       rating: rating,
       text: text,
     );
     
     // Create a new property object with usage of new review
     final current = property.value;
     final updatedReviews = List<ReviewModel>.from(current.reviews)..insert(0, newReview);
     
     final updatedProperty = PropertyModel(
        current.name, current.location, current.price, current.rating, current.imageUrl,
        isFavorite: current.isFavorite,
        description: current.description,
        images: current.images,
        amenities: current.amenities,
        rules: current.rules,
        ownerName: current.ownerName,
        reviews: updatedReviews,
        ownerContact: current.ownerContact,
        ownerRating: current.ownerRating,
        latitude: current.latitude,
        longitude: current.longitude,
     );
     
     // Update local
     property.value = updatedProperty;
     
     // Update service
     final index = _propertyService.allProperties.indexWhere((p) => p.name == current.name);
     if(index != -1) {
       _propertyService.allProperties[index] = updatedProperty;
     }

     Get.snackbar("Success", "Review submitted successfully!", 
       snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.teal, colorText: Colors.white);
  }
}
