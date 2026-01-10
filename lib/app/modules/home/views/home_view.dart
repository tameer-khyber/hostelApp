import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../global_widgets/glass_container.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // 1. Background (Consistent Light Theme)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE0F7FA), // Very light cyan
                  Color(0xFFE1F5FE), // Light Blue
                  Color(0xFFB3E5FC), // Light Blue 100
                  Color(0xFF81D4FA), // Light Blue 200
                ],
              ),
            ),
          ),
          
          // 2. Animated Bokeh
          Positioned(
            top: -150,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                     Colors.tealAccent.withOpacity(0.2),
                     Colors.white.withOpacity(0.0),
                  ],
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(duration: const Duration(seconds: 10), begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),
          ),
          
          // 3. Main Dashboard Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello, Owner",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2C3E50),
                            ),
                          ),
                          Text(
                            "Welcome back to dashboard",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.teal.shade100,
                          radius: 22,
                          child: Icon(Icons.person, color: Colors.teal.shade700),
                        ),
                      ),
                    ],
                  ).animate().fadeIn().slideX(),

                  const SizedBox(height: 30),

                  // Stats Carousel (Horizontal)
                  SizedBox(
                    height: 140,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      children: [
                        Obx(() => _buildStatCard(
                          title: "Total Beds",
                          value: "${controller.totalBeds}",
                          icon: Icons.hotel_rounded,
                          color: Colors.teal,
                          delay: 0,
                        )),
                         const SizedBox(width: 16),
                        Obx(() => _buildStatCard(
                          title: "Available",
                          value: "${controller.availableBeds}",
                          icon: Icons.event_available_rounded,
                          color: Colors.orange,
                          delay: 100,
                        )),
                         const SizedBox(width: 16),
                        Obx(() => _buildStatCard(
                          title: "Revenue",
                          value: "\$${controller.monthlyRevenue}",
                          icon: Icons.monetization_on_rounded,
                          color: Colors.blue,
                          delay: 200,
                        )),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  Text(
                    "Quick Actions",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF37474F),
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 300)),
                  
                  const SizedBox(height: 16),

                  // Quick Actions Grid
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      _buildActionCard("Add Student", Icons.person_add_alt_1_rounded, Colors.purple, 400),
                      _buildActionCard("Book Room", Icons.bedroom_parent_rounded, Colors.indigo, 500),
                      _buildActionCard("Manage Staff", Icons.badge_rounded, Colors.deepOrange, 600),
                      _buildActionCard("Reports", Icons.analytics_rounded, Colors.pink, 700),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // 4. Floating Bottom Navigation
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
              child: GlassContainer(
                borderRadius: BorderRadius.circular(40),
                blur: 15,
                opacity: 0.7, // Higher opacity for nav
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, Icons.dashboard_rounded, "Home"),
                    _buildNavItem(1, Icons.meeting_room_rounded, "Rooms"),
                    _buildNavItem(2, Icons.people_alt_rounded, "Students"),
                    _buildNavItem(3, Icons.settings_rounded, "Settings"),
                  ],
                )),
              ),
            ).animate().slideY(begin: 1, curve: Curves.easeOutBack),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required int delay,
  }) {
    return GlassContainer(
      width: 140,
      borderRadius: BorderRadius.circular(20),
      blur: 10,
      opacity: 0.4,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).slideX(begin: 0.2);
  }

  Widget _buildActionCard(String title, IconData icon, Color color, int delay) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      blur: 10,
      opacity: 0.5,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 32),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF37474F),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: delay)).scale();
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = controller.selectedIndex.value == index;
    return GestureDetector(
      onTap: () => controller.changeTabIndex(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal.shade50 : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? Colors.teal.shade700 : Colors.grey.shade600,
              size: 24,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal.shade700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
