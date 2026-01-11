import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../../../routes/app_pages.dart';
import '../controllers/admin_dashboard_controller.dart';
import '../../../global_widgets/theme_toggle_button.dart';


class AdminDashboardView extends GetView<AdminDashboardController> {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background
           Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF1E1E2C), const Color(0xFF23252F)]
                    : [const Color(0xFFF3F4F6), const Color(0xFFE5E7EB)],
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Admin Panel", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
                          Text("Manage your platform", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey)),
                        ],
                      ),
                      const ThemeToggleButton(),
                    ],
                  ),
                  const SizedBox(height: 32),

                  // Stats Grid
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                    childAspectRatio: 1.1,
                    children: [
                      Obx(() => _buildStatCard(context, "Total Users", controller.totalUsers.value.toString(), Icons.people_alt_rounded, Colors.blue)),
                      Obx(() => _buildStatCard(context, "Properties", controller.totalProperties.value.toString(), Icons.apartment_rounded, Colors.orange)),
                      Obx(() => _buildStatCard(context, "Pending Review", controller.pendingProperties.value.toString(), Icons.pending_actions_rounded, Colors.amber)),
                      Obx(() => _buildStatCard(context, "Complaints", controller.activeComplaints.value.toString(), Icons.report_problem_rounded, Colors.redAccent)),
                    ],
                  ),

                  const SizedBox(height: 32),
                  
                  // Menu Actions
                  Text("Quick Management", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
                  const SizedBox(height: 16),
                  
                  _buildMenuTile(
                    context, 
                    title: "Manage Users", 
                    subtitle: "View, block, or verify users",
                    icon: Icons.person_search_rounded,
                    color: Colors.blue,
                    onTap: () => Get.toNamed(Routes.ADMIN_MANAGE_USERS)
                  ),
                  const SizedBox(height: 16),
                  _buildMenuTile(
                    context, 
                    title: "Manage Properties", 
                    subtitle: "Verify listings & check owner details",
                    icon: Icons.home_work_rounded,
                    color: Colors.green,
                    onTap: () => Get.toNamed(Routes.ADMIN_MANAGE_PROPERTIES)
                  ),
                  const SizedBox(height: 16),
                  _buildMenuTile(
                    context, 
                    title: "Complaints", 
                    subtitle: "Resolve user reports",
                    icon: Icons.flag_rounded,
                    color: Colors.redAccent,
                    onTap: () {} // TODO: Implement Complaints view
                  ),
                  
                  const SizedBox(height: 40),
                   Center(
                    child: TextButton.icon(
                      onPressed: () => Get.offAllNamed(Routes.LOGIN),
                      icon: const Icon(Icons.logout_rounded, color: Colors.grey),
                      label: Text("Logout", style: GoogleFonts.poppins(color: Colors.grey)),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    final theme = Theme.of(context);
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      blur: 10,
      opacity: theme.brightness == Brightness.dark ? 0.2 : 0.6,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.2), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 24),
          ),
          const Spacer(),
          Text(value, style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
          Text(title, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }
  
  Widget _buildMenuTile(BuildContext context, {required String title, required String subtitle, required IconData icon, required Color color, required VoidCallback onTap}) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        borderRadius: BorderRadius.circular(16),
        blur: 10,
        opacity: theme.brightness == Brightness.dark ? 0.15 : 0.5,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
                  Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
