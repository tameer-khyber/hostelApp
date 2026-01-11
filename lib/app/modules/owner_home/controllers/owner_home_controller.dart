import 'package:get/get.dart';

class OwnerHomeController extends GetxController {
  // Stats
  final totalProperties = 4.obs;
  final totalBookings = 28.obs;
  final totalEarnings = 45200.0.obs;

  // Recent Activity / Notifications
  final notifications = <Map<String, String>>[
    {
      'title': 'New Booking Request',
      'body': 'Sarah Smith requested to book Room 302.',
      'time': '10 mins ago'
    },
    {
      'title': 'Rent Payment Received',
      'body': 'Payment of \$500 received from John Doe.',
      'time': '2 hours ago'
    },
    {
      'title': 'Maintenance Alert',
      'body': 'Plumbing issue reported in Flat 4B.',
      'time': '1 day ago'
    },
    {
      'title': 'New Review',
      'body': '5-star review received for "Sunrise Hostel".',
      'time': '2 days ago'
    },
  ].obs;

  @override
  void onInit() {
    super.onInit();
  }
}
