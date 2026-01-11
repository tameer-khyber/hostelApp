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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text("My Bookings", style: GoogleFonts.poppins(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          bottom: TabBar(
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            unselectedLabelColor: isDark ? Colors.grey[500] : Colors.grey,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: "Active"),
              Tab(text: "Past"),
            ],
          ),
        ),
        body: Stack(
          children: [
             // Background (Theme Aware)
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
                                color: isSelected ? Colors.white : (isDark ? Colors.grey[300] : Colors.grey[700]),
                                fontSize: 12
                              )),
                              selected: isSelected,
                              onSelected: (_) => controller.setSort(option),
                              backgroundColor: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
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
                        _buildBookingList(context, isActive: true),
                        _buildBookingList(context, isActive: false),
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

  Widget _buildBookingList(BuildContext context, {required bool isActive}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Obx(() {
      final bookings = isActive ? controller.activeBookings : controller.pastBookings;
      
      if (bookings.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(isActive ? Icons.calendar_today_rounded : Icons.history_rounded, size: 60, color: isDark ? Colors.grey[700] : Colors.grey[300]),
              const SizedBox(height: 16),
              Text(isActive ? "No active bookings" : "No past bookings", style: GoogleFonts.poppins(color: isDark ? Colors.grey[500] : Colors.grey[500], fontSize: 16)),
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
              opacity: isDark ? 0.3 : 0.6,
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
                          image: booking.property.imageUrl.isNotEmpty
                            ? DecorationImage(image: NetworkImage(booking.property.imageUrl), fit: BoxFit.cover)
                            : null
                        ),
                        child: booking.property.imageUrl.isEmpty 
                           ? const Icon(Icons.image, color: Colors.grey)
                           : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(booking.property.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16, color: theme.textTheme.bodyLarge?.color)),
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
                  Divider(color: isDark ? Colors.white.withOpacity(0.1) : Colors.grey.shade300),
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
