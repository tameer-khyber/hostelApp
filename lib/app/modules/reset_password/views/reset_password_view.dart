import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../global_widgets/glass_container.dart';
import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2C3E50)),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // 1. Background
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
          
          // 2. Animated Bokeh
          Positioned(
            top: -50,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
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

          // 3. Main Content
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock_reset_rounded, size: 70, color: Colors.teal.shade700)
                      .animate().scale(duration: const Duration(milliseconds: 500)),
                  
                  const SizedBox(height: 24),
                  
                  Text(
                    "Reset Password",
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2C3E50),
                    ),
                  ).animate().fadeIn().slideY(begin: 0.2),
                  
                  const SizedBox(height: 8),
                  
                   Padding(
                     padding: const EdgeInsets.symmetric(horizontal: 20),
                     child: Text(
                      "Create a new password for your account",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                     ).animate().fadeIn(delay: const Duration(milliseconds: 200)),
                   ),

                  const SizedBox(height: 40),

                  // Glass Form
                  GlassContainer(
                    borderRadius: BorderRadius.circular(24),
                    blur: 15,
                    opacity: 0.4,
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        Obx(() => _buildTextField(
                          controller: controller.passwordController,
                          label: "New Password",
                          icon: Icons.lock_outline_rounded,
                          isObscure: !controller.isPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey.shade600,
                            ),
                            onPressed: controller.togglePasswordVisibility,
                          ),
                        )),
                        const SizedBox(height: 16),
                        Obx(() => _buildTextField(
                          controller: controller.confirmPasswordController,
                          label: "Confirm Password",
                          icon: Icons.lock_outline_rounded,
                          isObscure: !controller.isConfirmPasswordVisible.value,
                          suffixIcon: IconButton(
                            icon: Icon(
                              controller.isConfirmPasswordVisible.value ? Icons.visibility : Icons.visibility_off,
                              color: Colors.grey.shade600,
                            ),
                            onPressed: controller.toggleConfirmPasswordVisibility,
                          ),
                        )),
                        
                        const SizedBox(height: 30),

                        // Reset Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: Obx(() => ElevatedButton(
                            onPressed: controller.isLoading.value ? null : controller.resetPassword,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.teal.shade600,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              elevation: 5,
                              shadowColor: Colors.teal.shade200,
                            ),
                            child: controller.isLoading.value 
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : Text(
                                "Reset Password",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                          )),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(delay: const Duration(milliseconds: 400)).slideY(begin: 0.1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isObscure = false,
    Widget? suffixIcon,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isObscure,
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.teal.shade400),
          suffixIcon: suffixIcon,
          labelText: label,
          labelStyle: GoogleFonts.poppins(color: Colors.grey.shade600),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
      ),
    );
  }
}
