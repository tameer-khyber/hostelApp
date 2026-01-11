// ignore_for_file: constant_identifier_names
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/room/bindings/room_binding.dart';
import '../modules/room/views/room_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/tenant_home/bindings/tenant_home_binding.dart';
import '../modules/tenant_home/views/tenant_home_view.dart';
import '../modules/role_selection/bindings/role_selection_binding.dart';
import '../modules/role_selection/views/role_selection_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/property_listing/bindings/property_listing_binding.dart';
import '../modules/property_listing/views/property_listing_view.dart';
import '../modules/property_detail/bindings/property_detail_binding.dart';
import '../modules/property_detail/views/property_detail_view.dart';
import '../modules/saved_properties/bindings/saved_properties_binding.dart';
import '../modules/saved_properties/views/saved_properties_view.dart';
import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/bookings_history/bindings/bookings_history_binding.dart';
import '../modules/bookings_history/views/bookings_history_view.dart';
import '../modules/payment/bindings/payment_binding.dart';
import '../modules/payment/views/payment_view.dart';
import '../modules/chat/bindings/chat_binding.dart';
import '../modules/chat/views/chat_view.dart';
import '../modules/owner_home/bindings/owner_home_binding.dart';
import '../modules/owner_home/views/owner_home_view.dart';
import '../modules/add_property/bindings/add_property_binding.dart';
import '../modules/add_property/views/add_property_view.dart';
import '../modules/scan_qr/bindings/scan_qr_binding.dart';
import '../modules/scan_qr/views/scan_qr_view.dart';
import '../modules/analytics/bindings/analytics_binding.dart';
import '../modules/analytics/views/analytics_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/notifications/bindings/notifications_binding.dart';
import '../modules/notifications/views/notifications_view.dart';
import '../modules/owner_home/views/manage_properties_view.dart';
import '../modules/owner_booking_requests/bindings/owner_booking_requests_binding.dart';
import '../modules/owner_booking_requests/views/owner_booking_requests_view.dart';
import '../modules/owner_payments/bindings/owner_payments_binding.dart';
import '../modules/owner_payments/views/owner_payments_view.dart';
import '../modules/owner_chat_list/bindings/owner_chat_list_binding.dart';
import '../modules/owner_chat_list/views/owner_chat_list_view.dart';
import '../modules/video_call/bindings/video_call_binding.dart';
import '../modules/video_call/views/video_call_view.dart';
import '../modules/owner_reviews/bindings/owner_reviews_binding.dart';
import '../modules/owner_reviews/views/owner_reviews_view.dart';
import '../modules/admin_dashboard/bindings/admin_dashboard_binding.dart';
import '../modules/admin_dashboard/views/admin_dashboard_view.dart';
import '../modules/admin_manage_users/bindings/admin_manage_users_binding.dart';
import '../modules/admin_manage_users/views/admin_manage_users_view.dart';
import '../modules/admin_manage_properties/bindings/admin_manage_properties_binding.dart';
import '../modules/admin_manage_properties/views/admin_manage_properties_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.ROLE_SELECTION,
      page: () => const RoleSelectionView(),
      binding: RoleSelectionBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ROOM_LIST,
      page: () => const RoomView(),
      binding: RoomBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.TENANT_HOME,
      page: () => const TenantHomeView(),
      binding: TenantHomeBinding(),
    ),
    GetPage(
      name: _Paths.PROPERTY_LISTING,
      page: () => const PropertyListingView(),
      binding: PropertyListingBinding(),
    ),
    GetPage(
      name: _Paths.PROPERTY_DETAIL,
      page: () => const PropertyDetailView(),
      binding: PropertyDetailBinding(),
    ),
    GetPage(
      name: _Paths.SAVED_PROPERTIES,
      page: () => const SavedPropertiesView(),
      binding: SavedPropertiesBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => const BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.BOOKINGS_HISTORY,
      page: () => const BookingsHistoryView(),
      binding: BookingsHistoryBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_HOME,
      page: () => const OwnerHomeView(),
      binding: OwnerHomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PROPERTY,
      page: () => const AddPropertyView(),
      binding: AddPropertyBinding(),
    ),
    GetPage(
      name: _Paths.SCAN_QR,
      page: () => const ScanQrView(),
      binding: ScanQrBinding(),
    ),
    GetPage(
      name: _Paths.ANALYTICS,
      page: () => const AnalyticsView(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATIONS,
      page: () => const NotificationsView(),
      binding: NotificationsBinding(),
    ),
    GetPage(
      name: _Paths.MANAGE_PROPERTIES,
      page: () => const ManagePropertiesView(),
      binding: AddPropertyBinding(), // Reusing binding as it needs similar dependencies or PropertyService
    ),
    GetPage(
      name: _Paths.OWNER_BOOKING_REQUESTS,
      page: () => const OwnerBookingRequestsView(),
      binding: OwnerBookingRequestsBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_PAYMENTS,
      page: () => const OwnerPaymentsView(),
      binding: OwnerPaymentsBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_CHAT_LIST,
      page: () => const OwnerChatListView(),
      binding: OwnerChatListBinding(),
    ),
    GetPage(
      name: _Paths.VIDEO_CALL,
      page: () => const VideoCallView(),
      binding: VideoCallBinding(),
    ),
    GetPage(
      name: _Paths.OWNER_REVIEWS,
      page: () => const OwnerReviewsView(),
      binding: OwnerReviewsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_DASHBOARD,
      page: () => const AdminDashboardView(),
      binding: AdminDashboardBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MANAGE_USERS,
      page: () => const AdminManageUsersView(),
      binding: AdminManageUsersBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_MANAGE_PROPERTIES,
      page: () => const AdminManagePropertiesView(),
      binding: AdminManagePropertiesBinding(),
    ),
  ];
}
