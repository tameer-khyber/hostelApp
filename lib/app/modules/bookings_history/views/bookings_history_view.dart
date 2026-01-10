import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/bookings_history_controller.dart';
import 'package:intl/intl.dart';

class BookingsHistoryView extends GetView<BookingsHistoryController> {
  const BookingsHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("My Bookings", style: GoogleFonts.poppins(color: const Color(0xFF2C3E50), fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            unselectedLabelColor: Colors.grey,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: "Active"),
              Tab(text: "Past"),
            ],
          ),
        ),
        body: Stack(
          children: [
             // Background
             Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFFE0F7FA), Color(0xFFE8EAF6), Color(0xFFF3E5F5)],
                ),
              ),
            ),
            
            SafeArea(
              child: Column(
                children: [
                  // Filter Row
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    child: SizedBox(
                      height: 40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: controller.sortOptions.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final option = controller.sortOptions[index];
                          return Obx(() {
                            final isSelected = controller.currentSort.value == option;
                            return ChoiceChip(
                              label: Text(option, style: GoogleFonts.poppins(
                                color: isSelected ? Colors.white : Colors.grey[700],
                                fontSize: 12
                              )),
                              selected: isSelected,
                              onSelected: (_) => controller.setSort(option),
                              backgroundColor: Colors.white.withOpacity(0.5),
                              selectedColor: Colors.teal,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20), side: BorderSide.none),
                            );
                          });
                        },
                      ),
                    ),
                  ),

                  // Tab Views
                  Expanded(
                    child: TabBarView(
                      children: [
                        _buildBookingList(isActive: true),
                        _buildBookingList(isActive: false),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBookingList({required bool isActive}) {
    return Obx(() {
      final bookings = isActive ? controller.activeBookings : controller.pastBookings;
      
      if (bookings.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isActive ? Icons.calendar_today_rounded : Icons.history_rounded, size: 60, color: Colors.grey[300]),
              const SizedBox(height: 16),
              Text(isActive ? "No active bookings" : "No past bookings", style: GoogleFonts.poppins(color: Colors.grey[500], fontSize: 16)),
            ],
          ),
        );
      }
      return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: GlassContainer(
              borderRadius: BorderRadius.circular(20),
              blur: 10,
              opacity: 0.6,
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Thumbnail
                      Container(
                        width: 70,
                        height: 70,
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
                            Text(booking.property.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: const Color(0xFF2C3E50))),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Icon(Icons.calendar_month_outlined, size: 14, color: Colors.grey[600]),
                                const SizedBox(width: 4),
                                Text(
                                  "${DateFormat('MMM dd').format(booking.dateRange.start)} - ${DateFormat('MMM dd').format(booking.dateRange.end)}",
                                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey[600])
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("\$${booking.totalAmount}", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.teal)),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor(booking.status).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(booking.status, style: GoogleFonts.poppins(fontSize: 10, color: _getStatusColor(booking.status))),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Booked on ${DateFormat('MMM dd, yyyy').format(booking.bookingDate)}", style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[400])),
                    ],
                  )
                ],
              ),
            ),
          ).animate().fadeIn(delay: (50 * index).ms).slideX(begin: 0.1);
        },
      );
    });
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed': return Colors.green;
      case 'Pending': return Colors.orange;
      case 'Cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }
}
