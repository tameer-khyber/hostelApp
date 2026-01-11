import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../../../global_widgets/theme_toggle_button.dart';
import '../controllers/tenant_home_controller.dart';
import '../widgets/filter_sheet.dart';

class TenantHomeView extends GetView<TenantHomeController> {
  const TenantHomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // 1. Background (Theme Aware)
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: Theme.of(context).brightness == Brightness.dark
                    ? [const Color(0xFF1A1A2E), const Color(0xFF16213E), const Color(0xFF0F3460)]
                    : [const Color(0xFFE0F7FA), const Color(0xFFE8EAF6), const Color(0xFFF3E5F5)],
              ),
            ),
          ),

          // 2. Bokeh
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                     Theme.of(context).brightness == Brightness.dark ? Colors.purpleAccent.withOpacity(0.1) : Colors.purpleAccent.withOpacity(0.2),
                    Colors.transparent,
                  ],
                ),
              ),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(duration: const Duration(seconds: 8)),
          ),

          // 3. Content
          SafeArea(
            bottom: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // App Bar / Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Find your",
                              style: GoogleFonts.poppins(fontSize: 14, color: Theme.of(context).textTheme.bodyMedium?.color),
                            ),
                            Text(
                              "Perfect Stay",
                              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const ThemeToggleButton(),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () {
                                 Get.snackbar("Notifications", "No new notifications", 
                                  backgroundColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[900] : Colors.white.withOpacity(0.8),
                                  colorText: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
                                 );
                              },
                              child: GlassContainer(
                                borderRadius: BorderRadius.circular(12),
                                blur: 10,
                                opacity: 0.4,
                                padding: const EdgeInsets.all(8),
                                child: Icon(Icons.notifications_none_rounded, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : const Color(0xFF2C3E50)),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: GlassContainer(
                      borderRadius: BorderRadius.circular(20),
                      blur: 10,
                      opacity: Theme.of(context).brightness == Brightness.dark ? 0.3 : 0.6,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: TextField(
                        controller: controller.searchController,
                        onChanged: controller.onSearchChanged,
                        style: GoogleFonts.poppins(color: Theme.of(context).textTheme.bodyLarge?.color),
                        decoration: InputDecoration(
                          hintText: "Search city, area...",
                          hintStyle: GoogleFonts.poppins(color: Theme.of(context).textTheme.bodyMedium?.color),
                          icon: Icon(Icons.search_rounded, color: Theme.of(context).iconTheme.color),
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.filter_list_rounded, color: Colors.teal),
                            onPressed: () {
                              Get.bottomSheet(
                                const FilterSheet(),
                                isScrollControlled: true,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn().slideY(begin: 0.1),

                  const SizedBox(height: 30),

                  // Categories
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: List.generate(controller.categories.length, (index) {
                        final cat = controller.categories[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Obx(() {
                             final isSelected = controller.selectedCategoryIndex.value == index;
                             final isDark = Theme.of(context).brightness == Brightness.dark;
                             return GestureDetector(
                              onTap: () => controller.selectCategory(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.teal : (isDark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.6)),
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: isSelected ? [BoxShadow(color: Colors.teal.withOpacity(0.4), blurRadius: 10, offset: const Offset(0,4))] : [],
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      cat['icon'] as IconData,
                                      color: isSelected ? Colors.white : (isDark ? Colors.grey[300] : Colors.grey[700]),
                                      size: 20,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      cat['name'] as String,
                                      style: GoogleFonts.poppins(
                                        color: isSelected ? Colors.white : (isDark ? Colors.grey[300] : Colors.grey[700]),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                      }),
                    ),
                  ).animate().fadeIn(delay: 200.ms).slideX(),

                  const SizedBox(height: 30),

                  // Featured Listings
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Featured", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                        GestureDetector(
                          onTap: () => Get.toNamed('/property-listing'),
                          child: Text("See all", style: GoogleFonts.poppins(fontSize: 12, color: Colors.teal)),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),

                  SizedBox(
                    height: 280,
                    child: Obx(() => ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: controller.filteredListings.length,
                      itemBuilder: (context, index) {
                         final item = controller.filteredListings[index];
                         final isDark = Theme.of(context).brightness == Brightness.dark;
                         return GestureDetector(
                           onTap: () => Get.toNamed('/property-detail', arguments: item),
                           child: Container(
                             width: 200,
                             margin: const EdgeInsets.only(right: 20),
                             child: GlassContainer(
                               borderRadius: BorderRadius.circular(25),
                               blur: 10,
                               opacity: isDark ? 0.3 : 0.5,
                               padding: const EdgeInsets.all(12),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   // Placeholder Image
                                   Container(
                                     height: 140,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(20),
                                        color: Colors.grey.withOpacity(0.2), // Replace with Image
                                        image: item.imageUrl.isNotEmpty ? DecorationImage(image: NetworkImage(item.imageUrl), fit: BoxFit.cover) : null,
                                     ),
                                     child: item.imageUrl.isEmpty ? Center(
                                       child: Icon(Icons.image, size: 40, color: Colors.grey[400]),
                                     ) : null,
                                   ),
                                   const SizedBox(height: 12),
                                   Text(item.name, maxLines: 1, overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                                   const SizedBox(height: 4),
                                   Row(
                                     children: [
                                       Icon(Icons.location_on, size: 14, color: Colors.grey[600]),
                                       const SizedBox(width: 4),
                                       Expanded(
                                         child: Text(item.location, maxLines: 1, overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color)),
                                       ),
                                     ],
                                   ),
                                   const Spacer(),
                                   Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Text(item.price, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.teal)),
                                       Row(
                                         children: [
                                           Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                                           Text("${item.rating}", style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                                         ],
                                       ),
                                     ],
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         );
                      },
                    ),
                  ).animate().fadeIn(delay: 300.ms).slideX()),

                  const SizedBox(height: 30),

                  // Nearby Places
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text("Nearby Places", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                  ),
                  
                  const SizedBox(height: 16),
                  
                   ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      itemCount: controller.nearbyPlaces.length,
                      itemBuilder: (context, index) {
                         final item = controller.nearbyPlaces[index];
                         final isDark = Theme.of(context).brightness == Brightness.dark;
                         return GestureDetector(
                           onTap: () => Get.toNamed('/property-detail', arguments: item),
                           child: Padding(
                             padding: const EdgeInsets.only(bottom: 16),
                             child: GlassContainer(
                               borderRadius: BorderRadius.circular(20),
                               blur: 10,
                               opacity: isDark ? 0.3 : 0.4,
                               padding: const EdgeInsets.all(12),
                               child: Row(
                                 children: [
                                    Container(
                                     width: 80,
                                     height: 80,
                                     decoration: BoxDecoration(
                                       borderRadius: BorderRadius.circular(15),
                                        color: Colors.grey.withOpacity(0.2),
                                        image: item.imageUrl.isNotEmpty ? DecorationImage(image: NetworkImage(item.imageUrl), fit: BoxFit.cover) : null, 
                                     ),
                                     child: item.imageUrl.isEmpty ? Center(child: Icon(Icons.home_work_rounded, color: Colors.grey[400])) : null,
                                   ),
                                   const SizedBox(width: 16),
                                   Expanded(
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(item.name, style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyLarge?.color)),
                                          const SizedBox(height: 4),
                                         Text(item.location, style: GoogleFonts.poppins(fontSize: 12, color: Theme.of(context).textTheme.bodyMedium?.color)),
                                          const SizedBox(height: 8),
                                          Text(item.price, style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.teal)),
                                       ],
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                           ),
                         );
                      },
                   ).animate().fadeIn(delay: 400.ms),
                ],
              ),
            ),
          ),
          
          // Bottom Nav (Placeholder for Tenant)
          Align(
            alignment: Alignment.bottomCenter,
             child: Padding(
               padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
               child: GlassContainer(
                 borderRadius: BorderRadius.circular(40),
                 blur: 15,
                 opacity: 0.8,
                 padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                   children: [
                     _buildBottomNavItem(context, Icons.home_filled, "Home", true),
                     _buildBottomNavItem(context, Icons.favorite_border_rounded, "Saved", false),
                     _buildBottomNavItem(context, Icons.article_outlined, "Bookings", false),
                     _buildBottomNavItem(context, Icons.person_outline_rounded, "Profile", false),
                   ],
                 ),
               ),
             ),
          ).animate().slideY(begin: 1),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(BuildContext context, IconData icon, String label, bool isActive) {
     final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () {
        if (label == "Profile") {
           Get.toNamed('/profile'); // Route to shared profile
        } else if (label == "Saved") {
           Get.toNamed('/saved-properties');
        } else if (label == "Bookings") {
           Get.toNamed('/bookings-history');
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon, 
            color: isActive ? Colors.teal : (isDark ? Colors.grey[400] : Colors.grey), 
            size: 28
          ),
        ],
      ),
    );
  }
}
