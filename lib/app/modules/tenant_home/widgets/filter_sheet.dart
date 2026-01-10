import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/tenant_home_controller.dart';

class FilterSheet extends GetView<TenantHomeController> {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Less transparent for readability
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Filter Search",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2C3E50),
                ),
              ),
              TextButton(
                onPressed: controller.resetFilters,
                child: Text("Reset", style: GoogleFonts.poppins(color: Colors.red)),
              ),
            ],
          ),
          
          const Divider(),
          const SizedBox(height: 10),

          // 1. Rent Range
          _buildSectionTitle("Rent Range (Monthly)"),
          Obx(() => Column(
            children: [
              RangeSlider(
                values: controller.rentRange.value,
                min: 50,
                max: 1000,
                divisions: 20,
                activeColor: Colors.teal,
                inactiveColor: Colors.teal.withOpacity(0.2),
                labels: RangeLabels(
                  '\$${controller.rentRange.value.start.toInt()}',
                  '\$${controller.rentRange.value.end.toInt()}',
                ),
                onChanged: controller.updateRentRange,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('\$${controller.rentRange.value.start.toInt()}', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                  Text('\$${controller.rentRange.value.end.toInt()}', style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                ],
              ),
            ],
          )),

          const SizedBox(height: 16),

          // 2. Room Type & Gender
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Room Type"),
                    const SizedBox(height: 8),
                    Obx(() => Wrap(
                      spacing: 8,
                      children: ["Shared", "Private"].map((type) {
                        final isSelected = controller.selectedRoomType.value == type;
                        return ChoiceChip(
                          label: Text(type),
                          selected: isSelected,
                          onSelected: (selected) => controller.selectedRoomType.value = type,
                          selectedColor: Colors.teal,
                          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
                          backgroundColor: Colors.grey.shade100,
                        );
                      }).toList(),
                    )),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Gender"),
                    const SizedBox(height: 8),
                    Obx(() => Wrap(
                      spacing: 8,
                      children: ["Boys", "Girls"].map((gender) {
                        final isSelected = controller.selectedGender.value == gender;
                        return ChoiceChip(
                          label: Text(gender),
                          selected: isSelected,
                          onSelected: (selected) => controller.selectedGender.value = gender,
                          selectedColor: Colors.teal,
                          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
                          backgroundColor: Colors.grey.shade100,
                        );
                      }).toList(),
                    )),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 3. Facilities
          _buildSectionTitle("Facilities"),
          const SizedBox(height: 8),
          Obx(() => Wrap(
            spacing: 8,
            runSpacing: 8,
            children: controller.facilitiesList.map((facility) {
              final isSelected = controller.selectedFacilities.contains(facility);
              return FilterChip(
                label: Text(facility),
                selected: isSelected,
                onSelected: (selected) => controller.toggleFacility(facility),
                selectedColor: Colors.teal.withOpacity(0.2),
                checkmarkColor: Colors.teal,
                labelStyle: GoogleFonts.poppins(
                  color: isSelected ? Colors.teal.shade800 : Colors.black87,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
                backgroundColor: Colors.grey.shade100,
              );
            }).toList(),
          )),

          const SizedBox(height: 24),

          // Apply Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: controller.applyFilters,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: Text("Apply Filters", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.grey.shade700,
      ),
    );
  }
}
