import 'package:get/get.dart';

class NotificationsController extends GetxController {
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
    {
      'title': 'System Update',
      'body': 'HostelApp has been updated to version 2.0.',
      'time': '3 days ago'
    },
     {
      'title': 'Booking Cancelled',
      'body': 'Mark cancelled his booking for Room 101.',
      'time': '4 days ago'
    },
  ].obs;
}
