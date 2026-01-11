import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/settings/controllers/settings_controller.dart';
import 'glass_container.dart';

class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.find<SettingsController>();

    return Obx(() {
      final isDark = controller.isDarkMode.value;
      return GestureDetector(
        onTap: () => controller.toggleTheme(!isDark),
        child: GlassContainer(
          borderRadius: BorderRadius.circular(50),
          blur: 10,
          opacity: 0.3,
          padding: const EdgeInsets.all(8),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (child, anim) => RotationTransition(turns: anim, child: child),
            child: Icon(
              isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
              key: ValueKey(isDark),
              color: isDark ? Colors.amber : const Color(0xFF2C3E50),
              size: 24,
            ),
          ),
        ),
      );
    });
  }
}
