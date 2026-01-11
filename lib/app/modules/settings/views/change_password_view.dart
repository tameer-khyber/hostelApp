import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/settings_controller.dart';

class ChangePasswordView extends GetView<SettingsController> {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Change Password', style: GoogleFonts.poppins(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
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
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Secure your account",
                    style: GoogleFonts.poppins(fontSize: 16, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  ).animate().fadeIn().slideX(begin: -0.1),
                   
                   const SizedBox(height: 24),

                   GlassContainer(
                     borderRadius: BorderRadius.circular(20),
                     blur: 15,
                     opacity: isDark ? 0.3 : 0.6,
                     padding: const EdgeInsets.all(24),
                     child: Column(
                       children: [
                         _buildPasswordField(context, "Current Password", controller.currentPasswordController),
                         const SizedBox(height: 16),
                         _buildPasswordField(context, "New Password", controller.newPasswordController),
                         const SizedBox(height: 16),
                         _buildPasswordField(context, "Confirm New Password", controller.confirmNewPasswordController),
                         
                         const SizedBox(height: 32),
                         
                         SizedBox(
                           width: double.infinity,
                           height: 50,
                           child: ElevatedButton(
                             onPressed: controller.updatePassword,
                             style: ElevatedButton.styleFrom(
                               backgroundColor: Colors.teal,
                               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                               elevation: 5,
                             ),
                             child: Text(
                               "Update Password",
                               style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                             ),
                           ),
                         ),
                       ],
                     ),
                   ).animate().fadeIn().slideY(begin: 0.1, delay: 200.ms),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPasswordField(BuildContext context, String label, TextEditingController textController) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500, color: isDark ? Colors.grey[300] : Colors.grey[800])),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: isDark ? Colors.grey.withOpacity(0.2) : Colors.grey.withOpacity(0.2)),
          ),
          child: TextField(
            controller: textController,
            obscureText: true,
            style: GoogleFonts.poppins(color: isDark ? Colors.white : Colors.black87),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              prefixIcon: Icon(Icons.lock_outline_rounded, color: isDark ? Colors.tealAccent : Colors.teal),
              hintText: "••••••••",
              hintStyle: GoogleFonts.poppins(color: isDark ? Colors.grey[600] : Colors.grey[400]),
            ),
          ),
        ),
      ],
    );
  }
}
