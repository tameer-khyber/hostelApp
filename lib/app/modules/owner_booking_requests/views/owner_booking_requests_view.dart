import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/owner_booking_requests_controller.dart';
import '../../../data/models/booking_model.dart';

class OwnerBookingRequestsView extends GetView<OwnerBookingRequestsController> {
  const OwnerBookingRequestsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: Text(
            "Booking Requests",
            style: GoogleFonts.poppins(
              color: theme.textTheme.bodyLarge?.color,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconTheme.color),
            onPressed: () => Get.back(),
          ),
          bottom: TabBar(
            indicatorColor: Colors.teal,
            labelColor: Colors.teal,
            unselectedLabelColor: isDark ? Colors.grey[500] : Colors.grey,
            labelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            tabs: const [
              Tab(text: "Requests"),
              Tab(text: "History"),
            ],
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
                      ? [const Color(0xFF1A1A2E), const Color(0xFF16213E), const Color(0xFF0F3460)]
                      : [const Color(0xFFE0F7FA), const Color(0xFFE8EAF6), const Color(0xFFF3E5F5)],
                ),
              ),
            ),
            
            // Content
            SafeArea(
              child: TabBarView(
                children: [
                  _buildRequestsList(context),
                  _buildHistoryList(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsList(BuildContext context) {
    return Obx(() {
      final requests = controller.pendingRequests;
      if (requests.isEmpty) {
        return _buildEmptyState(context, "No new booking requests", Icons.mark_email_read_outlined);
      }
      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return _buildBookingCard(context, requests[index], isRequest: true, index: index);
        },
      );
    });
  }

  Widget _buildHistoryList(BuildContext context) {
    return Obx(() {
      final history = controller.history;
      if (history.isEmpty) {
        return _buildEmptyState(context, "No booking history", Icons.history_rounded);
      }
      return ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: history.length,
        itemBuilder: (context, index) {
          return _buildBookingCard(context, history[index], isRequest: false, index: index);
        },
      );
    });
  }

  Widget _buildEmptyState(BuildContext context, String message, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 60, color: isDark ? Colors.grey[700] : Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            message,
            style: GoogleFonts.poppins(
              color: isDark ? Colors.grey[500] : Colors.grey[600],
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingCard(BuildContext context, BookingModel booking, {required bool isRequest, required int index}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => _showBookingDetails(context, booking),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(20),
          blur: 10,
          opacity: isDark ? 0.3 : 0.6,
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Tenant Info & Status
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.teal.withOpacity(0.2),
                    backgroundImage: booking.tenantImage != null ? NetworkImage(booking.tenantImage!) : null,
                    child: booking.tenantImage == null 
                      ? Text(booking.tenantName[0], style: GoogleFonts.poppins(color: Colors.teal, fontWeight: FontWeight.bold))
                      : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.tenantName,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 14, color: theme.textTheme.bodyLarge?.color),
                        ),
                        Text(
                          "Requested on ${DateFormat('MMM dd').format(booking.bookingDate)}",
                          style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  if (!isRequest)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(booking.status).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: _getStatusColor(booking.status).withOpacity(0.5)),
                      ),
                      child: Text(
                        booking.status,
                        style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: _getStatusColor(booking.status)),
                      ),
                    ),
                ],
              ),
              const Divider(height: 24),
              // Property Info
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[300],
                      image: booking.property.imageUrl.isNotEmpty 
                          ? DecorationImage(image: NetworkImage(booking.property.imageUrl), fit: BoxFit.cover)
                          : null,
                    ),
                    child: booking.property.imageUrl.isEmpty ? Icon(Icons.home, color: Colors.grey[600]) : null,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          booking.property.name,
                          style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: theme.textTheme.bodyLarge?.color),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.calendar_today_rounded, size: 12, color: Colors.teal),
                            const SizedBox(width: 4),
                            Text(
                              "${DateFormat('MMM dd').format(booking.dateRange.start)} - ${DateFormat('MMM dd').format(booking.dateRange.end)}",
                              style: GoogleFonts.poppins(fontSize: 12, color: theme.textTheme.bodyMedium?.color),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                         Text(
                            "\$${booking.totalAmount}",
                            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.teal),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              
              if (isRequest) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => controller.rejectBooking(booking.id),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.redAccent),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text("Reject"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => controller.acceptBooking(booking.id),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        child: const Text("Accept"),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    ).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.1);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Confirmed': return Colors.green;
      case 'Pending': return Colors.orange;
      case 'Cancelled': return Colors.red;
      default: return Colors.grey;
    }
  }

  void _showBookingDetails(BuildContext context, BookingModel booking) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40, 
                  height: 4, 
                  decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(2)),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Booking Details",
                style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
              ),
              const SizedBox(height: 20),
              _buildDetailRow(context, "Property", booking.property.name, Icons.apartment_rounded),
              _buildDetailRow(context, "Location", booking.property.location, Icons.location_on_outlined),
              const Divider(height: 30),
              _buildDetailRow(context, "Tenant", booking.tenantName, Icons.person_outline),
              _buildDetailRow(context, "Dates", "${DateFormat('MMM dd').format(booking.dateRange.start)} - ${DateFormat('MMM dd').format(booking.dateRange.end)}", Icons.calendar_month_outlined),
               _buildDetailRow(context, "Duration", "${booking.dateRange.duration.inDays} Days", Icons.timer_outlined),
              const Divider(height: 30),
              _buildDetailRow(context, "Total Amount", "\$${booking.totalAmount}", Icons.attach_money, isHighlight: true),
              _buildDetailRow(context, "Status", booking.status, Icons.info_outline, color: _getStatusColor(booking.status)),
              
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Get.back(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: Text("Close", style: GoogleFonts.poppins(fontSize: 16, color: Colors.white)),
                ),
              )
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value, IconData icon, {bool isHighlight = false, Color? color}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (color ?? Colors.teal).withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color ?? Colors.teal, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey)),
                Text(
                  value, 
                  style: GoogleFonts.poppins(
                    fontSize: 16, 
                    fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
                    color: color ?? theme.textTheme.bodyLarge?.color,
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
