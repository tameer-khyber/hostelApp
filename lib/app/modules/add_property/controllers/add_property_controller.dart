import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../../data/services/property_service.dart';
import '../../../data/models/property_model.dart';
import 'dart:math';

class AddPropertyController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();

  final nameController = TextEditingController();
  final locationController = TextEditingController();
  final priceController = TextEditingController();
  final depositController = TextEditingController();
  final rulesController = TextEditingController();
  final descriptionController = TextEditingController();

  PropertyModel? editingProperty;
  final isEditing = false.obs;

  final selectedType = 'Hostel'.obs;
  final propertyTypes = ['Hostel', 'Flat', 'Room', 'Hotel'];
  
  final availableAmenities = ['Wi-Fi', 'AC', 'Parking', 'Food', 'Gym', 'Laundry', 'Security', 'TV'];
  final selectedAmenities = <String>[].obs;
  
  void toggleAmenity(String amenity) {
    if (selectedAmenities.contains(amenity)) {
      selectedAmenities.remove(amenity);
    } else {
      selectedAmenities.add(amenity);
    }
  }

  final Rxn<LatLng> pickedLocation = Rxn<LatLng>();

  void setPickedLocation(LatLng location) {
    pickedLocation.value = location;
    Get.snackbar("Location Set", "Property location updated", 
      backgroundColor: Colors.green, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
  }

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
      editingProperty?.rating ?? 5.0, // Keep existing rating or default
      selectedImage.value,
      id: editingProperty?.id, // Keep existing ID if editing
      description: descriptionController.text,
      ownerName: "Me (Owner)", 
      // reviews: [], // Removed duplicate
      securityDeposit: depositController.text.isNotEmpty ? "\$${depositController.text}" : null,
      rules: rulesController.text.isNotEmpty ? rulesController.text.split('\n') : [],
      amenities: selectedAmenities.toList(),
      latitude: pickedLocation.value?.latitude ?? 0.0,
      longitude: pickedLocation.value?.longitude ?? 0.0,
      isVisible: editingProperty?.isVisible ?? true,
      reviews: editingProperty?.reviews ?? [],
    );

    if (isEditing.value) {
      _propertyService.updateProperty(newProperty);
    } else {
      _propertyService.addProperty(newProperty);
    }
    
    // Clear form
    nameController.clear();
    locationController.clear();
    priceController.clear();
    descriptionController.clear();
    selectedImage.value = "";
    
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments is PropertyModel) {
      editingProperty = Get.arguments as PropertyModel;
      isEditing.value = true;
      _prefillData();
    }
  }

  void _prefillData() {
    if (editingProperty == null) return;
    nameController.text = editingProperty!.name;
    locationController.text = editingProperty!.location;
    // Remove non-numeric chars for editing if needed, but simple copy is fine for now
    priceController.text = editingProperty!.price.replaceAll(RegExp(r'[^0-9]'), ''); 
    descriptionController.text = editingProperty!.description;
    if (editingProperty!.securityDeposit != null) {
      depositController.text = editingProperty!.securityDeposit!.replaceAll(RegExp(r'[^0-9]'), '');
    }
    rulesController.text = editingProperty!.rules.join('\n');
    selectedImage.value = editingProperty!.imageUrl;
    selectedAmenities.assignAll(editingProperty!.amenities);
    
    if (editingProperty!.latitude != 0.0) {
      pickedLocation.value = LatLng(editingProperty!.latitude, editingProperty!.longitude);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    locationController.dispose();
    priceController.dispose();
    depositController.dispose();
    rulesController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
