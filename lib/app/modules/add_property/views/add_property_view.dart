import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/add_property_controller.dart';
import 'location_picker_view.dart';

class AddPropertyView extends GetView<AddPropertyController> {
  const AddPropertyView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Add New Property', style: GoogleFonts.poppins(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Tooltip(
            message: "Back",
            child: Container(
              margin: const EdgeInsets.all(8),
               decoration: BoxDecoration(
                  color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
                  shape: BoxShape.circle,
                ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
                onPressed: () => Get.back(),
              ),
            ),
        ),
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
                          color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
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
                  
                  _buildLabel(context, "Property Name"),
                  _buildTextField(context, controller.nameController, "e.g. Sunny Side Hostel", Icons.home_work_rounded),
                  
                  const SizedBox(height: 16),
                  
                  _buildLabel(context, "Location"),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(context, controller.locationController, "e.g. Downtown, City Center", Icons.location_on_rounded),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.teal.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: IconButton(
                          icon: Obx(() => Icon(Icons.map_rounded, color: controller.pickedLocation.value != null ? Colors.green : Colors.teal)),
                          onPressed: () async {
                             final result = await Get.to(() => const LocationPickerView());
                             if (result != null && result is LatLng) {
                               controller.setPickedLocation(result);
                             }
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                   Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             _buildLabel(context, "Price (per month)"),
                            _buildTextField(context, controller.priceController, "e.g. 150", Icons.attach_money_rounded, isNumber: true),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             _buildLabel(context, "Property Type"),
                             Container(
                               padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                               decoration: BoxDecoration(
                                 color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.6),
                                 borderRadius: BorderRadius.circular(15),
                                 border: Border.all(color: isDark ? Colors.white.withOpacity(0.1) : Colors.white, width: 1.5),
                               ),
                               child: Obx(() => DropdownButtonHideUnderline(
                                 child: DropdownButton<String>(
                                   value: controller.selectedType.value,
                                   isExpanded: true,
                                   dropdownColor: isDark ? const Color(0xFF2C3E50) : Colors.white,
                                   icon: const Icon(Icons.arrow_drop_down_rounded, color: Colors.teal),
                                   style: GoogleFonts.poppins(fontSize: 14, color: isDark ? Colors.white : Colors.black),
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
                  
                  _buildLabel(context, "Security Deposit"),
                  _buildTextField(context, controller.depositController, "e.g. 500", Icons.security_rounded, isNumber: true),

                  const SizedBox(height: 16),
                  
                  _buildLabel(context, "Facilities"),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: controller.availableAmenities.map((amenity) {
                      return Obx(() {
                        final isSelected = controller.selectedAmenities.contains(amenity);
                        return FilterChip(
                          label: Text(amenity),
                          selected: isSelected,
                          onSelected: (_) => controller.toggleAmenity(amenity),
                          checkmarkColor: Colors.white,
                          selectedColor: Colors.teal,
                          backgroundColor: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.6),
                          labelStyle: GoogleFonts.poppins(
                            color: isSelected ? Colors.white : (isDark ? Colors.grey[300] : Colors.black87),
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: isDark ? Colors.white.withOpacity(0.1) : Colors.transparent),
                          ),
                        );
                      });
                    }).toList(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _buildLabel(context, "House Rules"),
                  _buildTextField(context, controller.rulesController, "e.g. No smoking, No pets...", Icons.gavel_rounded, maxLines: 3),

                  const SizedBox(height: 16),
                  
                  _buildLabel(context, "Description"),
                  _buildTextField(context, controller.descriptionController, "Tell us about your property...", Icons.description_rounded, maxLines: 4),
                  
                  const SizedBox(height: 32),
                  
                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      onPressed: controller.submitProperty,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? Colors.tealAccent.shade700 : const Color(0xFF2C3E50),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        elevation: 5,
                        shadowColor: (isDark ? Colors.tealAccent : const Color(0xFF2C3E50)).withOpacity(0.5),
                      ),
                      child: Text(
                        "Submit Property",
                        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
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

  Widget _buildLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 4),
      child: Text(
        label,
        style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyMedium?.color),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, TextEditingController controller, String hint, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassContainer(
      borderRadius: BorderRadius.circular(15),
      blur: 10,
      opacity: isDark ? 0.3 : 0.6,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextField(
        controller: controller,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        maxLines: maxLines,
        style: GoogleFonts.poppins(fontSize: 14, color: isDark ? Colors.white : Colors.black),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: GoogleFonts.poppins(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey[500]),
          icon: Icon(icon, color: Colors.teal, size: 20),
        ),
      ),
    );
  }
}
