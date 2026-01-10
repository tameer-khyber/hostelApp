import 'package:get/get.dart';
import '../../../data/services/property_service.dart';
import '../../../data/models/booking_model.dart';

class BookingsHistoryController extends GetxController {
  final PropertyService _propertyService = Get.find<PropertyService>();
  
  final currentSort = "Newest".obs;
  final sortOptions = ["Newest", "Oldest", "Price: High to Low", "Price: Low to High"];

  List<BookingModel> _sortList(List<BookingModel> list) {
    switch (currentSort.value) {
      case "Newest":
        list.sort((a, b) => b.bookingDate.compareTo(a.bookingDate));
        break;
      case "Oldest":
        list.sort((a, b) => a.bookingDate.compareTo(b.bookingDate));
        break;
      case "Price: High to Low":
        list.sort((a, b) => b.totalAmount.compareTo(a.totalAmount));
        break;
      case "Price: Low to High":
        list.sort((a, b) => a.totalAmount.compareTo(b.totalAmount));
        break;
    }
    return list;
  }

  List<BookingModel> get activeBookings {
    final now = DateTime.now();
    final list = _propertyService.myBookings.where((b) {
      // Active if end date is in future OR status is Confirmed/Pending (and not cancelled)
      // Simplifying: if status is not Cancelled AND end date >= today (ignoring time)
      final endDate = b.dateRange.end;
      final isFuture = endDate.isAfter(now.subtract(const Duration(days: 1))); 
      return (b.status == 'Confirmed' || b.status == 'Pending') && isFuture;
    }).toList();
    return _sortList(list);
  }

  List<BookingModel> get pastBookings {
    final now = DateTime.now();
    final list = _propertyService.myBookings.where((b) {
      final endDate = b.dateRange.end;
      final isPast = endDate.isBefore(now.subtract(const Duration(days: 1)));
      return b.status == 'Cancelled' || isPast;
    }).toList();
    return _sortList(list);
  }

  void setSort(String sort) {
    currentSort.value = sort;
  }
}
