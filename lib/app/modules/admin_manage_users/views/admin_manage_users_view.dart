import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/admin_manage_users_controller.dart';

class AdminManageUsersView extends GetView<AdminManageUsersController> {
  const AdminManageUsersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Manage Users", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
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
                    ? [const Color(0xFF1E1E2C), const Color(0xFF23252F)]
                    : [const Color(0xFFF3F4F6), const Color(0xFFE5E7EB)],
              ),
            ),
          ),
          
          SafeArea(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                final user = controller.users[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: GlassContainer(
                    borderRadius: BorderRadius.circular(16),
                    opacity: isDark ? 0.2 : 0.6,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.teal.withOpacity(0.2),
                          child: Text(user['name'][0], style: TextStyle(color: Colors.teal)),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user['name'], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: theme.textTheme.bodyLarge?.color)),
                              Text(user['role'], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                              Text(user['phone'], style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: user['status'] == 'Active' ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(user['status'], style: GoogleFonts.poppins(fontSize: 10, color: user['status'] == 'Active' ? Colors.green : Colors.red)),
                            ),
                            const SizedBox(height: 8),
                            if (user['status'] == 'Active')
                              TextButton(
                                onPressed: () => controller.toggleUserStatus(user['id']),
                                style: TextButton.styleFrom(foregroundColor: Colors.red, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                child: const Text("Block", style: TextStyle(fontSize: 12)),
                              )
                            else
                              TextButton(
                                onPressed: () => controller.toggleUserStatus(user['id']),
                                style: TextButton.styleFrom(foregroundColor: Colors.green, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                                child: const Text("Unblock", style: TextStyle(fontSize: 12)),
                              )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            )),
          )
        ],
      ),
    );
  }
}
