import 'package:flutter/material.dart';
import 'property_model.dart';

class BookingModel {
  final String id;
  final PropertyModel property;
  final DateTimeRange dateRange;
  final double totalAmount;
  final DateTime bookingDate;
  final String status; // 'Active', 'Completed', 'Cancelled'

  BookingModel({
    required this.id,
    required this.property,
    required this.dateRange,
    required this.totalAmount,
    required this.bookingDate,
    this.status = 'Active',
  });
}
