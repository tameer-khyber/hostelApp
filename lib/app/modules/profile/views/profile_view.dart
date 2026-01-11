import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../global_widgets/glass_container.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
             decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconTheme.color, size: 20),
            onPressed: () => Get.back(),
          ),
        ),
        actions: [
          Container(
             margin: const EdgeInsets.all(8),
             decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            child: IconButton(
              icon: Icon(Icons.edit_rounded, color: theme.iconTheme.color, size: 20),
              onPressed: controller.editProfile,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 1. Background (Theme Aware)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF1A1A2E), const Color(0xFF16213E), const Color(0xFF0F3460)]
                    : [const Color(0xFFE0F7FA), const Color(0xFFE1F5FE), const Color(0xFFB3E5FC)],
              ),
            ),
          ),
          
          // 2. Animated Bokeh
          Positioned(
            top: 50,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    isDark ? Colors.tealAccent.withOpacity(0.1) : Colors.white.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(duration: const Duration(seconds: 5), begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
          ),

          // 3. Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(top: 100, left: 24, right: 24, bottom: 40),
            child: Column(
              children: [
                // Profile Picture Area
                Center(
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.teal,
                          child: Icon(Icons.person, size: 60, color: Colors.white),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.teal.shade700,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
                        ),
                      ),
                    ],
                  ),
                ).animate().scale(),

                const SizedBox(height: 20),

                // Name & Email
                Obx(() => Text(
                  controller.name.value,
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                )).animate().fadeIn().slideY(begin: 0.2),
                
                Obx(() => Text(
                  controller.email.value,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: theme.textTheme.bodyMedium?.color,
                  ),
                )).animate().fadeIn(delay: const Duration(milliseconds: 100)).slideY(begin: 0.2),

                const SizedBox(height: 40),

                // Details Card
                GlassContainer(
                   borderRadius: BorderRadius.circular(24),
                   blur: 15,
                   opacity: isDark ? 0.3 : 0.6,
                   padding: const EdgeInsets.all(0), // Padding inside cards
                   child: Column(
                     children: [
                       _buildProfileItem(context, Icons.phone_rounded, "Phone", controller.phone.value),
                       Divider(height: 1, color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade300),
                       _buildProfileItem(context, Icons.email_rounded, "Email", controller.email.value),
                     ],
                   ),
                ).animate().fadeIn(delay: const Duration(milliseconds: 200)).slideY(begin: 0.1),

                const SizedBox(height: 24),

                // Actions Card
                GlassContainer(
                   borderRadius: BorderRadius.circular(24),
                   blur: 15,
                   opacity: isDark ? 0.3 : 0.6,
                   padding: const EdgeInsets.all(0),
                   child: Column(
                     children: [
                       _buildActionItem(context, Icons.lock_outline_rounded, "Change Password", controller.changePassword, Colors.teal.shade700),
                       Divider(height: 1, color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade300),
                       _buildActionItem(context, Icons.logout_rounded, "Logout", controller.logout, Colors.red),
                     ],
                   ),
                ).animate().fadeIn(delay: const Duration(milliseconds: 300)).slideY(begin: 0.1),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(BuildContext context, IconData icon, String title, String value) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.teal.shade700, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                Text(
                  value,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, IconData icon, String title, VoidCallback onTap, Color iconColor) {
     final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: isDark ? Colors.grey[400] : Colors.grey.shade400),
          ],
        ),
      ),
    );
  }
}
