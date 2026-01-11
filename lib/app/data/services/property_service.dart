import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/property_model.dart';
import '../models/booking_model.dart';
import '../models/transaction_model.dart';

class PropertyService extends GetxService {
  final allProperties = <PropertyModel>[].obs;
  final transactions = <TransactionModel>[].obs;

  final myBookings = <BookingModel>[].obs;
  final ownerBookings = <BookingModel>[].obs;
  
  List<PropertyModel> get savedProperties => allProperties.where((p) => p.isFavorite).toList();

  @override
  void onInit() {
    super.onInit();
    // Initialize with mock data
    allProperties.addAll([
      PropertyModel("Sunny Side Hostel", "New Delhi, India", "\$150/mo", 4.5, "", 
        description: "Experience the best of city living in our sunny and spacious hostel.",
        amenities: ["WiFi", "AC", "Gym", "Cafeteria"],
        ownerName: "Alice Smith",
        latitude: 28.6139, longitude: 77.2090, // New Delhi
        reviews: [
          ReviewModel(authorName: "John Doe", date: "Jan 10, 2024", rating: 4.5, text: "Great place! Really loved the vibe."),
          ReviewModel(authorName: "Jane Doe", date: "Dec 25, 2023", rating: 5.0, text: "Amazing host and clean rooms."),
        ]
      ),
      PropertyModel("Green Valley Flats", "Mumbai, India", "\$300/mo", 4.8, "",
        description: "Peaceful flats surrounded by nature, perfect for studying.",
        images: ["img1", "img2", "img3"],
        latitude: 19.0760, longitude: 72.8777, // Mumbai
        reviews: [
          ReviewModel(authorName: "Mike Ross", date: "Nov 12, 2023", rating: 4.0, text: "Quiet and peaceful. A bit far from city though."),
        ]
      ),
      PropertyModel("Blue Ocean Room", "Goa, India", "\$200/mo", 4.2, "", latitude: 15.2993, longitude: 74.1240, reviews: []),
      PropertyModel("Cozy Corner", "Bangalore, India", "\$120/mo", 4.0, "", latitude: 12.9716, longitude: 77.5946, reviews: []),
      PropertyModel("Student Hub", "Pune, India", "\$180/mo", 4.6, "", latitude: 18.5204, longitude: 73.8567, reviews: []),
      PropertyModel("Modern Loft", "Hyderabad, India", "\$450/mo", 4.9, "", latitude: 17.3850, longitude: 78.4867, amenities: ["WiFi", "Pool", "Smart Home"], reviews: []),
      PropertyModel("Budget Stay", "Chennai, India", "\$90/mo", 3.5, "", latitude: 13.0827, longitude: 80.2707, reviews: []),
      PropertyModel("Sea View Hotel", "Kochi, India", "\$600/mo", 4.7, "", latitude: 9.9312, longitude: 76.2673, reviews: []),
      PropertyModel("Quiet Cottage", "Jaipur, India", "\$250/mo", 4.3, "", latitude: 26.9124, longitude: 75.7873, reviews: []),
      PropertyModel("Urban Nest", "Noida, India", "\$320/mo", 4.4, "", latitude: 28.5355, longitude: 77.3910, reviews: []),
    ]);

    // Mock Booking Requests for Owner
    ownerBookings.addAll([
       BookingModel(
        id: "BK-1001", 
        property: allProperties[0], 
        dateRange: DateTimeRange(start: DateTime.now().add(const Duration(days: 2)), end: DateTime.now().add(const Duration(days: 10))), 
        totalAmount: 450.0, 
        bookingDate: DateTime.now().subtract(const Duration(hours: 4)),
        status: "Pending",
        tenantName: "Sarah Connor",
      ),
      BookingModel(
        id: "BK-1002", 
        property: allProperties[1], 
        dateRange: DateTimeRange(start: DateTime.now().add(const Duration(days: 5)), end: DateTime.now().add(const Duration(days: 35))), 
        totalAmount: 300.0, 
        bookingDate: DateTime.now().subtract(const Duration(days: 1)),
        status: "Confirmed",
        tenantName: "John Smith",
      ),
       BookingModel(
        id: "BK-1003", 
        property: allProperties[0], 
        dateRange: DateTimeRange(start: DateTime.now().add(const Duration(days: 12)), end: DateTime.now().add(const Duration(days: 15))), 
        totalAmount: 180.0, 
        bookingDate: DateTime.now().subtract(const Duration(hours: 1)),
        status: "Pending",
        tenantName: "David Rose",
      ),
    ]);
    
    // Mock Transactions
    transactions.addAll([
      TransactionModel(
        id: "TRX-101", 
        title: "Booking #BK-1002 Payment", 
        amount: 300.0, 
        date: DateTime.now().subtract(const Duration(days: 1)), 
        status: "Completed", 
        type: "Earnings",
        bookingId: "BK-1002"
      ),
       TransactionModel(
        id: "TRX-102", 
        title: "Withdrawal to Bank ****1234", 
        amount: -250.0, 
        date: DateTime.now().subtract(const Duration(days: 3)), 
        status: "Completed", 
        type: "Withdrawal"
      ),
       TransactionModel(
        id: "TRX-103", 
        title: "Booking #BK-998 Payment", 
        amount: 450.0, 
        date: DateTime.now().subtract(const Duration(days: 5)), 
        status: "Completed", 
        type: "Earnings",
        bookingId: "BK-998"
      ),
      TransactionModel(
        id: "TRX-104", 
        title: "Booking #BK-1001 Payment", 
        amount: 450.0, 
        date: DateTime.now(), 
        status: "Pending", 
        type: "Earnings",
        bookingId: "BK-1001"
      ),
    ]);
  }

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
        id: p.id,
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
  void addProperty(PropertyModel property) {
    allProperties.insert(0, property); // Add to top of list
    Get.snackbar(
      "Success", 
      "Property '${property.name}' added successfully!",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.teal,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
    );
  }

  void updateProperty(PropertyModel updatedProperty) {
    int index = allProperties.indexWhere((p) => p.id == updatedProperty.id);
    if (index != -1) {
      allProperties[index] = updatedProperty;
      Get.snackbar(
        "Success", 
        "Property updated successfully",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.teal,
        colorText: Colors.white,
      );
    }
  }

  void deleteProperty(String id) {
    allProperties.removeWhere((p) => p.id == id);
    Get.snackbar(
      "Deleted", 
      "Property removed from listings",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
  }

  void toggleVisibility(String id) {
    int index = allProperties.indexWhere((p) => p.id == id);
    if (index != -1) {
      final p = allProperties[index];
      // Create new instance with toggled visibility
      final newProperty = PropertyModel(
        p.name, p.location, p.price, p.rating, p.imageUrl,
        id: p.id,
        isFavorite: p.isFavorite,
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
        securityDeposit: p.securityDeposit,
        isVisible: !p.isVisible,
      );
      allProperties[index] = newProperty;
       Get.snackbar(
        newProperty.isVisible ? "Visible" : "Hidden", 
        newProperty.isVisible ? "Property is now live" : "Property hidden from search",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: newProperty.isVisible ? Colors.teal : Colors.grey[800],
        colorText: Colors.white,
      );
    }
  }
}
