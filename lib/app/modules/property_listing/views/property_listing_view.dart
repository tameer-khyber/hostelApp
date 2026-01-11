import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/property_listing_controller.dart';
import '../widgets/property_card.dart';

class PropertyListingView extends GetView<PropertyListingController> {
  const PropertyListingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(
           margin: const EdgeInsets.all(8),
             decoration: BoxDecoration(
                color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_rounded, color: theme.iconTheme.color, size: 20),
            onPressed: () => Get.back(),
          ),
        ),
        title: Text(
          "Available Properties",
          style: GoogleFonts.poppins(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
           // 1. Background (Theme Aware)
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
          
          // 2. Content
          SafeArea(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              itemCount: controller.properties.length,
              itemBuilder: (context, index) {
                final property = controller.properties[index];
                return PropertyCard(property: property)
                    .animate()
                    .fadeIn(delay: (50 * index).ms)
                    .slideY(begin: 0.1);
              },
            )),
          ),
        ],
      ),
    );
  }
}
