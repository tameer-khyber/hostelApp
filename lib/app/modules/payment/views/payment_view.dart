import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("Payment", style: GoogleFonts.poppins(color: const Color(0xFF2C3E50), fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.white.withOpacity(0.5),
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Color(0xFF2C3E50), size: 18),
                onPressed: () => Get.back(),
              ),
            ),
          ),
      ),
      body: Stack(
        children: [
            // Background
           Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Color(0xFFE0F7FA), Color(0xFFE8EAF6)],
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Amount Summary
                  Center(
                    child: GlassContainer(
                      borderRadius: BorderRadius.circular(25),
                      opacity: 0.6,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                      child: Column(
                        children: [
                          Text("Total Payable", style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 14)),
                          const SizedBox(height: 8),
                          Text("\$${controller.booking.totalAmount}", style: GoogleFonts.poppins(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.teal)),
                        ],
                      ),
                    ),
                  ).animate().scale(delay: 200.ms),

                  const SizedBox(height: 40),

                  Text("Select Payment Method", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF2C3E50))),
                  const SizedBox(height: 16),

                  // Methods List
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: Obx(() => Column(
                      children: controller.paymentMethods.map((method) {
                        final isSelected = controller.selectedMethod.value == method;
                        return InkWell(
                          onTap: () => controller.selectMethod(method),
                          child: AnimatedContainer(
                            duration: 300.ms,
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.teal.withOpacity(0.1) : Colors.transparent,
                              borderRadius: BorderRadius.circular(15),
                              border: isSelected ? Border.all(color: Colors.teal) : Border.all(color: Colors.transparent),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  method.contains("Card") ? Icons.credit_card_rounded :
                                  method.contains("UPI") ? Icons.account_balance_wallet_rounded : Icons.money_rounded,
                                  color: isSelected ? Colors.teal : Colors.grey[600]
                                ),
                                const SizedBox(width: 16),
                                Text(method, style: GoogleFonts.poppins(
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                  color: const Color(0xFF2C3E50)
                                )),
                                const Spacer(),
                                if (isSelected)
                                  const Icon(Icons.check_circle_rounded, color: Colors.teal)
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )),
                  ).animate().slideY(begin: 0.2, delay: 300.ms),

                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),

          // Pay Button
           Align(
            alignment: Alignment.bottomCenter,
            child: GlassContainer(
               borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
               blur: 20,
               opacity: 0.9,
               padding: const EdgeInsets.all(24),
               child: SizedBox(
                 width: double.infinity,
                 child: Obx(() => ElevatedButton(
                   onPressed: controller.isProcessing.value ? null : () => controller.processPayment(),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.teal,
                     padding: const EdgeInsets.symmetric(vertical: 16),
                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                     elevation: 5,
                   ),
                   child: controller.isProcessing.value 
                     ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                     : Text("Pay Now", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                 )),
               ),
            ),
          ).animate().slideY(begin: 1),
        ],
      ),
    );
  }
}
