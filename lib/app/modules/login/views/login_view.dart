import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart'; // Re-attempting usage, will fallback if crash
import 'package:flutter_animate/flutter_animate.dart';

import '../../../global_widgets/glass_container.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine screen size for responsive layout
    final size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true, // Allow body to extend behind bottom nav
      body: Stack(
        children: [
          // 1. Background (Light Blue/Cyan Gradient)
          Positioned.fill(
            child: Container(
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
          ),
          
          // 2. Decorative Background Circles (Bokeh Effect)
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
            bottom: 100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.blueAccent.withOpacity(0.2),
                    Colors.blueAccent.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // 3. Main Content Area
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24), // Removed large bottom padding
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GlassContainer(
                  borderRadius: BorderRadius.circular(30),
                  blur: 20,
                  opacity: 0.4, // Milkier glass
                  border: Border.all(color: Colors.white.withOpacity(0.6), width: 1.5),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo & Title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.home_work_rounded, color: Colors.teal.shade400, size: 32),
                          const SizedBox(width: 8),
                          Text(
                            'HostelApp',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2C3E50),
                            ),
                          ),
                        ],
                      ).animate().fadeIn().slideY(begin: -0.2),

                      const SizedBox(height: 30),

                      Text(
                        'Welcome Back',
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF34495E),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Login to your account',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Email Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Email", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: const Color(0xFF37474F))),
                      ),
                      const SizedBox(height: 8),
                      _buildModernInput(
                        controller: controller.emailController,
                        hint: 'Enter your email',
                        icon: Icons.email_outlined,
                      ),

                      const SizedBox(height: 20),

                      // Password Field
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Password", style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: const Color(0xFF37474F))),
                      ),
                      const SizedBox(height: 8),
                      Obx(() => _buildModernInput(
                        controller: controller.passwordController,
                        hint: 'Enter your password',
                        icon: Icons.lock_outline,
                        isPassword: true,
                        isVisible: controller.isPasswordVisible.value,
                        onVisibilityToggle: controller.togglePasswordVisibility,
                      )),

                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
                          child: Text(
                            "Forgot password?",
                            style: GoogleFonts.poppins(
                              color: Colors.teal.shade600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Main Login Button
                      _buildGradientButton(
                        text: "Log In",
                        onPressed: controller.login,
                        isLoading: controller.isLoading.value,
                      ),

                      const SizedBox(height: 25),
                      
                      Row(
                        children: [
                          Expanded(child: Divider(color: Colors.grey.shade400)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text("or", style: TextStyle(color: Colors.grey.shade600)),
                          ),
                          Expanded(child: Divider(color: Colors.grey.shade400)),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // Social Buttons
                      _buildSocialButtonFull(
                        text: "Continue with Google",
                        icon: Icons.g_mobiledata_rounded, // Using built-in icon as placeholder
                        color: Colors.redAccent,
                        textColor: const Color(0xFF37474F),
                        iconColor: Colors.red,
                      ),
                      const SizedBox(height: 15),
                      _buildSocialButtonFull(
                        text: "Continue with Facebook",
                        icon: Icons.facebook,
                        color: const Color(0xFF1877F2),
                        textColor: Colors.white,
                        iconColor: Colors.white,
                        backgroundColor: const Color(0xFF1877F2), // Blue Background
                      ),
                      
                      const SizedBox(height: 30),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account? ", style: GoogleFonts.poppins(color: Colors.grey.shade700)),
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.SIGNUP),
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.poppins(
                                color: Colors.teal.shade600,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernInput({
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
        borderRadius: BorderRadius.circular(12),
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
        style: GoogleFonts.poppins(color: Colors.black87),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.grey.shade400),
          prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 22),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isVisible ? Icons.visibility : Icons.visibility_off,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                  onPressed: onVisibilityToggle,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }

  Widget _buildGradientButton({required String text, required VoidCallback onPressed, required bool isLoading}) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8A65), Color(0xFFFFB74D)], // Peach/Orange Gradient
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF8A65).withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: MaterialButton(
        onPressed: isLoading ? null : onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: isLoading
            ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
            : Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildSocialButtonFull({
    required String text,
    required IconData icon,
    required Color color,
    required Color textColor,
    Color? backgroundColor,
    Color? iconColor,
  }) {
    return Container(
      width: double.infinity,
      height: 55,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: backgroundColor == null ? Border.all(color: Colors.grey.shade200) : null,
      ),
      child: MaterialButton(
        onPressed: () {},
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: iconColor ?? color, size: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
