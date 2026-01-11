import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnalyticsController extends GetxController {
  // Mock Data for Earnings (Line Chart)
  final List<FlSpot> earningsData = [
    const FlSpot(0, 3), // Jan
    const FlSpot(1, 4), // Feb
    const FlSpot(2, 3.5), // Mar
    const FlSpot(3, 5), // Apr
    const FlSpot(4, 4.8), // May
    const FlSpot(5, 6), // Jun
  ];

  // Mock Data for Occupancy (Bar Chart)
  final List<BarChartGroupData> occupancyData = [
    BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 8, color: Colors.teal, width: 16, borderRadius: BorderRadius.circular(4))]), // Mon
    BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 10, color: Colors.teal, width: 16, borderRadius: BorderRadius.circular(4))]), // Tue
    BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 14, color: Colors.teal, width: 16, borderRadius: BorderRadius.circular(4))]), // Wed
    BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 15, color: Colors.purpleAccent, width: 16, borderRadius: BorderRadius.circular(4))]), // Thu (Peak)
    BarChartGroupData(x: 4, barRods: [BarChartRodData(toY: 13, color: Colors.teal, width: 16, borderRadius: BorderRadius.circular(4))]), // Fri
    BarChartGroupData(x: 5, barRods: [BarChartRodData(toY: 10, color: Colors.teal, width: 16, borderRadius: BorderRadius.circular(4))]), // Sat
    BarChartGroupData(x: 6, barRods: [BarChartRodData(toY: 16, color: Colors.orangeAccent, width: 16, borderRadius: BorderRadius.circular(4))]), // Sun
  ];

  // Mock Data for Booking Status (Pie Chart)
  List<PieChartSectionData> get bookingStatusData => [
    PieChartSectionData(color: Colors.greenAccent, value: 40, title: '40%', radius: 50, titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    PieChartSectionData(color: Colors.orangeAccent, value: 30, title: '30%', radius: 50, titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    PieChartSectionData(color: Colors.redAccent, value: 15, title: '15%', radius: 50, titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
    PieChartSectionData(color: Colors.blueAccent, value: 15, title: '15%', radius: 50, titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
  ];

  final touchedIndex = (-1).obs;

  @override
  void onInit() {
    super.onInit();
  }
}
