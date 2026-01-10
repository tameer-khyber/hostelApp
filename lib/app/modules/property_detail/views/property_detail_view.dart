import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/add_review_dialog.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/property_detail_controller.dart';

class PropertyDetailView extends GetView<PropertyDetailController> {
  const PropertyDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final property = controller.property.value;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: GlassContainer(
            borderRadius: BorderRadius.circular(12),
            opacity: 0.6,
            blur: 10,
            padding: EdgeInsets.zero,
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2C3E50), size: 18),
              onPressed: () => Get.back(),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: GlassContainer(
              borderRadius: BorderRadius.circular(12),
              opacity: 0.6,
              blur: 10,
              padding: EdgeInsets.zero,
              child: Obx(() => IconButton(
                icon: Icon(
                  controller.property.value.isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                  color: Colors.redAccent,
                  size: 22
                ),
                onPressed: controller.toggleFavorite,
              )),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
           // 1. Background (Shared)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE0F7FA), Color(0xFFE8EAF6), Color(0xFFF3E5F5)],
              ),
            ),
          ),

          // 2. Content
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Gallery / Carousel
                AspectRatio(
                  aspectRatio: 1.2,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        color: Colors.grey.withOpacity(0.2), // Placeholder for Image
                        child: Center(
                          child: Icon(Icons.image_rounded, size: 80, color: Colors.grey[400]),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [Colors.black.withOpacity(0.4), Colors.transparent],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Details Container
                Transform.translate(
                  offset: const Offset(0, -30),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         // Title & Rating
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Expanded(
                               child: Text(
                                 property.name,
                                 style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50)),
                               ),
                             ),
                             Container(
                               padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                               decoration: BoxDecoration(
                                 color: Colors.amber.withOpacity(0.2),
                                 borderRadius: BorderRadius.circular(10),
                               ),
                               child: Row(
                                 children: [
                                   const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
                                   const SizedBox(width: 4),
                                    Text(
                                     "${property.rating}", 
                                     style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.orange[800]),
                                    ),
                                 ],
                               ),
                             ),
                           ],
                         ),
                         
                         const SizedBox(height: 8),
                         
                         // Location
                         Row(
                           children: [
                             Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                             const SizedBox(width: 4),
                             Text(property.location, style: GoogleFonts.poppins(color: Colors.grey[600])),
                           ],
                         ),

                         const SizedBox(height: 24),
                         
                         // Full Description
                         Text("Description", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                         const SizedBox(height: 8),
                         Text(
                           property.description,
                           style: GoogleFonts.poppins(color: Colors.grey[700], height: 1.5),
                         ),

                         const SizedBox(height: 24),

                         // Amenities
                         Text("Amenities", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                         const SizedBox(height: 12),
                         Wrap(
                           spacing: 12,
                           runSpacing: 12,
                           children: property.amenities.map((amenity) => Chip(
                             label: Text(amenity, style: GoogleFonts.poppins(color: Colors.teal)),
                             backgroundColor: Colors.teal.withOpacity(0.1),
                             avatar: const Icon(Icons.check_circle_outline_rounded, color: Colors.teal, size: 18),
                             side: BorderSide.none,
                           )).toList(),
                         ),

                         const SizedBox(height: 24),

                         // Rules
                         Text("House Rules", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                         const SizedBox(height: 12),
                         Column(
                           children: property.rules.map((rule) => Padding(
                             padding: const EdgeInsets.only(bottom: 8),
                             child: Row(
                               children: [
                                 Container(width: 6, height: 6, decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle)),
                                 const SizedBox(width: 10),
                                 Text(rule, style: GoogleFonts.poppins(color: Colors.grey[700])),
                               ],
                             ),
                           )).toList(),
                         ),

                         const SizedBox(height: 24),

                         // Reviews Section
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text("Reviews", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50))),
                             TextButton.icon(
                               onPressed: () {
                                  Get.dialog(AddReviewDialog(
                                    onSubmit: (rating, text) => controller.addReview(rating, text),
                                  ));
                               },
                               icon: const Icon(Icons.edit_note_rounded, size: 18),
                               label: Text("Write a Review", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
                             )
                           ],
                         ),
                         const SizedBox(height: 12),
                         Obx(() {
                            // Access reactive reviews from controller property
                            final reviews = controller.property.value.reviews;
                            if (reviews.isEmpty) {
                              return Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 20),
                                  child: Text("No reviews yet. Be the first to review!", style: GoogleFonts.poppins(color: Colors.grey)),
                                ),
                              );
                            }
                            return Column(
                              children: reviews.map((review) => Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Colors.white.withOpacity(0.5)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.teal.withOpacity(0.2),
                                          child: Text(review.authorName.isNotEmpty ? review.authorName[0] : '?', style: GoogleFonts.poppins(color: Colors.teal, fontWeight: FontWeight.bold)),
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(review.authorName, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50))),
                                            Text(review.date, style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey[600])),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                          decoration: BoxDecoration(
                                            color: Colors.amber.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Row(
                                            children: [
                                              const Icon(Icons.star_rounded, size: 14, color: Colors.amber),
                                              const SizedBox(width: 4),
                                              Text("${review.rating}", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.amber[900])),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(review.text, style: GoogleFonts.poppins(color: Colors.grey[800], fontSize: 13)),
                                  ],
                                ),
                              )).toList(),
                            );
                         }),

                         const SizedBox(height: 24),
                         
                         // Owner Info
                         Text("Owner", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
                         const SizedBox(height: 12),
                         Container(
                           padding: const EdgeInsets.all(16),
                           decoration: BoxDecoration(
                             color: Colors.grey[100],
                             borderRadius: BorderRadius.circular(16),
                           ),
                           child: Row(
                             children: [
                               CircleAvatar(
                                 backgroundColor: Colors.teal.withOpacity(0.2),
                                 child: Text(property.ownerName[0], style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.teal)),
                               ),
                               const SizedBox(width: 16),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text(property.ownerName, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
                                   Text("Owner Rating: ${property.ownerRating}", style: GoogleFonts.poppins(color: Colors.grey, fontSize: 12)),
                                 ],
                               ),
                               const Spacer(),
                               IconButton(
                                 icon: const Icon(Icons.message_rounded, color: Colors.teal),
                                 onPressed: () {
                                   Get.toNamed('/chat', arguments: {
                                     'ownerName': property.ownerName,
                                     'isOnline': true // Mock status
                                   });
                                 }
                               ),
                               IconButton(
                                 icon: const Icon(Icons.phone_rounded, color: Colors.teal),
                                 onPressed: () {
                                   Get.snackbar("Calling", "Calling ${property.ownerName}...",
                                     backgroundColor: Colors.teal, colorText: Colors.white, snackPosition: SnackPosition.BOTTOM);
                                 }
                               ),
                             ],
                           ),
                         ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // 3. Footer Price & Book Now
          Align(
            alignment: Alignment.bottomCenter,
            child: GlassContainer(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              blur: 15,
              opacity: 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price", style: GoogleFonts.poppins(color: Colors.grey[700], fontSize: 12)),
                      Text(property.price, style: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.teal)),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Get.toNamed('/booking', arguments: property);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      elevation: 5,
                    ),
                    child: Text("Book Now", style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                  ) 
                ],
              ),
            ),
          ).animate().slideY(begin: 1),
        ],
      ),
    );
  }
}
