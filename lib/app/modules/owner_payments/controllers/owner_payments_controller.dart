import 'package:get/get.dart';
import '../../../data/models/transaction_model.dart';
import '../../../data/services/property_service.dart';

class OwnerPaymentsController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();

  final transactions = <TransactionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    transactions.bindStream(_propertyService.transactions.stream);
    transactions.assignAll(_propertyService.transactions);
  }

  double get totalEarnings {
    // Sum of all Completed Earnings
    return transactions
        .where((t) => t.type == 'Earnings' && t.status == 'Completed')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get pendingPayments {
     // Sum of all Pending Earnings
    return transactions
        .where((t) => t.type == 'Earnings' && t.status == 'Pending')
        .fold(0.0, (sum, t) => sum + t.amount);
  }

  double get totalWithdrawn {
     // Sum of all Completed Withdrawals (amounts are negative in model for history, but here we want positive total)
    return transactions
        .where((t) => t.type == 'Withdrawal' && t.status == 'Completed')
        .fold(0.0, (sum, t) => sum + t.amount.abs());
  }
}
