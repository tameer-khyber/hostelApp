import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/add_property_controller.dart';

class AddPropertyView extends GetView<AddPropertyController> {
  const AddPropertyView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Property', style: GoogleFonts.poppins(color: Colors.black)),
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
          'Add Property Form Placeholder',
          style: GoogleFonts.poppins(fontSize: 20),
        ),
      ),
    );
  }
}
