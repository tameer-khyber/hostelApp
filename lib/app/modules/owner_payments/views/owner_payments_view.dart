import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import '../../../global_widgets/glass_container.dart';
import '../controllers/owner_payments_controller.dart';
import '../../../data/models/transaction_model.dart';

class OwnerPaymentsView extends GetView<OwnerPaymentsController> {
  const OwnerPaymentsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          "Earnings & Payments",
          style: GoogleFonts.poppins(
            color: theme.textTheme.bodyLarge?.color,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: theme.iconTheme.color),
          onPressed: () => Get.back(),
        ),
      ),
      body: Stack(
        children: [
          // Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [const Color(0xFF1A1A2E), const Color(0xFF16213E), const Color(0xFF0F3460)]
                    : [const Color(0xFFE0F7FA), const Color(0xFFE8EAF6), const Color(0xFFF3E5F5)],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Overview Cards
                  _buildOverviewSection(context),

                  const SizedBox(height: 30),

                  // 2. Transaction History Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Transaction History",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: theme.textTheme.bodyLarge?.color,
                        ),
                      ),
                      IconButton(
                        onPressed: () {}, // Filter action could go here
                        icon: Icon(Icons.filter_list_rounded, color: isDark ? Colors.grey[400] : Colors.grey[600]),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 3. Transactions List
                  Obx(() {
                    if (controller.transactions.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text("No transactions yet", style: GoogleFonts.poppins(color: Colors.grey)),
                        ),
                      );
                    }
                    return ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.transactions.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return _buildTransactionCard(context, controller.transactions[index], index);
                      },
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Obx(() => _buildStatCard(
                context,
                "Total Earnings",
                "\$${controller.totalEarnings.toStringAsFixed(2)}",
                Icons.account_balance_wallet_rounded,
                Colors.teal,
              )),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Obx(() => _buildStatCard(
                context,
                "Pending",
                "\$${controller.pendingPayments.toStringAsFixed(2)}",
                Icons.hourglass_top_rounded,
                Colors.orangeAccent,
              )),
            ),
          ],
        ),
        const SizedBox(height: 16),
         Obx(() => _buildStatCard(
          context,
          "Total Withdrawn",
          "\$${controller.totalWithdrawn.toStringAsFixed(2)}",
          Icons.outbond_rounded,
          Colors.blueAccent,
          isFullWidth: true,
        )),
      ],
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color, {bool isFullWidth = false}) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GlassContainer(
      borderRadius: BorderRadius.circular(20),
      blur: 10,
      opacity: isDark ? 0.3 : 0.6,
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 20),
              ),
              if (isFullWidth)
                 Container(
                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                   decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), borderRadius: BorderRadius.circular(20)),
                   child: Text("Tap to withdraw", style: GoogleFonts.poppins(fontSize: 10, color:  theme.textTheme.bodySmall?.color)),
                 )
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1);
  }

  Widget _buildTransactionCard(BuildContext context, TransactionModel trx, int index) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isEarnings = trx.type == 'Earnings';
    final isNegative = trx.amount < 0 || trx.type == 'Withdrawal';

    return GlassContainer(
      borderRadius: BorderRadius.circular(16),
      blur: 5,
      opacity: isDark ? 0.2 : 0.5,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isEarnings 
                  ? Colors.green.withOpacity(0.1) 
                  : Colors.redAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              isEarnings ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
              color: isEarnings ? Colors.green : Colors.redAccent,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  trx.title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
                Text(
                  DateFormat('MMM dd, yyyy • hh:mm a').format(trx.date),
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${isNegative ? '-' : '+'}\$${trx.amount.abs().toStringAsFixed(0)}",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isEarnings ? Colors.green : Colors.redAccent,
                ),
              ),
              Container(
                 padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                 decoration: BoxDecoration(
                   color: _getStatusColor(trx.status).withOpacity(0.1),
                   borderRadius: BorderRadius.circular(4),
                 ),
                 child: Text(
                   trx.status,
                   style: GoogleFonts.poppins(fontSize: 10, color: _getStatusColor(trx.status)),
                 ),
              )
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: (50 * index).ms).slideX(begin: 0.1);
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed': return Colors.green;
      case 'Pending': return Colors.orange;
      case 'Failed': return Colors.red;
      default: return Colors.grey;
    }
  }
}
