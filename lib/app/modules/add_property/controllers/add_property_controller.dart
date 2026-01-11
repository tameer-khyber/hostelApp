import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/services/property_service.dart';
import '../../../data/models/property_model.dart';
import 'dart:math';

class AddPropertyController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  final selectedType = 'Hostel'.obs;
  final propertyTypes = ['Hostel', 'Flat', 'Room', 'Hotel'];
  
  // Mock image handling
  final RxString selectedImage = "".obs;

  void pickImage() {
    // Simulate picking an image by assigning a random architectural image
    final randomId = Random().nextInt(100);
    selectedImage.value = "https://picsum.photos/id/1$randomId/400/300"; 
  }

  void submitProperty() {
    if (nameController.text.isEmpty || 
        locationController.text.isEmpty || 
        priceController.text.isEmpty || 
        descriptionController.text.isEmpty) {
      Get.snackbar(
        "Error", 
        "Please fill all fields",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    if (selectedImage.value.isEmpty) {
         Get.snackbar(
        "Error", 
        "Please select an image",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    final newProperty = PropertyModel(
      nameController.text,
      locationController.text,
      "\$${priceController.text}/mo", // Formatting price
      5.0, // Default rating for new property
      selectedImage.value,
      description: descriptionController.text,
      ownerName: "Me (Owner)", // In a real app, get from User Service
      reviews: [],
    );

    _propertyService.addProperty(newProperty);
    
    // Clear form
    nameController.clear();
    locationController.clear();
    priceController.clear();
    descriptionController.clear();
    selectedImage.value = "";
    
    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    locationController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
