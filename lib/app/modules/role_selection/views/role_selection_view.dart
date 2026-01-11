import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../global_widgets/glass_container.dart';
import '../../../global_widgets/theme_toggle_button.dart';
import '../controllers/role_selection_controller.dart';

class RoleSelectionView extends GetView<RoleSelectionController> {
  const RoleSelectionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background (Theme Aware)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: Theme.of(context).brightness == Brightness.dark
                    ? [const Color(0xFF1A1A2E), const Color(0xFF16213E), const Color(0xFF0F3460)]
                    : [const Color(0xFFE0F7FA), const Color(0xFFE1F5FE), const Color(0xFFB3E5FC), const Color(0xFF81D4FA)],
              ),
            ),
          ),
          
          // 2. Animated Bokeh
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(duration: const Duration(seconds: 5), begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
          ),

          // 3. Main Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   // Top Bar
                   Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       const ThemeToggleButton(),
                     ],
                   ),
                   const Spacer(flex: 1),
                   Text(
                    "Who are you?",
                    style: GoogleFonts.poppins(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ).animate().fadeIn().slideX(),
                  
                   Text(
                    "Choose your role to get started",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 200)).slideX(),
                  
                  const SizedBox(height: 40),
                  
                  // Owner Card
                  _buildRoleCard(
                    context,
                    title: "Property Owner",
                    description: "I want to list my property and manage tenants.",
                    icon: Icons.vpn_key_rounded,
                    color: Colors.blue,
                    onTap: controller.selectOwner,
                    delay: 400,
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Tenant Card
                  _buildRoleCard(
                    context,
                    title: "Tenant / Guest",
                    description: "I am looking for a hostel or flat to rent.",
                    icon: Icons.person_search_rounded,
                    color: Colors.orange,
                    onTap: controller.selectTenant,
                    delay: 600,
                  ),
                  
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required int delay,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: BorderRadius.circular(24),
        blur: 15,
        opacity: 0.5,
        padding: const EdgeInsets.all(24),
        border: Border.all(
          color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.8), 
          width: 1.5
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 32, color: color),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: isDark ? Colors.grey[400] : Colors.grey.shade400),
          ],
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).slideY(begin: 0.2);
  }
}
