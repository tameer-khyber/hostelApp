import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ChatController extends GetxController {
  final messages = <Map<String, dynamic>>[].obs;
  final messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  // Arguments
  late String ownerName;
  late bool isOnline;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map) {
      ownerName = args['ownerName'] ?? 'Owner';
      isOnline = args['isOnline'] ?? true;
    } else {
      ownerName = "Owner";
      isOnline = true;
    }

    // Mock Initial Messages
    messages.addAll([
      {'text': "Hi, is this property still available?", 'isMe': true, 'time': '10:00 AM'},
      {'text': "Yes, it is! When would you like to visit?", 'isMe': false, 'time': '10:05 AM'},
    ]);
  }

  void sendMessage() {
    if (messageController.text.isEmpty) return;
    
    messages.add({
      'text': messageController.text,
      'isMe': true,
      'time': 'Now' // Simplified
    });
    
    final text = messageController.text;
    messageController.clear();
    
    // Scroll to bottom
    Future.delayed(const Duration(milliseconds: 100), () {
      if(scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });

    // Mock Reply
    Future.delayed(const Duration(seconds: 2), () {
      messages.add({
        'text': "Thanks for your interest! Let me know if you have any other questions about '$text'.",
        'isMe': false,
        'time': 'Now'
      });
        if(scrollController.hasClients) {
        scrollController.animateTo(scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    });
  }
}
