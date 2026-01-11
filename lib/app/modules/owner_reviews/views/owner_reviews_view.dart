import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/owner_reviews_controller.dart';
import '../../../data/models/property_model.dart';

class OwnerReviewsView extends GetView<OwnerReviewsController> {
  const OwnerReviewsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Reviews & Ratings",
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
            child: Obx(() {
              if (controller.allReviews.isEmpty) {
                 return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.star_border_rounded, size: 60, color: isDark ? Colors.grey[700] : Colors.grey[300]),
                      const SizedBox(height: 16),
                      Text("No reviews yet", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 16)),
                    ],
                  ),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: controller.allReviews.length,
                itemBuilder: (context, index) {
                  final item = controller.allReviews[index];
                  final ReviewModel review = item['review'];
                  final String propertyName = item['property'];

                  return _buildReviewCard(context, review, propertyName, index);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(BuildContext context, ReviewModel review, String propertyName, int index) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(20),
        blur: 10,
        opacity: isDark ? 0.3 : 0.6,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header: Property Name & Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    propertyName,
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.teal),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      review.rating.toString(),
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
                    ),
                  ],
                ),
              ],
            ),
            const Divider(height: 24),
            
            // User Info
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey[300],
                  backgroundImage: review.profileImage != null ? NetworkImage(review.profileImage!) : null,
                  child: review.profileImage == null ? const Icon(Icons.person, size: 16, color: Colors.grey) : null,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.authorName,
                      style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 14, color: theme.textTheme.bodyLarge?.color),
                    ),
                    Text(
                      review.date,
                      style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              review.text,
              style: GoogleFonts.poppins(fontSize: 13, color: theme.textTheme.bodyMedium?.color),
            ),
            
            const SizedBox(height: 16),

            // Response Section
            if (review.response != null)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? Colors.teal.withOpacity(0.1) : Colors.teal.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.teal.withOpacity(0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.reply_rounded, size: 14, color: Colors.teal),
                        const SizedBox(width: 8),
                        Text("Your Response", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.teal)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      review.response!,
                      style: GoogleFonts.poppins(fontSize: 12, color: theme.textTheme.bodyMedium?.color?.withOpacity(0.9)),
                    ),
                  ],
                ),
              )
            else
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: () => _showReplyDialog(context, review, propertyName),
                  icon: const Icon(Icons.reply, size: 16),
                  label: const Text("Reply"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.teal,
                  ),
                ),
              ),
          ],
        ),
      ).animate().fadeIn(delay: (100 * index).ms).slideY(begin: 0.1),
    );
  }

  void _showReplyDialog(BuildContext context, ReviewModel review, String propertyName) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.only(
          top: 24, left: 24, right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24
        ),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E293B) : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Reply to ${review.authorName}",
              style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: theme.textTheme.bodyLarge?.color),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: controller.replyController,
              autofocus: true,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Type your response here...",
                filled: true,
                fillColor: isDark ? const Color(0xFF2C3E50) : Colors.grey[100],
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
              style: GoogleFonts.poppins(color: theme.textTheme.bodyLarge?.color),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.submitReply(review, propertyName),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text("Post Reply", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
}
