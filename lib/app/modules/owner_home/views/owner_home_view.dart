import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/owner_home_controller.dart';

class OwnerHomeView extends GetView<OwnerHomeController> {
  const OwnerHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // 1. Background (Consistent with App Theme)
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

          // 2. Bokeh Effect
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.tealAccent.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(duration: const Duration(seconds: 10)),
          ),

          // 3. Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome back,",
                              style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[700]),
                            ),
                            Text(
                              "Property Owner",
                              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50)),
                            ),
                          ],
                        ),
                        // Profile Image / Icon
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.teal, width: 2),
                          ),
                          child: const CircleAvatar(
                            radius: 20,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.person, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Stats Overview (Carousel or Grid)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        _buildStatCard(
                          title: "Total Properties",
                          value: controller.totalProperties.toString(),
                          icon: Icons.apartment_rounded,
                          color: Colors.blueAccent,
                          delay: 100,
                        ),
                        _buildStatCard(
                          title: "Total Bookings",
                          value: controller.totalBookings.toString(),
                          icon: Icons.book_online_rounded,
                          color: Colors.orangeAccent,
                          delay: 200,
                        ),
                        _buildStatCard(
                          title: "Total Earnings",
                          value: "\$${controller.totalEarnings}",
                          icon: Icons.attach_money_rounded,
                          color: Colors.green,
                          delay: 300,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Quick Actions
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      "Quick Actions",
                      style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildActionButton(
                          icon: Icons.add_home_work_rounded,
                          label: "Add Property",
                          onTap: () {
                             // Navigate to Add Property
                             Get.toNamed('/property-listing'); // Assuming this or similar route exists/will exist
                          },
                        ),
                         _buildActionButton(
                          icon: Icons.qr_code_scanner_rounded,
                          label: "Scan QR",
                          onTap: () {},
                        ),
                         _buildActionButton(
                          icon: Icons.analytics_outlined,
                          label: "Analytics",
                          onTap: () {},
                        ),
                         _buildActionButton(
                          icon: Icons.settings_outlined,
                          label: "Settings",
                          onTap: () {},
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: 400.ms),

                  const SizedBox(height: 30),

                  // Recent Notifications / Activity
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Notifications",
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50)),
                        ),
                         GestureDetector(
                           onTap: () {},
                           child: Text("View all", style: GoogleFonts.poppins(fontSize: 12, color: Colors.teal)),
                         ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  Obx(() => ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: controller.notifications.length,
                    itemBuilder: (context, index) {
                      final notif = controller.notifications[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: GlassContainer(
                          borderRadius: BorderRadius.circular(15),
                          blur: 10,
                          opacity: 0.5,
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.notifications_active_outlined, color: Colors.teal, size: 20),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      notif['title']!,
                                      style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50)),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      notif['body']!,
                                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                notif['time']!,
                                style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ),
                      ).animate().fadeIn(delay: (500 + index * 100).ms).slideX();
                    },
                  )),

                ],
              ),
            ),
          ),

          // Bottom Navigation
          Align(
            alignment: Alignment.bottomCenter,
             child: Padding(
               padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
               child: GlassContainer(
                 borderRadius: BorderRadius.circular(40),
                 blur: 15,
                 opacity: 0.8,
                 padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     _buildBottomNavItem(Icons.dashboard_rounded, "Dashboard", true),
                     _buildBottomNavItem(Icons.apartment_rounded, "Properties", false),
                     _buildBottomNavItem(Icons.calendar_month_rounded, "Bookings", false),
                     _buildBottomNavItem(Icons.person_outline_rounded, "Profile", false),
                   ],
                 ),
               ),
             ),
          ).animate().slideY(begin: 1),
        ],
      ),
    );
  }

  Widget _buildStatCard({required String title, required String value, required IconData icon, required Color color, int delay = 0}) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(20),
        blur: 10,
        opacity: 0.6,
        padding: const EdgeInsets.all(16),
        width: 140, // Fixed width for horizontal scroll
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50)),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(delay: delay.ms).slideX();
  }

  Widget _buildActionButton({required IconData icon, required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Icon(icon, color: const Color(0xFF2C3E50), size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w500, color: const Color(0xFF2C3E50)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, bool isActive) {
     return GestureDetector(
      onTap: () {
        if (label == "Profile") {
           Get.toNamed('/profile'); 
        } else if (label == "Properties") {
           Get.toNamed('/property-listing'); // Or owner specific listing View
        } else if (label == "Bookings") {
           Get.toNamed('/bookings-history'); // Or owner specific bookings
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon, 
            color: isActive ? Colors.teal : Colors.grey, 
            size: 28
          ),
        ],
      ),
    );
  }
}
