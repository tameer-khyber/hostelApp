import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Helper utilities for common operations
class Helpers {
  Helpers._(); // Private constructor

  /// Show success snackbar
  static void showSuccessSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green.shade700,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
    );
  }

  /// Show error snackbar
  static void showErrorSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red.shade700,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
    );
  }

  /// Show info snackbar
  static void showInfoSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue.shade700,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
    );
  }

  /// Show warning snackbar
  static void showWarningSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.orange.shade700,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      borderRadius: 10,
      margin: const EdgeInsets.all(10),
    );
  }

  /// Format currency
  static String formatCurrency(double amount, {String symbol = '\$'}) {
    final formatter = NumberFormat.currency(symbol: symbol, decimalDigits: 2);
    return formatter.format(amount);
  }

  /// Format date
  static String formatDate(DateTime date, {String format = 'MMM dd, yyyy'}) {
    final formatter = DateFormat(format);
    return formatter.format(date);
  }

  /// Format date with time
  static String formatDateTime(DateTime date, {String format = 'MMM dd, yyyy hh:mm a'}) {
    final formatter = DateFormat(format);
    return formatter.format(date);
  }

  /// Get relative time (e.g., "2 hours ago")
  static String getRelativeTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  /// Capitalize first letter
  static String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1);
  }

  /// Truncate text with ellipsis
  static String truncate(String text, int maxLength) {
    if (text.length <= maxLength) return text;
    return '${text.substring(0, maxLength)}...';
  }

  /// Check if email is valid
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Debounce function calls
  static void debounce(
    VoidCallback action, {
    Duration duration = const Duration(milliseconds: 500),
  }) {
    Future.delayed(duration, action);
  }
}
