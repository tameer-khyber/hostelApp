import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/scan_qr_controller.dart';

class ScanQrView extends GetView<ScanQrController> {
  const ScanQrView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Scan Property QR', style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.back(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.flash_on, color: Colors.white),
            onPressed: () => controller.cameraController.toggleTorch(),
          ),
          IconButton(
            icon: const Icon(Icons.cameraswitch, color: Colors.white),
            onPressed: () => controller.cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller.cameraController,
            onDetect: controller.onDetect,
          ),
          // Overlay
          Positioned.fill(
             child: Container(
               decoration: ShapeDecoration(
                 shape: QrScannerOverlayShape(
                   borderColor: Colors.teal,
                   borderRadius: 20,
                   borderLength: 30,
                   borderWidth: 10,
                   cutOutSize: 300,
                 ),
               ),
             ),
          ),
          // Instructions
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  "Align QR code within the frame",
                  style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
                ),
              ),
            ),
          ).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }
}

class QrScannerOverlayShape extends ShapeBorder {
  final Color borderColor;
  final double borderRadius;
  final double borderLength;
  final double borderWidth;
  final double cutOutSize;

  QrScannerOverlayShape({
    this.borderColor = Colors.red,
    this.borderRadius = 10,
    this.borderLength = 20,
    this.borderWidth = 10,
    this.cutOutSize = 250,
  });

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.zero;

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    return Path()
      ..fillType = PathFillType.evenOdd
      ..addPath(getOuterPath(rect), Offset.zero);
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    Path getLeftTopPath(Rect rect) {
      return Path()
        ..moveTo(rect.left, rect.bottom)
        ..lineTo(rect.left, rect.top)
        ..lineTo(rect.right, rect.top);
    }
    return getLeftTopPath(rect);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
      final width = rect.width;
      final height = rect.height;
      final cutOutHeight = cutOutSize;
      final cutOutWidth = cutOutSize;
      
      final backgroundPaint = Paint()
        ..color = Colors.black54
        ..style = PaintingStyle.fill;
        
      final borderPaint = Paint()
        ..color = borderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = borderWidth;

      final boxRect = Rect.fromCenter(center: rect.center, width: cutOutWidth, height: cutOutHeight);
      
      canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()..addRect(rect),
          Path()
            ..addRRect(RRect.fromRectAndRadius(boxRect, Radius.circular(borderRadius)))
            ..close(),
        ),
        backgroundPaint,
      );

      // Draw corners
      // Top Left
      canvas.drawPath(
        Path()
          ..moveTo(boxRect.left, boxRect.top + borderLength)
          ..lineTo(boxRect.left, boxRect.top)
          ..lineTo(boxRect.left + borderLength, boxRect.top),
        borderPaint,
      );
      // Top Right
      canvas.drawPath(
        Path()
          ..moveTo(boxRect.right - borderLength, boxRect.top)
          ..lineTo(boxRect.right, boxRect.top)
          ..lineTo(boxRect.right, boxRect.top + borderLength),
        borderPaint,
      );
      // Bottom Right
      canvas.drawPath(
        Path()
          ..moveTo(boxRect.right, boxRect.bottom - borderLength)
          ..lineTo(boxRect.right, boxRect.bottom)
          ..lineTo(boxRect.right - borderLength, boxRect.bottom),
        borderPaint,
      );
      // Bottom Left
      canvas.drawPath(
        Path()
          ..moveTo(boxRect.left + borderLength, boxRect.bottom)
          ..lineTo(boxRect.left, boxRect.bottom)
          ..lineTo(boxRect.left, boxRect.bottom - borderLength),
        borderPaint,
      );
  }

  @override
  ShapeBorder scale(double t) {
    return QrScannerOverlayShape(
      borderColor: borderColor,
      borderRadius: borderRadius,
      borderLength: borderLength,
      borderWidth: borderWidth,
      cutOutSize: cutOutSize,
    );
  }
}
