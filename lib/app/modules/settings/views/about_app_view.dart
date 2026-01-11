import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';

class AboutAppView extends StatelessWidget {
  const AboutAppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('About App', style: GoogleFonts.poppins(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
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
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GlassContainer(
                      borderRadius: BorderRadius.circular(40),
                      blur: 20,
                      opacity: 0.4,
                      padding: const EdgeInsets.all(30),
                      child: Icon(Icons.apartment_rounded, size: 80, color: Colors.teal),
                    ).animate().scale(),
                    
                    const SizedBox(height: 24),
                    
                    Text(
                      "Hostel Management App",
                      style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
                    ).animate().fadeIn().slideY(begin: 0.2),
                    Text(
                      "Version 1.0.0",
                      style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey),
                    ),
                    
                    const SizedBox(height: 40),
                    
                    Text(
                      "The ultimate solution for managing hostels, PGs, and rental properties. Connect with tenants, manage bookings, and handle payments seamlessly.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(fontSize: 15, height: 1.6, color: theme.textTheme.bodyMedium?.color),
                    ).animate().fadeIn(delay: 200.ms),
                    
                    const SizedBox(height: 40),
                    
                    _buildLinkTile(context, "Terms of Service"),
                    _buildLinkTile(context, "Privacy Policy"),
                    _buildLinkTile(context, "Licenses"),
                    
                    const SizedBox(height: 40),
                    
                    Text(
                      "© 2026 Tameer Fullstack. All rights reserved.",
                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkTile(BuildContext context, String title) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: Theme.of(context).textTheme.bodyLarge?.color)),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.1);
  }
}
