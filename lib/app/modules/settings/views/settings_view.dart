import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import 'change_password_view.dart';
import 'help_center_view.dart';
import 'about_app_view.dart';
import '../controllers/settings_controller.dart';
import '../../../routes/app_pages.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Settings', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Container(
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
      body: Stack(
        children: [
           // 1. Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: Theme.of(context).brightness == Brightness.dark
                    ? [const Color(0xFF1A1A2E), const Color(0xFF16213E), const Color(0xFF0F3460)]
                    : [const Color(0xFFE0F7FA), const Color(0xFFE8EAF6), const Color(0xFFF3E5F5)],
              ),
            ),
          ),
          
          SafeArea(
             child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   // Account Section
                   _buildSectionHeader("Account"),
                   _buildSettingsTile(
                     icon: Icons.person_rounded,
                     title: "Edit Profile",
                     onTap: () => Get.toNamed(Routes.PROFILE),
                     delay: 0,
                   ),
                   const SizedBox(height: 10),
                     _buildSettingsTile(
                     icon: Icons.lock_rounded,
                     title: "Change Password",
                     onTap: () => Get.to(() => const ChangePasswordView()),
                     delay: 100,
                   ),
                   
                   const SizedBox(height: 24),
                   
                   // Preferences Section
                   _buildSectionHeader("Preferences"),
                    Obx(() => _buildSettingsSwitchTile(
                     icon: Icons.dark_mode_rounded,
                     title: "Dark Mode",
                     value: controller.isDarkMode.value,
                     onChanged: controller.toggleTheme,
                     delay: 200,
                   )),
                   const SizedBox(height: 10),
                    Obx(() => _buildSettingsSwitchTile(
                     icon: Icons.notifications_active_rounded,
                     title: "Notifications",
                     value: controller.notificationsEnabled.value,
                     onChanged: controller.toggleNotifications,
                     delay: 300,
                   )),
                   
                   const SizedBox(height: 24),
                   
                   // Support Section
                   _buildSectionHeader("Support"),
                   _buildSettingsTile(
                     icon: Icons.help_outline_rounded,
                     title: "Help Center",
                     onTap: () => Get.to(() => const HelpCenterView()),
                     delay: 400,
                   ),
                   const SizedBox(height: 10),
                   _buildSettingsTile(
                     icon: Icons.info_outline_rounded,
                     title: "About App",
                     onTap: () => Get.to(() => const AboutAppView()),
                     delay: 500,
                   ),
                   
                   const SizedBox(height: 40),
                   
                   SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: controller.logout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        shadowColor: Colors.redAccent.withOpacity(0.4),
                      ),
                      child: Text(
                        "Log Out",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ).animate().slideY(begin: 1, delay: 600.ms),
                ],
              ),
             ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, left: 4),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50)),
      ),
    );
  }

  Widget _buildSettingsTile({required IconData icon, required String title, required VoidCallback onTap, required int delay}) {
    return GestureDetector(
      onTap: onTap,
       child: GlassContainer(
        width: double.infinity,
        borderRadius: BorderRadius.circular(16),
        blur: 10,
        opacity: 0.6,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), shape: BoxShape.circle),
              child: Icon(icon, color: const Color(0xFF2C3E50), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
          ],
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1);
  }

  Widget _buildSettingsSwitchTile({required IconData icon, required String title, required bool value, required Function(bool) onChanged, required int delay}) {
    return GlassContainer(
        width: double.infinity,
        borderRadius: BorderRadius.circular(16),
        blur: 10,
        opacity: 0.6,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
             Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.5), shape: BoxShape.circle),
              child: Icon(icon, color: const Color(0xFF2C3E50), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500)),
            ),
            Switch(
              value: value, 
              onChanged: onChanged,
              activeColor: Colors.teal,
            ),
          ],
        ),
      ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1);
  }
}
