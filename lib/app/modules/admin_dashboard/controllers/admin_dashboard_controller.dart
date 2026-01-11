import 'package:get/get.dart';
import '../../../data/services/property_service.dart';

class AdminDashboardController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();

  final totalUsers = 120.obs;
  final totalProperties = 0.obs;
  final pendingProperties = 0.obs;
  final activeComplaints = 5.obs;

  @override
  void onInit() {
    super.onInit();
    totalProperties.bindStream(_propertyService.allProperties.stream.map((list) => list.length));
    ever(_propertyService.allProperties, (_) => _updateStats());
    _updateStats();
  }

  void _updateStats() {
    totalProperties.value = _propertyService.allProperties.length;
    pendingProperties.value = _propertyService.allProperties.where((p) => p.verificationStatus == 'Pending').length;
  }
}
