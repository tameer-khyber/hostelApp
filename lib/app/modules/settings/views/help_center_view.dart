import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Help Center', style: GoogleFonts.poppins(color: theme.textTheme.bodyLarge?.color, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconTheme.color, size: 20),
            onPressed: () => Get.back(),
          ),
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

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "How can we help you?",
                    style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
                  ).animate().fadeIn().slideX(),
                  Text(
                    "Find answers or contact support",
                    style: GoogleFonts.poppins(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                  ).animate().fadeIn(delay: 100.ms),

                  const SizedBox(height: 30),

                  // Contact Support Cards
                  Row(
                    children: [
                      Expanded(
                        child: _buildContactCard(context, Icons.email_rounded, "Email Us", "support@hostelapp.com", Colors.blueAccent),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildContactCard(context, Icons.phone_rounded, "Call Us", "+1 800 123 4567", Colors.green),
                      ),
                    ],
                  ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

                  const SizedBox(height: 30),
                  Text(
                    "Frequently Asked Questions",
                    style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
                  ),
                  const SizedBox(height: 16),

                  _buildFaqTile(context, "How do I book a room?", "Search for a property, select 'Book Now', choose your dates, and proceed to payment."),
                  _buildFaqTile(context, "Can I cancel my booking?", "Yes, you can cancel up to 24 hours before check-in for a full refund."),
                  _buildFaqTile(context, "How to contact the owner?", "Once booked, you can use the in-app chat feature to contact the property owner."),
                  _buildFaqTile(context, "Is my payment secure?", "Yes, we use industry-standard encryption to process all payments securely."),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(BuildContext context, IconData icon, String title, String subtitle, Color color) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      blur: 10,
      opacity: isDark ? 0.3 : 0.6,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 12),
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
          Text(subtitle, style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildFaqTile(BuildContext context, String question, String answer) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.6),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          title: Text(question, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodyLarge?.color)),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Text(answer, style: GoogleFonts.poppins(fontSize: 14, color: isDark ? Colors.grey[400] : Colors.grey[700])),
            ),
          ],
        ),
      ),
    ).animate().fadeIn().slideX(begin: 0.1);
  }
}
