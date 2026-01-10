import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/booking_model.dart';
import '../../../data/services/property_service.dart';

class PaymentController extends GetxController {
  late BookingModel booking;
  final selectedMethod = "Online (Credit/Debit Card)".obs;
  final isProcessing = false.obs;

  final paymentMethods = [
    "Online (Credit/Debit Card)",
    "UPI / Net Banking", 
    "Cash on Arrival"
  ];

  @override
  void onInit() {
    super.onInit();
    // Booking passed from BookingController
    if (Get.arguments != null && Get.arguments is BookingModel) {
      booking = Get.arguments as BookingModel;
    } 
  }

  void selectMethod(String method) {
    selectedMethod.value = method;
  }

  Future<void> processPayment() async {
    isProcessing.value = true;
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    isProcessing.value = false;
    
    // Create final booking with Confirmed status
    final confirmedBooking = BookingModel(
      id: booking.id,
      property: booking.property,
      dateRange: booking.dateRange,
      totalAmount: booking.totalAmount,
      bookingDate: booking.bookingDate,
      status: 'Confirmed'
    );

    // Save to service
    Get.find<PropertyService>().addBooking(confirmedBooking);

    // Show success
    Get.defaultDialog(
      title: "Payment Successful",
      titleStyle: const TextStyle(color: Colors.teal, fontWeight: FontWeight.bold),
      content: Column(
        children: [
          const Icon(Icons.check_circle_rounded, color: Colors.teal, size: 60),
          const SizedBox(height: 16),
          const Text("Your booking has been confirmed!", textAlign: TextAlign.center),
          if (selectedMethod.value == "Cash on Arrival")
             const Padding(
               padding: EdgeInsets.only(top: 8.0),
               child: Text("(Please pay cash upon arrival)", style: TextStyle(fontSize: 12, color: Colors.grey)),
             ),
        ],
      ),
      textConfirm: "Go to Home",
      confirmTextColor: Colors.white,
      buttonColor: Colors.teal,
      onConfirm: () {
        Get.offAllNamed('/tenant-home'); 
      }
    );
  }
}
