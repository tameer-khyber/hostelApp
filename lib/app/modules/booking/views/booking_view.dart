import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/booking_controller.dart';
import 'package:intl/intl.dart';

class BookingView extends GetView<BookingController> {
  const BookingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Confirm Booking", style: GoogleFonts.poppins(color: const Color(0xFF2C3E50), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.5),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2C3E50), size: 18),
                onPressed: () => Get.back(),
              ),
            ),
          ),
      ),
      body: Stack(
        children: [
          // Background
           Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFE0F7FA), Color(0xFFE8EAF6)],
              ),
            ),
          ),
          
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Summary
                  GlassContainer(
                    borderRadius: BorderRadius.circular(20),
                    opacity: 0.6,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(controller.property.name, style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50))),
                                Text(controller.property.location, style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey[600])),
                                const SizedBox(height: 8),
                                Text(controller.property.price, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ).animate().slideY(begin: -0.2).fadeIn(),

                  const SizedBox(height: 24),

                  // Date Selection
                  Text("Select Dates", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50))),
                  const SizedBox(height: 12),
                  InkWell(
                    onTap: () async {
                      final DateTimeRange? picked = await showDateRangePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        builder: (context, child) {
                          return Theme(
                            data: ThemeData.light().copyWith(
                              primaryColor: Colors.teal,
                              colorScheme: const ColorScheme.light(primary: Colors.teal),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (picked != null) {
                        controller.selectDateRange(picked);
                      }
                    },
                    child: GlassContainer(
                      borderRadius: BorderRadius.circular(16),
                      opacity: 0.5,
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.calendar_month_rounded, color: Colors.teal),
                          const SizedBox(width: 12),
                          Obx(() {
                             final range = controller.selectedDateRange.value;
                             if (range == null) {
                               return Text("Choose Check-in - Check-out", style: GoogleFonts.poppins(color: Colors.grey[600]));
                             }
                             final start = DateFormat('MMM dd').format(range.start);
                             final end = DateFormat('MMM dd').format(range.end);
                             return Text("$start - $end (${range.duration.inDays} nights)", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: const Color(0xFF2C3E50)));
                          }),
                          const Spacer(),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Payment Details
                  Text("Payment Details", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50))),
                  const SizedBox(height: 12),
                  GlassContainer(
                    borderRadius: BorderRadius.circular(20),
                    opacity: 0.5,
                    padding: const EdgeInsets.all(20),
                    child: Obx(() => Column(
                      children: [
                        _buildRow("Rent Amount", "\$${controller.totalRent.value}"),
                        const SizedBox(height: 8),
                        _buildRow("Service Fee (5%)", "\$${controller.serviceFee.value}"),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50))),
                            Text("\$${controller.grandTotal.value}", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
                          ],
                        ),
                      ],
                    )),
                  ),

                  const SizedBox(height: 24),
                  
                  // Advance Payment
                  GlassContainer(
                    borderRadius: BorderRadius.circular(16),
                    opacity: 0.5,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Obx(() => SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      activeColor: Colors.teal,
                      title: Text("Pay Advance Only (50%)", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: const Color(0xFF2C3E50))),
                      value: controller.isAdvancePayment.value,
                      onChanged: (val) => controller.toggleAdvancePayment(val),
                    )),
                  ),

                  const SizedBox(height: 100), // Spacing for footer
                ],
              ),
            ),
          ),
          
          // Sticky Footer
          Align(
            alignment: Alignment.bottomCenter,
            child: GlassContainer(
               borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
               blur: 20,
               opacity: 0.9,
               padding: const EdgeInsets.all(24),
               child: SizedBox(
                 width: double.infinity,
                 child: ElevatedButton(
                   onPressed: () => controller.confirmBooking(),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.teal,
                     padding: const EdgeInsets.symmetric(vertical: 16),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                     elevation: 5,
                   ),
                   child: Text("Proceed to Payment", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                 ),
               ),
            ),
          ).animate().slideY(begin: 1),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: GoogleFonts.poppins(color: Colors.grey[700])),
        Text(value, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: const Color(0xFF2C3E50))),
      ],
    );
  }
}
