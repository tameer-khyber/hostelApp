import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../data/services/property_service.dart';

class ScanQrController extends GetxController {
  final MobileScannerController cameraController = MobileScannerController();
  final PropertyService _propertyService = Get.find<PropertyService>();
  
  // Prevent duplicate detections
  var isScanning = true;

  void onDetect(BarcodeCapture capture) {
    if (!isScanning) return;
    
    final List<Barcode> barcodes = capture.barcodes;
    for (final barcode in barcodes) {
      if (barcode.rawValue != null) {
        final String code = barcode.rawValue!;
        
        // Basic validation or ID detection
        isScanning = false;
        _handleQrFound(code);
        break; // Process only first valid code
      }
    }
  }

  void _handleQrFound(String code) {
    // Check if property exists by ID
    final property = _propertyService.allProperties.firstWhereOrNull((p) => p.id == code);
    
    // Also check by Name for flexibility (since we are mocking IDs and existing properties might have different logic if not fully migrated)
    // Actually, only ID match is consistent with request "unique".
    
    if (property != null) {
       Get.snackbar(
          "Property Found!", 
          "Detected: ${property.name}",
          backgroundColor: Colors.teal,
          colorText: Colors.white,
          duration: const Duration(seconds: 2),
       );
       
       Future.delayed(const Duration(seconds: 1), () {
          Get.toNamed('/property-detail', arguments: property)?.then((_) => isScanning = true);
       });
       
    } else {
       Get.snackbar(
          "Unknown QR", 
          "This QR code ($code) does not match any listed property.",
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
       );
       // Resume scanning after delay
       Future.delayed(const Duration(seconds: 3), () {
         isScanning = true;
       });
    }
  }

  @override
  void onClose() {
    cameraController.dispose();
    super.onClose();
  }
}
