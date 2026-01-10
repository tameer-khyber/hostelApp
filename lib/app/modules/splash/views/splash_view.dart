import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Background (Same light gradient as Login)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFFE0F7FA), // Very light cyan
                  Color(0xFFE1F5FE), // Light Blue
                  Color(0xFFB3E5FC), // Light Blue 100
                  Color(0xFF81D4FA), // Light Blue 200
                ],
              ),
            ),
          ),
          
          // 2. Animated Bokeh (Simulated)
          Positioned(
            top: -100,
            left: -50,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.white.withOpacity(0.0),
                  ],
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(duration: const Duration(seconds: 4), begin: const Offset(1, 1), end: const Offset(1.1, 1.1)),
          ),
          Positioned(
            bottom: 150,
            right: -80,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.15),
                    Colors.blueAccent.withOpacity(0.0),
                  ],
                ),
              ),
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .scale(duration: const Duration(seconds: 5), begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0)),
          ),

          // 3. Center Content (Logo & Text)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Icon
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.25),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                    border: Border.all(color: Colors.white.withOpacity(0.5), width: 1),
                  ),
                  child: Icon(
                    Icons.home_work_rounded,
                    size: 80,
                    color: Colors.teal.shade400,
                  ),
                ).animate()
                 .fadeIn(duration: const Duration(milliseconds: 600))
                 .scale(delay: const Duration(milliseconds: 200), curve: Curves.easeOutBack),

                const SizedBox(height: 24),

                // App Name
                Text(
                  'HostelApp',
                  style: GoogleFonts.poppins(
                    fontSize: 42,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF2C3E50),
                    letterSpacing: 1.2,
                  ),
                ).animate()
                 .fadeIn(delay: const Duration(milliseconds: 400))
                 .slideY(begin: 0.2, curve: Curves.easeOut),

                const SizedBox(height: 8),

                // Tagline
                Text(
                  'Manage your space with ease',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey.shade600,
                    letterSpacing: 0.5,
                  ),
                ).animate()
                 .fadeIn(delay: const Duration(milliseconds: 600)),
              ],
            ),
          ),
          
          // 4. Loading Indicator (Bottom)
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircularProgressIndicator(
                  color: Colors.teal.shade300,
                  strokeWidth: 3,
                ),
              ),
            ).animate().fadeIn(delay: const Duration(milliseconds: 800)),
          ),
        ],
      ),
    );
  }
}
