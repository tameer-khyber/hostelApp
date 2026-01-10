import 'package:get/get.dart';

class HomeController extends GetxController {
  // Observable state for Bottom Navigation
  final RxInt selectedIndex = 0.obs;

  // Mock Data for Dashboard Stats (Model data would typically come from a Repository)
  final RxInt totalBeds = 120.obs;
  final RxInt availableBeds = 45.obs;
  final RxDouble monthlyRevenue = 15400.0.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize data or fetch from repository here
  }

  void changeTabIndex(int index) {
    selectedIndex.value = index;
    // Handle navigation logic if needed
  }
}
