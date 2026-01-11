import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/scan_qr_controller.dart';

class ScanQrView extends GetView<ScanQrController> {
  const ScanQrView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR', style: GoogleFonts.poppins(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Tooltip(
            message: "Back",
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Get.back(),
            ),
        ),
      ),
      body: Center(
        child: Text(
          'QR Scanner Placeholder',
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ),
    );
  }
}
