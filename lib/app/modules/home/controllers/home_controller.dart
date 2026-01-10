import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

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
    if (index == 1) {
      Get.toNamed(Routes.ROOM_LIST);
    } else if (index == 2) {
      Get.snackbar("Students", "Student management coming soon!");
    } else if (index == 3) {
       Get.toNamed(Routes.PROFILE);
    } else {
      selectedIndex.value = index;
    }
  }
}
