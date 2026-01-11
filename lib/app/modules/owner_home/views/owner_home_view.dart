import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../../../routes/app_pages.dart';
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
                        GestureDetector(
                          onTap: () => Get.toNamed('/profile'),
                          child: Tooltip(
                            message: "Profile",
                            child: Container(
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
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        _buildActionButton(
                          icon: Icons.add_home_work_rounded,
                          label: "Add Property",
                          onTap: () => Get.toNamed('/add-property'),
                        ),
                        const SizedBox(width: 24),
                        _buildActionButton(
                          icon: Icons.qr_code_scanner_rounded,
                          label: "Scan QR",
                          onTap: () => Get.toNamed('/scan-qr'),
                        ),
                        const SizedBox(width: 24),
                        _buildActionButton(
                          icon: Icons.analytics_outlined,
                          label: "Analytics",
                          onTap: () => Get.toNamed('/analytics'),
                        ),
                        const SizedBox(width: 24),
                        _buildActionButton(
                          icon: Icons.bookmark_border_rounded,
                          label: "Saved",
                          onTap: () => Get.toNamed(Routes.SAVED_PROPERTIES),
                        ),
                        const SizedBox(width: 24),
                        _buildActionButton(
                          icon: Icons.settings_outlined,
                          label: "Settings",
                          onTap: () => Get.toNamed('/settings'),
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
                           onTap: () => Get.toNamed('/notifications'),
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
                      return GestureDetector(
                        onTap: () {
                           Get.snackbar(
                             notif['title']!,
                             notif['body']!,
                             snackPosition: SnackPosition.TOP,
                             backgroundColor: Colors.white.withOpacity(0.9),
                             colorText: Colors.black,
                             margin: const EdgeInsets.all(10),
                             borderRadius: 10,
                             duration: const Duration(seconds: 4),
                           );
                        },
                        child: Padding(
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
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
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
      child: Tooltip(
        message: label,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white.withOpacity(0.7), Colors.white.withOpacity(0.3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                   BoxShadow(
                     color: Colors.teal.withOpacity(0.1),
                     blurRadius: 10, 
                     offset: const Offset(0, 5)
                   ),
                   BoxShadow(
                     color: Colors.white.withOpacity(0.5),
                     blurRadius: 5, 
                     offset: const Offset(-2, -2)
                   ),
                ],
                border: Border.all(color: Colors.white.withOpacity(0.5), width: 1.5),
              ),
              child: Icon(icon, color: Colors.teal.shade700, size: 26),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12, 
                fontWeight: FontWeight.w600, 
                color: const Color(0xFF34495E)
              ),
            ),
          ],
        ),
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
      child: Tooltip(
        message: label,
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
      ),
    );
  }
}
