import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/models/booking_model.dart';
import '../../../data/services/property_service.dart';

class OwnerBookingRequestsController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();

  // Observables
  final _bookings = <BookingModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Bind to the service's ownerBookings
    _bookings.bindStream(_propertyService.ownerBookings.stream);
    // Initial load
    _bookings.assignAll(_propertyService.ownerBookings);
  }

  // Getters for different states
  List<BookingModel> get pendingRequests => 
      _bookings.where((b) => b.status == 'Pending').toList();

  List<BookingModel> get history => 
      _bookings.where((b) => b.status != 'Pending').toList();

  void acceptBooking(String id) {
    _updateBookingStatus(id, 'Confirmed');
    Get.snackbar(
      "Booking Accepted", 
      "The booking has been confirmed.",
      backgroundColor: Colors.teal,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void rejectBooking(String id) {
    _updateBookingStatus(id, 'Cancelled');
    Get.snackbar(
      "Booking Rejected", 
      "The booking has been rejected.",
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _updateBookingStatus(String id, String newStatus) {
    final index = _propertyService.ownerBookings.indexWhere((b) => b.id == id);
    if (index != -1) {
      final old = _propertyService.ownerBookings[index];
      final updated = BookingModel(
        id: old.id,
        property: old.property,
        dateRange: old.dateRange,
        totalAmount: old.totalAmount,
        bookingDate: old.bookingDate,
        status: newStatus,
        tenantName: old.tenantName,
        tenantImage: old.tenantImage,
      );
      _propertyService.ownerBookings[index] = updated;
      _bookings.assignAll(_propertyService.ownerBookings);
    }
  }
}
