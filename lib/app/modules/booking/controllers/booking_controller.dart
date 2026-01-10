import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/property_model.dart';
import '../../../data/models/booking_model.dart';
import '../../../data/services/property_service.dart';

class BookingController extends GetxController {
  late PropertyModel property;
  
  final selectedDateRange = Rxn<DateTimeRange>();
  final totalRent = 0.0.obs;
  final serviceFee = 0.0.obs; // Derived or fixed
  final grandTotal = 0.0.obs;
  final isAdvancePayment = false.obs;
  
  // Parsed monthly price
  double _monthlyPrice = 0.0;

  @override
  void onInit() {
    super.onInit();
    property = Get.arguments as PropertyModel;
    _parsePrice();
  }

  void _parsePrice() {
    // Remove non-numeric chars except dot
    // Assuming format "$150/mo" -> 150.0
    String cleanPrice = property.price.replaceAll(RegExp(r'[^0-9.]'), '');
    _monthlyPrice = double.tryParse(cleanPrice) ?? 0.0;
  }

  void selectDateRange(DateTimeRange? range) {
    if (range == null) return;
    selectedDateRange.value = range;
    calculateTotal();
  }

  void calculateTotal() {
    if (selectedDateRange.value == null) return;
    
    final days = selectedDateRange.value!.duration.inDays;
    // Simple logic: treat 30 days as a month
    double months = days / 30.0;
    if (months < 1) months = days / 30.0; // Allow partial months? 
    // Or just daily rate = monthly / 30
    
    double calculatedRent = (days * (_monthlyPrice / 30));
    
    totalRent.value = double.parse(calculatedRent.toStringAsFixed(2));
    serviceFee.value = double.parse((totalRent.value * 0.05).toStringAsFixed(2)); // 5% fee
    grandTotal.value = double.parse((totalRent.value + serviceFee.value).toStringAsFixed(2));
  }

  void toggleAdvancePayment(bool value) {
    isAdvancePayment.value = value;
  }

  void confirmBooking() {
    if (selectedDateRange.value == null) {
      Get.snackbar("Error", "Please select a date range", backgroundColor: Colors.redAccent, colorText: Colors.white);
      return;
    }
    
    // Create booking object
    final booking = BookingModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      property: property,
      dateRange: selectedDateRange.value!,
      totalAmount: grandTotal.value,
      bookingDate: DateTime.now(),
    );
    
    // Navigate to Payment
    Get.toNamed('/payment', arguments: booking);
  }
}
