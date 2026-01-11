import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/add_property_controller.dart';

class AddPropertyView extends GetView<AddPropertyController> {
  const AddPropertyView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Add New Property', style: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Tooltip(
            message: "Back",
            child: Container(
              margin: const EdgeInsets.all(8),
               decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Get.back(),
              ),
            ),
        ),
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
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image Picker Section
                  Center(
                    child: GestureDetector(
                      onTap: controller.pickImage,
                      child: Obx(() => Container(
                        width: double.infinity,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.teal.withOpacity(0.3), width: 2),
                          image: controller.selectedImage.value.isNotEmpty
                              ? DecorationImage(
                                  image: NetworkImage(controller.selectedImage.value),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: controller.selectedImage.value.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add_a_photo_rounded, size: 50, color: Colors.teal.withOpacity(0.7)),
                                  const SizedBox(height: 10),
                                  Text("Tap to select image", style: GoogleFonts.poppins(color: Colors.teal)),
                                ],
                              )
                            : null,
                      )),
                    ),
                  ).animate().fadeIn().scale(),
                  
                  const SizedBox(height: 24),
                  
                  _buildLabel("Property Name"),
                  _buildTextField(controller.nameController, "e.g. Sunny Side Hostel", Icons.home_work_rounded),
                  
                  const SizedBox(height: 16),
                  
                  _buildLabel("Location"),
                  _buildTextField(controller.locationController, "e.g. Downtown, City Center", Icons.location_on_rounded),
                  
                  const SizedBox(height: 16),
                  
                   Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             _buildLabel("Price (per month)"),
                            _buildTextField(controller.priceController, "e.g. 150", Icons.attach_money_rounded, isNumber: true),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             _buildLabel("Property Type"),
                             Container(
                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                               decoration: BoxDecoration(
                                 color: Colors.white.withOpacity(0.6),
                                 borderRadius: BorderRadius.circular(15),
                                 border: Border.all(color: Colors.white, width: 1.5),
                               ),
                               child: Obx(() => DropdownButtonHideUnderline(
                                 child: DropdownButton<String>(
                                   value: controller.selectedType.value,
                                   isExpanded: true,
                                   icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.teal),
                                   items: controller.propertyTypes.map((String value) {
                                     return DropdownMenuItem<String>(
                                       value: value,
                                       child: Text(value, style: GoogleFonts.poppins(fontSize: 14)),
                                     );
                                   }).toList(),
                                   onChanged: (val) {
                                     if(val != null) controller.selectedType.value = val;
                                   },
                                 ),
                               )),
                             ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                  
                  _buildLabel("Description"),
                  _buildTextField(controller.descriptionController, "Tell us about your property...", Icons.description_rounded, maxLines: 4),
                  
                  const SizedBox(height: 32),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: controller.submitProperty,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2C3E50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        shadowColor: const Color(0xFF2C3E50).withOpacity(0.5),
                      ),
                      child: Text(
                        "Submit Property",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ).animate().slideY(begin: 1, delay: 200.ms),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF34495E)),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(15),
      blur: 10,
      opacity: 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[500]),
          icon: Icon(icon, color: Colors.teal, size: 20),
        ),
      ),
    );
  }
}
