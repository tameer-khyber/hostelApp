import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../../../data/services/property_service.dart';

class ManagePropertiesView extends GetView<PropertyService> {
  const ManagePropertiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('My Properties', style: GoogleFonts.poppins(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GlassContainer(
            borderRadius: BorderRadius.circular(30),
            opacity: 0.5,
            padding: EdgeInsets.zero,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
              onPressed: () => Get.back(),
            ),
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
            child: Obx(() {
              if (controller.allProperties.isEmpty) {
                 return Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.house_rounded, size: 80, color: Colors.grey.withOpacity(0.5)),
                       const SizedBox(height: 16),
                       Text("No properties listed yet.", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16)),
                       const SizedBox(height: 24),
                       ElevatedButton.icon(
                         onPressed: () => Get.toNamed('/add-property'),
                         icon: const Icon(Icons.add),
                         label: const Text("Add New Property"),
                         style: ElevatedButton.styleFrom(
                           backgroundColor: Colors.teal,
                           foregroundColor: Colors.white,
                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                           padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                         ),
                       )
                     ],
                   ),
                 );
              }

              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: controller.allProperties.length + 1, // +1 for extra padding at bottom
                itemBuilder: (context, index) {
                  if (index == controller.allProperties.length) {
                    return const SizedBox(height: 80); // Bottom padding for FAB
                  }
                  
                  final property = controller.allProperties[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: GlassContainer(
                      borderRadius: BorderRadius.circular(20),
                      blur: 10,
                      opacity: isDark ? 0.3 : 0.7,
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image Thumbnail
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[300],
                                  child: property.imageUrl.isNotEmpty
                                      ? Image.network(property.imageUrl, fit: BoxFit.cover)
                                      : Icon(Icons.image, color: Colors.grey[500]),
                                ),
                              ),
                              const SizedBox(width: 16),
                              // Details
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      property.name,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: theme.textTheme.bodyLarge?.color),
                                      maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      property.location,
                                      style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
                                        maxLines: 1, overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      property.price,
                                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.teal),
                                    ),
                                  ],
                                ),
                              ),
                              // Toggle Visibility
                              Column(
                                children: [
                                  Switch(
                                    value: property.isVisible,
                                    activeColor: Colors.teal,
                                    onChanged: (val) => controller.toggleVisibility(property.id),
                                  ),
                                  Text(
                                    property.isVisible ? "Active" : "Hidden",
                                    style: GoogleFonts.poppins(fontSize: 10, color: property.isVisible ? Colors.teal : Colors.grey),
                                  )
                                ],
                              )
                            ],
                          ),
                          const Divider(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _buildActionButton(
                                context, 
                                icon: Icons.edit_rounded, 
                                label: "Edit", 
                                color: Colors.blue,
                                onTap: () => Get.toNamed('/add-property', arguments: property),
                              ),
                              _buildActionButton(
                                context, 
                                icon: Icons.delete_outline_rounded, 
                                label: "Delete", 
                                color: Colors.red,
                                onTap: () {
                                  Get.defaultDialog(
                                    title: "Delete Property",
                                    middleText: "Are you sure you want to delete '${property.name}'?",
                                    textConfirm: "Delete",
                                    textCancel: "Cancel",
                                    confirmTextColor: Colors.white,
                                    buttonColor: Colors.red,
                                    onConfirm: () {
                                      controller.deleteProperty(property.id);
                                      Get.back();
                                    }
                                  );
                                },
                              ),
                              _buildActionButton(
                                context, 
                                icon: Icons.visibility_rounded, 
                                label: "Preview", 
                                color: Colors.orange,
                                onTap: () => Get.toNamed('/property-detail', arguments: property),
                              ),
                            ],
                          )
                        ],
                      ),
                    ).animate().fadeIn(delay: (index * 100).ms).slideX(),
                  );
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Get.toNamed('/add-property'),
        backgroundColor: Colors.teal,
        icon: const Icon(Icons.add_home_rounded, color: Colors.white),
        label: Text("Add New", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 6),
            Text(label, style: GoogleFonts.poppins(fontSize: 14, color: isDark ? Colors.grey[300] : Colors.grey[800], fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
