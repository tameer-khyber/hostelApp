import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../property_listing/widgets/property_card.dart';
import '../controllers/saved_properties_controller.dart';

class SavedPropertiesView extends GetView<SavedPropertiesController> {
  const SavedPropertiesView({Key? key}) : super(key: key);

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
          "Saved Properties",
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
            child: Obx(() {
               final saved = controller.savedProperties;
               if (saved.isEmpty) {
                 return Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.favorite_border_rounded, size: 60, color: isDark ? Colors.grey[600] : Colors.grey[400]),
                       const SizedBox(height: 16),
                       Text("No saved properties yet", style: GoogleFonts.poppins(color: isDark ? Colors.grey[400] : Colors.grey[600], fontSize: 16)),
                     ],
                   ),
                 );
               }
               return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              itemCount: saved.length,
              itemBuilder: (context, index) {
                final property = saved[index];
                return PropertyCard(property: property)
                    .animate()
                    .fadeIn(delay: (50 * index).ms)
                    .slideY(begin: 0.1);
              },
            ); }),
          ),
        ],
      ),
    );
  }
}
