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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF2C3E50)),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Saved Properties",
          style: GoogleFonts.poppins(color: const Color(0xFF2C3E50), fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
           // 1. Background
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
          
          // 2. Content
          SafeArea(
            child: Obx(() {
               final saved = controller.savedProperties;
               if (saved.isEmpty) {
                 return Center(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Icon(Icons.favorite_border_rounded, size: 60, color: Colors.grey[400]),
                       const SizedBox(height: 16),
                       Text("No saved properties yet", style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 16)),
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
