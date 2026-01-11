import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:flutter_animate/flutter_animate.dart';

import '../../../global_widgets/glass_container.dart';
import '../../../global_widgets/theme_toggle_button.dart';
import '../../../global_widgets/buttons/primary_button.dart';
import '../../../global_widgets/buttons/social_button.dart';
import '../../../global_widgets/inputs/app_text_field.dart';
import '../../../global_widgets/inputs/password_field.dart';
import '../../../config/constants/app_strings.dart';
import '../../../config/constants/app_constants.dart';
import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, 
      body: Stack(
        children: [
          // 1. Background (Theme Aware)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: Theme.of(context).brightness == Brightness.dark
                    ? [const Color(0xFF1A1A2E), const Color(0xFF16213E), const Color(0xFF0F3460)]
                    : [const Color(0xFFE0F7FA), const Color(0xFFE1F5FE), const Color(0xFFB3E5FC), const Color(0xFF81D4FA)],
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
                    Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.05) : Colors.white.withOpacity(0.4),
                    Colors.transparent,
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
                    Theme.of(context).brightness == Brightness.dark ? Colors.blueAccent.withOpacity(0.1) : Colors.blueAccent.withOpacity(0.2),
                    Colors.blueAccent.withOpacity(0.0),
                  ],
                ),
              ),
            ),
          ),

          // 3. Main Content Area
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    // Theme Toggle Button
                    Align(
                      alignment: Alignment.topRight,
                      child: const ThemeToggleButton(),
                    ),
                    const SizedBox(height: 20),
                    
                    GlassContainer(
                      borderRadius: BorderRadius.circular(30),
                      blur: 20,
                      opacity: Theme.of(context).brightness == Brightness.dark ? 0.6 : 0.4, 
                      border: Border.all(
                        color: Theme.of(context).brightness == Brightness.dark ? Colors.white.withOpacity(0.1) : Colors.white.withOpacity(0.6), 
                        width: 1.5
                      ),
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
                                  color: Theme.of(context).textTheme.bodyLarge?.color,
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
                              color: Theme.of(context).textTheme.bodyLarge?.color,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Login to your account',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Theme.of(context).textTheme.bodyMedium?.color,
                            ),
                          ),
    
                          const SizedBox(height: 40),
    
                          // Email Field
                          AppTextField(
                            controller: controller.emailController,
                            hintText: AppStrings.enterEmail,
                            labelText: AppStrings.email,
                            prefixIcon: Icons.email_outlined,
                            keyboardType: TextInputType.emailAddress,
                          ),
    
                          const SizedBox(height: 20),
    
                          // Password Field
                          PasswordField(
                            controller: controller.passwordController,
                            labelText: AppStrings.password,
                            hintText: AppStrings.enterPassword,
                          ),
    
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
                          Obx(() => PrimaryButton(
                            text: AppStrings.login,
                            onPressed: controller.login,
                            isLoading: controller.isLoading.value,
                          )),
    
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
                          SocialButton(
                            text: AppStrings.continueWithGoogle,
                            icon: Icons.g_mobiledata_rounded,
                            iconColor: Colors.red,
                            onPressed: () {},
                          ),
                          const SizedBox(height: AppConstants.spacingM),
                          SocialButton(
                            text: AppStrings.continueWithFacebook,
                            icon: Icons.facebook,
                            iconColor: Colors.white,
                            backgroundColor: const Color(0xFF1877F2),
                            textColor: Colors.white,
                            onPressed: () {},
                          ),
                          
                          const SizedBox(height: 30),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have an account? ", style: GoogleFonts.poppins(color: Theme.of(context).textTheme.bodyMedium?.color)),
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

