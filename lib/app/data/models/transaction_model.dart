class TransactionModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final String status; // 'Completed', 'Pending', 'Failed'
  final String type; // 'Earnings', 'Withdrawal'
  final String? bookingId;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.date,
    required this.status,
    required this.type,
    this.bookingId,
  });
}
