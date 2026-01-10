import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../global_widgets/glass_container.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1.5,
                colors: [
                  Color(0xFF2C3E50), // Dark Blue/Slate
                  Color(0xFF000000), // Black
                ],
              ),
            ),
          ),
          // Abstract Bokeh/Gradient Overlay (Simulated)
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.teal.withOpacity(0.3),
              ),
            ).animate().shimmer(duration: 5.seconds, color: Colors.tealAccent.withOpacity(0.2)),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blueAccent.withOpacity(0.2),
              ),
            ).animate().shimmer(duration: 7.seconds, delay: 1.seconds),
          ),

          // Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GlassContainer(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back',
                      style: GoogleFonts.inter(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // In glass, white text often looks better or dark if bg is light. 
                        // The design asked for "Dark navy/slate" but on a dark bokeh background, white is better.
                        // However, if the glass is "white with opacity", text should be dark if opacity is high.
                        // "Glass Background: Colors.white.withOpacity(0.2)". This is light glass on dark bg?
                        // If bg is dark, glass is 0.2 white, effectively "lighter dark".
                        // Let's use White for contrast on dark theme.
                        // If the user wants a "Light Theme" glass, the background should be light.
                        // Prompt said "abstract blue/teal bokeh background".
                        // Let's stick to White text for better visibility on dark/teal.
                      ),
                    ).animate().fadeIn().slideX(),
                    
                    const SizedBox(height: 10),
                    Text(
                      'Sign in to continue',
                      style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideX(),
                    
                    const SizedBox(height: 30),
                    
                    // Email Input
                    _buildInputField(
                      controller: controller.emailController,
                      hint: 'Email',
                      icon: Icons.email_outlined,
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                    
                    const SizedBox(height: 16),
                    
                    // Password Input
                    Obx(() => _buildInputField(
                      controller: controller.passwordController,
                      hint: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      isVisible: controller.isPasswordVisible.value,
                      onVisibilityToggle: controller.togglePasswordVisibility,
                    )).animate().fadeIn(delay: 600.ms).slideY(begin: 0.2),
                    
                    const SizedBox(height: 24),
                    
                    // Login Button
                    Obx(() => Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFFF8C42), Color(0xFFFFAE6B)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF8C42).withOpacity(0.4),
                            blurRadius: 15,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: controller.isLoading.value ? null : controller.login,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Login',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    )).animate().fadeIn(delay: 800.ms).scale(),
                    
                    const SizedBox(height: 24),
                    
                    Center(
                      child: Text(
                        'Or connect with',
                        style: GoogleFonts.inter(color: Colors.white60),
                      ),
                    ).animate().fadeIn(delay: 1000.ms),
                    
                    const SizedBox(height: 16),
                    
                    // Social Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildSocialButton(Icons.g_mobiledata, 'Google', Colors.red), // Placeholder for Google Icon
                        const SizedBox(width: 16),
                        _buildSocialButton(Icons.facebook, 'Facebook', Colors.blue),
                      ],
                    ).animate().fadeIn(delay: 1200.ms),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool isVisible = false,
    VoidCallback? onVisibilityToggle,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword && !isVisible,
        style: const TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.black38),
          prefixIcon: Icon(icon, color: Colors.grey),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: onVisibilityToggle,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
  
  Widget _buildSocialButton(IconData icon, String label, Color color) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
            BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Icon(icon, color: color),
    );
  }
}
