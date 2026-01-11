import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal.withOpacity(0.2),
                  child: Text(controller.ownerName[0], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.teal)),
                ),
                if (controller.isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: isDark ? const Color(0xFF1E2746) : Colors.white, width: 2),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(width: 12),
          
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.ownerName, style: GoogleFonts.poppins(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold, fontSize: 16)),
                Text(
                  controller.isOnline ? "Online" : "Offline", 
                  style: GoogleFonts.poppins(color: controller.isOnline ? Colors.green : Colors.grey, fontSize: 12)
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.videocam_rounded, color: Colors.teal),
             onPressed: () {
              // Navigate to Video Call
              Get.toNamed(
                '/video-call', 
                arguments: {
                  'name': controller.ownerName,
                  'image': null // Could be passed if available
                }
              );
            },
          ),
          const SizedBox(width: 8),
        ],
        backgroundColor: isDark ? const Color(0xFF1E2746) : Colors.white,
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: isDark ? const Color(0xFF1A1A2E) : Colors.grey[50], // Background color
              child: Obx(() => ListView.builder(
                controller: controller.scrollController,
                padding: const EdgeInsets.all(16),
                itemCount: controller.messages.length,
                itemBuilder: (context, index) {
                  final msg = controller.messages[index];
                  final isMe = msg['isMe'] as bool;
                  return Align(
                    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.teal : (isDark ? const Color(0xFF2C3E50) : Colors.grey[200]),
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(16),
                          topRight: const Radius.circular(16),
                          bottomLeft: isMe ? const Radius.circular(16) : Radius.zero,
                          bottomRight: isMe ? Radius.zero : const Radius.circular(16),
                        ),
                      ),
                      constraints: BoxConstraints(maxWidth: Get.width * 0.75),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            msg['text'],
                            style: GoogleFonts.poppins(color: isMe ? Colors.white : (isDark ? Colors.white : const Color(0xFF2C3E50))),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            msg['time'],
                            style: GoogleFonts.poppins(color: isMe ? Colors.white70 : Colors.grey[400], fontSize: 10),
                          )
                        ],
                      ),
                    ).animate().fadeIn().slideY(begin: 0.1),
                  );
                },
              )),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: isDark ? const Color(0xFF1E2746) : Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.messageController,
                    style: GoogleFonts.poppins(color: theme.textTheme.bodyLarge?.color),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: GoogleFonts.poppins(color: isDark ? Colors.grey[400] : Colors.grey[400]),
                      filled: true,
                      fillColor: isDark ? const Color(0xFF2C3E50) : Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: IconButton(
                    icon: const Icon(Icons.send_rounded, color: Colors.white, size: 20),
                    onPressed: controller.sendMessage,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
