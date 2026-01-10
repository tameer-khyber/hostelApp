import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Room {
  final String id;
  final String number;
  final String type; // AC, Non-AC
  final int capacity;
  final int occupied;
  final double price;
  final String status; // Available, Full, Maintenance

  Room({
    required this.id,
    required this.number,
    required this.type,
    required this.capacity,
    required this.occupied,
    required this.price,
    required this.status,
  });
}

class RoomController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  
  final rooms = <Room>[].obs;
  final filteredRooms = <Room>[].obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_filterRooms);
    
    _loadDummyData();
    _filterRooms();
  }

  void _loadDummyData() {
    rooms.addAll([
      Room(id: '1', number: '101', type: 'AC', capacity: 3, occupied: 1, price: 5000, status: 'Available'),
      Room(id: '2', number: '102', type: 'Non-AC', capacity: 2, occupied: 2, price: 3000, status: 'Full'),
      Room(id: '3', number: '103', type: 'AC', capacity: 4, occupied: 0, price: 4500, status: 'Available'),
      Room(id: '4', number: '104', type: 'Non-AC', capacity: 1, occupied: 1, price: 3500, status: 'Full'),
      Room(id: '5', number: '105', type: 'AC', capacity: 3, occupied: 2, price: 5000, status: 'Available'),
    ]);
  }

  void _filterRooms() {
    if (tabController.index == 0) {
      filteredRooms.assignAll(rooms);
    } else if (tabController.index == 1) {
      filteredRooms.assignAll(rooms.where((r) => r.status == 'Available').toList());
    } else {
      filteredRooms.assignAll(rooms.where((r) => r.status == 'Full').toList());
    }
  }

  void addRoom() {
    Get.snackbar('Coming Soon', 'Add Room functionality will be implemented next.');
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
