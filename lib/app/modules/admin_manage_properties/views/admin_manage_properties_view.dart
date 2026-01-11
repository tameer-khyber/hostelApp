import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/admin_manage_properties_controller.dart';
import '../../../data/models/property_model.dart';

class AdminManagePropertiesView extends GetView<AdminManagePropertiesController> {
  const AdminManagePropertiesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Manage Properties", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color)),
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
            child: Column(
              children: [
                // Filters
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Obx(() => Row(
                      children: ['All', 'Pending', 'Verified', 'Blocked'].map((filter) {
                        final isSelected = controller.filter.value == filter;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(filter),
                            selected: isSelected,
                            onSelected: (_) => controller.setFilter(filter),
                            selectedColor: Colors.teal,
                            backgroundColor: isDark ? Colors.white10 : Colors.white,
                            labelStyle: GoogleFonts.poppins(color: isSelected ? Colors.white : (isDark ? Colors.grey : Colors.black)),
                          ),
                        );
                      }).toList(),
                    )),
                  ),
                ),

                Expanded(
                  child: Obx(() {
                    final list = controller.filteredProperties;
                    if (list.isEmpty) return Center(child: Text("No properties found", style: GoogleFonts.poppins(color: Colors.grey)));
                    
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        final property = list[index];
                        return _buildPropertyCard(context, property);
                      },
                    );
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPropertyCard(BuildContext context, PropertyModel property) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _showPropertyDetails(context, property),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(16),
          opacity: isDark ? 0.2 : 0.6,
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  property.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_,__,___) => Container(width: 80, height: 80, color: Colors.grey),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(property.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: theme.textTheme.bodyLarge?.color)),
                    const SizedBox(height: 4),
                    Text(property.location, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _buildStatusBadge(property.verificationStatus),
                        const SizedBox(width: 8),
                         Text("Owner: ${property.ownerName}", style: GoogleFonts.poppins(fontSize: 10, color: Colors.teal)),
                      ],
                    )
                  ],
                ),
              ),
              Icon(Icons.more_vert_rounded, color: Colors.grey[400]),
            ],
          ),
        ),
      ).animate().fadeIn().slideY(begin: 0.1),
    );
  }
  
  void _showPropertyDetails(BuildContext context, PropertyModel property) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Property Analysis", style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildDetailRow("Property", property.name),
            _buildDetailRow("Owner Name", property.ownerName),
            _buildDetailRow("Owner Contact", property.ownerContact.isNotEmpty ? property.ownerContact : "+1 234 567 8900"), // Fallback if empty
            _buildDetailRow("Status", property.verificationStatus),
            if (property.blockReason != null) _buildDetailRow("Block Reason", property.blockReason!),
            
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                     onPressed: () => _showBlockDialog(context, property),
                     style: OutlinedButton.styleFrom(
                       foregroundColor: Colors.redAccent, 
                       side: const BorderSide(color: Colors.redAccent),
                       padding: const EdgeInsets.symmetric(vertical: 16),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                     ),
                     child: Text(property.verificationStatus == 'Blocked' ? "Blocked" : "Block Property"),
                  ),
                ),
                const SizedBox(width: 16),
                if (property.verificationStatus != 'Verified')
                Expanded(
                  child: ElevatedButton(
                     onPressed: () {
                       controller.verifyProperty(property);
                       Get.back();
                     },
                     style: ElevatedButton.styleFrom(
                       backgroundColor: Colors.green,
                       padding: const EdgeInsets.symmetric(vertical: 16),
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                     ),
                     child: const Text("Verify & Approve", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  void _showBlockDialog(BuildContext context, PropertyModel property) {
    if (property.verificationStatus == 'Blocked') return;
    
    final reasonController = TextEditingController();
    Get.defaultDialog(
      title: "Block Property",
      titleStyle: GoogleFonts.poppins(fontWeight: FontWeight.bold),
      content: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text("Are you sure you want to block '${property.name}'? This will hide it from tenants.", textAlign: TextAlign.center),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: "Reason for blocking",
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
          ],
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          if (reasonController.text.isNotEmpty) {
            controller.blockProperty(property, reasonController.text);
            Get.back(); // Close dialog
          } else {
            Get.snackbar("Required", "Please provide a reason", snackPosition: SnackPosition.BOTTOM);
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
        child: const Text("Block", style: TextStyle(color: Colors.white)),
      ),
      cancel: TextButton(onPressed: () => Get.back(), child: const Text("Cancel")),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 100, child: Text(label, style: GoogleFonts.poppins(color: Colors.grey, fontWeight: FontWeight.w600))),
          Expanded(child: Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status) {
      case 'Verified': color = Colors.green; break;
      case 'Pending': color = Colors.orange; break;
      case 'Blocked': color = Colors.red; break;
      default: color = Colors.grey;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
      child: Text(status, style: GoogleFonts.poppins(fontSize: 10, color: color, fontWeight: FontWeight.bold)),
    );
  }
}
