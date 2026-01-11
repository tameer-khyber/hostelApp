import 'package:get/get.dart';

class OwnerChatListController extends GetxController {
  final conversations = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Mock Conversations
    conversations.addAll([
      {
        'id': '1',
        'name': 'Sarah Connor',
        'lastMessage': 'Is the deposit refundable?',
        'time': '10:30 AM',
        'unread': 2,
        'image': 'https://i.pravatar.cc/150?u=sarah',
        'isOnline': true,
      },
      {
        'id': '2',
        'name': 'John Smith',
        'lastMessage': 'I will arrive tomorrow at 2 PM.',
        'time': 'Yesterday',
        'unread': 0,
        'image': 'https://i.pravatar.cc/150?u=john',
        'isOnline': false,
      },
      {
        'id': '3',
        'name': 'David Rose',
        'lastMessage': 'Thanks for the info!',
        'time': 'Mon',
        'unread': 0,
        'image': null, // No image
        'isOnline': false,
      },
    ]);
  }
}
