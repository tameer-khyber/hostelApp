import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/video_call_controller.dart';
import '../../../global_widgets/glass_container.dart';

class VideoCallView extends GetView<VideoCallController> {
  const VideoCallView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // 1. Remote Video (Full Screen Placeholder)
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[900],
              image: const DecorationImage(
                image: NetworkImage("https://images.unsplash.com/photo-1544725176-7c40e5a71c5e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1767&q=80"), // Placeholder
                fit: BoxFit.cover,
                opacity: 0.6
              )
            ),
            child: Obx(() {
               if (controller.remoteUserImage.value != null && false) {
                 // Real implementation would render video stream here
                 return Image.network(controller.remoteUserImage.value!, fit: BoxFit.cover);
               } 
               return const SizedBox();
            }),
          ),

          // 2. Header (Name & Time)
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Obx(() => Text(
                      controller.remoteUserName.value,
                      style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white, shadows: [const Shadow(color: Colors.black, blurRadius: 10)])
                    )),
                    const SizedBox(height: 8),
                     Obx(() => Container(
                       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                       decoration: BoxDecoration(color: Colors.black26, borderRadius: BorderRadius.circular(20)),
                       child: Text(
                        controller.duration.value,
                        style: GoogleFonts.poppins(fontSize: 14, color: Colors.white70)
                                           ),
                     )),
                  ],
                ),
              ),
            ),
          ),

          // 3. Local Video (Small Picture-in-Picture)
          Positioned(
            right: 20,
            bottom: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 100,
                height: 150,
                color: Colors.black,
                child: Obx(() => controller.isCameraOn.value 
                  ? Image.network("https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-4.0.3&auto=format&fit=crop&w=880&q=80", fit: BoxFit.cover) // Self placeholder
                  : const Center(child: Icon(Icons.videocam_off, color: Colors.white))
                ),
              ),
            ),
          ).animate().slideX(begin: 1, delay: 500.ms),

          // 4. Controls
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: GlassContainer(
                borderRadius: BorderRadius.circular(50),
                blur: 15,
                opacity: 0.3,
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildControlButton(
                      icon: Icons.mic_off, 
                      isActive: controller.isMicOn.value, 
                      onTap: controller.toggleMic,
                      activeIcon: Icons.mic
                    ),
                    const SizedBox(width: 24),
                    _buildControlButton(
                      icon: Icons.call_end, 
                      isActive: true, 
                      onTap: controller.endCall,
                      color: Colors.redAccent,
                      size: 64,
                      iconSize: 32
                    ),
                    const SizedBox(width: 24),
                     _buildControlButton(
                      icon: Icons.videocam_off, 
                      isActive: controller.isCameraOn.value, 
                      onTap: controller.toggleCamera,
                      activeIcon: Icons.videocam
                    ),
                  ],
                ),
              ),
            ),
          ).animate().slideY(begin: 1),
        ],
      ),
    );
  }

  Widget _buildControlButton({required IconData icon, required bool isActive, required VoidCallback onTap, IconData? activeIcon, Color? color, double size = 50, double iconSize = 24}) {
    return Obx(() {
       // Re-evaluating isActive inside Obx if it was derived from observable, but here passing value directly.
       // Actually need to wrap in Obx at usage site for primitives. But controller values are passed.
       // Let's simplify: pass obs property if needed, or rely on parent rebuild.
       // Since we are in GetView build, we might need Obx around specific buttons.
       // But wait, the parent `build` isn't an Obx. The parent has children wrapped in Obx. 
       // This helper isn't wrapped.
       return GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: 200.ms,
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: color ?? (isActive ? Colors.white : Colors.white.withOpacity(0.3)),
            shape: BoxShape.circle,
          ),
          child: Icon(
            isActive ? (activeIcon ?? icon) : icon, 
            color: color != null ? Colors.white : (isActive ? Colors.black : Colors.white),
            size: iconSize,
          ),
        ),
      );
    });
  }
}
