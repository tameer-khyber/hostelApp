import 'package:get/get.dart';

class AdminManageUsersController extends GetxController {
  // Mock Users
  final users = <Map<String, dynamic>>[
    {'id': '1', 'name': 'John Owner', 'role': 'Owner', 'status': 'Active', 'phone': '+1 234 567 890'},
    {'id': '2', 'name': 'Sarah Tenant', 'role': 'Tenant', 'status': 'Active', 'phone': '+1 987 654 321'},
    {'id': '3', 'name': 'Fake Owner', 'role': 'Owner', 'status': 'Blocked', 'phone': '+1 000 000 000'},
  ].obs;

  void toggleUserStatus(String id) {
    final index = users.indexWhere((u) => u['id'] == id);
    if (index != -1) {
      final user = users[index];
      user['status'] = user['status'] == 'Active' ? 'Blocked' : 'Active';
      users[index] = user; // Trigger update
      Get.snackbar("Updated", "User status changed to ${user['status']}");
    }
  }
}
