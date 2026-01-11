import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Notifications', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent, // Glass effect provided by container below if needed, or just standard
        elevation: 0,
        centerTitle: true,
        leading: Tooltip(
            message: "Back",
            child: Container(
              margin: const EdgeInsets.all(8),
               decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Get.back(),
              ),
            ),
        ),
      ),
      body: Stack(
        children: [
           // 1. Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE0F7FA), // Light Cyan
                  Color(0xFFE8EAF6), // Light Indigo
                  Color(0xFFF3E5F5), // Light Purple
                ],
              ),
            ),
          ),
          
          SafeArea(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(24),
              itemCount: controller.notifications.length,
              itemBuilder: (context, index) {
                final notif = controller.notifications[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: GlassContainer(
                    borderRadius: BorderRadius.circular(20),
                    blur: 15,
                    opacity: 0.6,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Colors.teal.withOpacity(0.2), Colors.teal.withOpacity(0.05)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.notifications_active_rounded, color: Colors.teal, size: 24),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notif['title']!,
                                style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50)),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                notif['body']!,
                                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700]),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                notif['time']!,
                                style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[500], fontStyle: FontStyle.italic),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1);
              },
            )),
          ),
        ],
      ),
    );
  }
}
