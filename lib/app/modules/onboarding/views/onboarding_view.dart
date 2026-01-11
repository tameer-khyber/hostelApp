import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../global_widgets/glass_container.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
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
                    : [const Color(0xFFE0F7FA), const Color(0xFFE1F5FE), const Color(0xFFB3E5FC), const Color(0xFF81D4FA)],
              ),
            ),
          ),
          
          // 2. Animated Bokeh (Simulated)
          Positioned(
            top: -100,
            right: -50,
            child: Container(
              width: 350,
              height: 350,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    isDark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
                    Colors.transparent,
                  ],
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(duration: const Duration(seconds: 4), begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
          ),
          

          // 4. Page View Iterating Slides
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.onPageChanged,
            children: const [
              _OnboardingSlide(
                title: "Find Hostels",
                description: "Discover comfortable and affordable hostels near your university or workplace with ease.",
                icon: Icons.location_city_rounded,
                color: Colors.teal,
              ),
              _OnboardingSlide(
                title: "Rent Flats",
                description: "Looking for more privacy? Browse through hundreds of flats available for rent.",
                icon: Icons.apartment_rounded,
                color: Colors.orange,
              ),
              _OnboardingSlide(
                title: "List Your Property",
                description: "Are you an owner? List your room or house for rent or sale and connect with guests directly.",
                icon: Icons.real_estate_agent_rounded,
                color: Colors.blueAccent,
              ),
            ],
          ),
          
          // 3. Skip Button (Moved to top of stack)
          Positioned(
            top: 50,
            right: 20,
            child: TextButton(
              onPressed: controller.finishOnboarding,
              child: Text(
                'Skip',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: isDark ? Colors.grey[400] : Colors.grey.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // 5. Bottom Controls (Indicators & Button)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page Indicators
                  Obx(() => Row(
                    children: List.generate(3, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(right: 8),
                        height: 8,
                        width: controller.currentPage.value == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == index 
                              ? Colors.teal.shade400 
                              : (isDark ? Colors.grey[700] : Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  )),
                  
                  // Next / Get Started Button
                  Obx(() => GestureDetector(
                    onTap: controller.nextPage,
                    child: GlassContainer(
                      borderRadius: BorderRadius.circular(30),
                      blur: 10,
                      opacity: isDark ? 0.3 : 0.6,
                      border: Border.all(color: Colors.white.withOpacity(isDark ? 0.2 : 1), width: 2),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            controller.currentPage.value == 2 ? "Get Started" : "Next",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.tealAccent : Colors.teal.shade700,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(
                            controller.currentPage.value == 2 
                              ? Icons.check_circle_outline_rounded 
                              : Icons.arrow_forward_rounded,
                            color: isDark ? Colors.tealAccent : Colors.teal.shade700,
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingSlide extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  const _OnboardingSlide({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           // Icon Container
           GlassContainer(
             borderRadius: BorderRadius.circular(100),
             blur: 20,
             opacity: 0.3,
             padding: const EdgeInsets.all(40),
             child: Icon(icon, size: 80, color: color),
           ).animate().scale(duration: const Duration(milliseconds: 600), curve: Curves.easeOutBack),
           
           const SizedBox(height: 50),
           
           // Text Content
           GlassContainer(
             borderRadius: BorderRadius.circular(20),
             blur: 15,
             opacity: isDark ? 0.3 : 0.4,
             padding: const EdgeInsets.all(24),
             child: Column(
               children: [
                 Text(
                   title,
                   textAlign: TextAlign.center,
                   style: GoogleFonts.poppins(
                     fontSize: 28,
                     fontWeight: FontWeight.bold,
                     color: theme.textTheme.bodyLarge?.color,
                   ),
                 ),
                 const SizedBox(height: 16),
                 Text(
                   description,
                   textAlign: TextAlign.center,
                   style: GoogleFonts.poppins(
                     fontSize: 15,
                     height: 1.5,
                     color: theme.textTheme.bodyMedium?.color,
                   ),
                 ),
               ],
             ),
           ).animate().fadeIn(delay: const Duration(milliseconds: 300)).slideY(begin: 0.2),
        ],
      ),
    );
  }
}
