import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/property_model.dart';

import '../../../data/services/property_service.dart';

class TenantHomeController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();

  final searchController = TextEditingController();
  final selectedCategoryIndex = 0.obs;
  
  final categories = [
    {'name': 'Hostels', 'icon': Icons.apartment_rounded},
    {'name': 'Flats', 'icon': Icons.home_rounded},
    {'name': 'Rooms', 'icon': Icons.bed_rounded},
    {'name': 'Hotels', 'icon': Icons.hotel_rounded},
  ];

  // Expose mock lists from service
  RxList<PropertyModel> get featuredListings => _propertyService.allProperties.take(3).toList().obs;
  RxList<PropertyModel> get nearbyPlaces => _propertyService.allProperties.skip(3).take(2).toList().obs;

  // --- Filter State ---
  final rentRange = const RangeValues(100, 500).obs;
  final selectedRoomType = "Shared".obs;
  final selectedGender = "Boys".obs;
  final isFurnished = false.obs;
  final selectedFacilities = <String>[].obs;
  
  final facilitiesList = ["WiFi", "AC", "Mess", "Parking", "Laundry", "Gym"];

  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  void updateRentRange(RangeValues values) {
    rentRange.value = values;
  }

  void toggleFacility(String facility) {
    if (selectedFacilities.contains(facility)) {
      selectedFacilities.remove(facility);
    } else {
      selectedFacilities.add(facility);
    }
  }

  // --- Search & Filter Logic ---
  List<PropertyModel> get filteredListings {
    String query = searchController.text.toLowerCase();
    
    return featuredListings.where((property) {
      bool matchesSearch = property.name.toLowerCase().contains(query) || 
                           property.location.toLowerCase().contains(query);
                           
      // In a real app, we would match categories/price/facilities here
      // For now, let's just use search query for demonstration
      return matchesSearch;
    }).toList();
  }

  void onSearchChanged(String val) {
    featuredListings.refresh(); 
  }

  void applyFilters() {
    Get.back(); // Close bottom sheet
    Get.snackbar(
      "Filters Applied", 
      "Rent: \$${rentRange.value.start.toInt()} - \$${rentRange.value.end.toInt()}\nType: ${selectedRoomType.value}",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.teal.withOpacity(0.8),
      colorText: Colors.white,
    );
  }
  
  void resetFilters() {
    rentRange.value = const RangeValues(100, 500);
    selectedRoomType.value = "Shared";
    selectedGender.value = "Boys";
    isFurnished.value = false;
    selectedFacilities.clear();
  }
}
