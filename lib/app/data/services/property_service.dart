import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/property_model.dart';
import '../models/booking_model.dart';

class PropertyService extends GetxService {
  final allProperties = <PropertyModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with mock data
    allProperties.addAll([
      PropertyModel("Sunny Side Hostel", "Downtown, CityCenter", "\$150/mo", 4.5, "", 
        description: "Experience the best of city living in our sunny and spacious hostel.",
        amenities: ["WiFi", "AC", "Gym", "Cafeteria"],
        ownerName: "Alice Smith",
        reviews: [
          ReviewModel(authorName: "John Doe", date: "Jan 10, 2024", rating: 4.5, text: "Great place! Really loved the vibe."),
          ReviewModel(authorName: "Jane Doe", date: "Dec 25, 2023", rating: 5.0, text: "Amazing host and clean rooms."),
        ]
      ),
      PropertyModel("Green Valley Flats", "Uptown, Hillside", "\$300/mo", 4.8, "",
        description: "Peaceful flats surrounded by nature, perfect for studying.",
        images: ["img1", "img2", "img3"],
        reviews: [
          ReviewModel(authorName: "Mike Ross", date: "Nov 12, 2023", rating: 4.0, text: "Quiet and peaceful. A bit far from city though."),
        ]
      ),
      PropertyModel("Blue Ocean Room", "Seaside, Coast", "\$200/mo", 4.2, "", reviews: []),
      PropertyModel("Cozy Corner", "Near University", "\$120/mo", 4.0, "", reviews: []),
      PropertyModel("Student Hub", "Campus Road", "\$180/mo", 4.6, "", reviews: []),
      PropertyModel("Modern Loft", "Tech Park", "\$450/mo", 4.9, "", amenities: ["WiFi", "Pool", "Smart Home"], reviews: []),
      PropertyModel("Budget Stay", "Old Town", "\$90/mo", 3.5, "", reviews: []),
      PropertyModel("Sea View Hotel", "Marina Bay", "\$600/mo", 4.7, "", reviews: []),
      PropertyModel("Quiet Cottage", "Suburbs", "\$250/mo", 4.3, "", reviews: []),
      PropertyModel("Urban Nest", "Metro Station", "\$320/mo", 4.4, "", reviews: []),
    ]);
  }

  List<PropertyModel> get savedProperties => allProperties.where((p) => p.isFavorite).toList();

  final myBookings = <BookingModel>[].obs;

  void addBooking(BookingModel booking) {
    myBookings.add(booking);
    Get.snackbar("Success", "Booking added to your history", 
      snackPosition: SnackPosition.BOTTOM, 
      backgroundColor: Colors.teal, 
      colorText: Colors.white,
      duration: const Duration(seconds: 2)
    );
  }

  void toggleFavorite(PropertyModel property) {
    // We need to replace the object in the list with a new one that has isFavorite toggled
    // OR since PropertyModel is final, we might need to recreate it.
    // However, to keep it simple and reactive without deep immutability complex patterns, 
    // let's cheat slightly and allow mutable isFavorite? No, model is final.
    // We must find index and replace.
    
    int index = allProperties.indexWhere((p) => p == property);
    if (index != -1) {
      final p = allProperties[index];
      final newProperty = PropertyModel(
        p.name, p.location, p.price, p.rating, p.imageUrl,
        isFavorite: !p.isFavorite,
        description: p.description,
        images: p.images,
        amenities: p.amenities,
        rules: p.rules,
        ownerName: p.ownerName,
        ownerContact: p.ownerContact,
        ownerRating: p.ownerRating,
        latitude: p.latitude,
        longitude: p.longitude,
        reviews: p.reviews,
      );
      allProperties[index] = newProperty;
      
      // Notify
      if (newProperty.isFavorite) {
         Get.snackbar("Favorites", "Added to favorites", snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1), backgroundColor: Colors.teal.withOpacity(0.8), colorText: Colors.white);
      } else {
         Get.snackbar("Favorites", "Removed from favorites", snackPosition: SnackPosition.BOTTOM, duration: const Duration(seconds: 1), backgroundColor: Colors.black.withOpacity(0.6), colorText: Colors.white);
      }
    }
  }
}
