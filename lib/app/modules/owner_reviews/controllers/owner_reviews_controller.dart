import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/property_model.dart';
import '../../../data/services/property_service.dart';

class OwnerReviewsController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();

  // A wrapper to hold review + property context
  final allReviews = <Map<String, dynamic>>[].obs;
  
  final replyController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    _loadReviews();
  }

  void _loadReviews() {
    allReviews.clear();
    for (var property in _propertyService.allProperties) {
      for (var review in property.reviews) {
        allReviews.add({
          'property': property.name,
          'review': review,
        });
      }
    }
  }

  void submitReply(ReviewModel review, String propertyName) {
    if (replyController.text.isEmpty) return;

    // Find the property and review to update
    final propertyIndex = _propertyService.allProperties.indexWhere((p) => p.name == propertyName);
    if (propertyIndex != -1) {
      final property = _propertyService.allProperties[propertyIndex];
      final reviewIndex = property.reviews.indexOf(review); // Note: object equality might be tricky if not same instance, but here it should be same instance from memory
      
      if (reviewIndex != -1) {
         // Create updated review
         final updatedReview = ReviewModel(
           authorName: review.authorName,
           date: review.date,
           rating: review.rating,
           text: review.text,
           profileImage: review.profileImage,
           response: replyController.text,
           responseDate: DateTime.now(),
         );

         // Update list (Mutable list in property model? No, property.reviews is final list, but the list itself might be mutable if not const)
         // PropertyModel definition: final List<ReviewModel> reviews; 
         // Initialized as: this.reviews = const [] in default, but usually we pass a list.
         // Let's assume we can modify the list content if it's not unmodifiable.
         // Since we can't easily deep modify the immutable PropertyModel without a full copy method (which we semi-have in service), 
         // let's try to update the service's list directly if possible.
         
         // Actually, better to use a specific update method in Service if we want to be clean, 
         // but for this MVP, let's create a new PropertyModel with the updated review list.
         
         List<ReviewModel> newReviews = List.from(property.reviews);
         newReviews[reviewIndex] = updatedReview;

         final newProperty = PropertyModel(
            property.name, property.location, property.price, property.rating, property.imageUrl,
            id: property.id,
            reviews: newReviews,
            isFavorite: property.isFavorite,
            description: property.description,
            images: property.images,
            amenities: property.amenities,
            rules: property.rules,
            ownerName: property.ownerName,
            ownerContact: property.ownerContact,
            ownerRating: property.ownerRating,
            latitude: property.latitude,
            longitude: property.longitude,
            securityDeposit: property.securityDeposit,
            isVisible: property.isVisible
         );

         _propertyService.allProperties[propertyIndex] = newProperty;
         _loadReviews(); // Reload local list
         
         Get.back(); // Close dialog
         replyController.clear();
         Get.snackbar("Success", "Reply posted successfully", snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.teal, colorText: Colors.white);
      }
    }
  }
}
