import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/owner_chat_list_controller.dart';
import '../../../routes/app_pages.dart';

class OwnerChatListView extends GetView<OwnerChatListController> {
  const OwnerChatListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Messages",
          style: GoogleFonts.poppins(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded, color: theme.iconTheme.color),
            onPressed: () {},
          )
        ],
      ),
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF1A1A2E), const Color(0xFF16213E), const Color(0xFF0F3460)]
                    : [const Color(0xFFE0F7FA), const Color(0xFFE8EAF6), const Color(0xFFF3E5F5)],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Obx(() => ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: controller.conversations.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final chat = controller.conversations[index];
                return GestureDetector(
                  onTap: () {
                    // Navigate to ChatView (generic) with arguments
                    Get.toNamed(
                      Routes.CHAT, 
                      arguments: {
                        'ownerName': chat['name'], // Reusing 'ownerName' param for chat partner name
                        'isOnline': chat['isOnline'],
                        'image': chat['image']
                      }
                    );
                  },
                  child: GlassContainer(
                    borderRadius: BorderRadius.circular(20),
                    blur: 10,
                    opacity: isDark ? 0.3 : 0.6,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.teal.withOpacity(0.2),
                              backgroundImage: chat['image'] != null ? NetworkImage(chat['image']) : null,
                              child: chat['image'] == null 
                                ? Text(chat['name'][0], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 20))
                                : null,
                            ),
                            if (chat['isOnline'])
                              Positioned(
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  width: 14,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 2),
                                  ),
                                ),
                              )
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    chat['name'],
                                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: theme.textTheme.bodyLarge?.color),
                                  ),
                                  Text(
                                    chat['time'],
                                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      chat['lastMessage'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13, 
                                        color: chat['unread'] > 0 ? theme.textTheme.bodyLarge?.color : Colors.grey,
                                        fontWeight: chat['unread'] > 0 ? FontWeight.w600 : FontWeight.normal
                                      ),
                                    ),
                                  ),
                                  if (chat['unread'] > 0)
                                    Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: Colors.teal,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        chat['unread'].toString(),
                                        style: GoogleFonts.poppins(fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
                                      ),
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: (50 * index).ms).slideX(begin: 0.1);
              },
            )),
          ),
        ],
      ),
    );
  }
}
