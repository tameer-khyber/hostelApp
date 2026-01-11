/// Application-wide string constants
class AppStrings {
  AppStrings._(); // Private constructor to prevent instantiation

  // ==================== APP INFO ====================
  static const String appName = 'HostelApp';
  static const String appTagline = 'Find Your Perfect Stay';

  // ==================== AUTH SCREENS ====================
  static const String welcomeBack = 'Welcome Back';
  static const String loginSubtitle = 'Login to your account';
  static const String createAccount = 'Create Account';
  static const String signupSubtitle = 'Sign up to get started';
  static const String forgotPassword = 'Forgot password?';
  static const String dontHaveAccount = "Don't have an account? ";
  static const String alreadyHaveAccount = 'Already have an account? ';
  static const String signUp = 'Sign Up';
  static const String login = 'Log In';
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithFacebook = 'Continue with Facebook';
  static const String or = 'or';

  // ==================== FORM LABELS ====================
  static const String email = 'Email';
  static const String password = 'Password';
  static const String confirmPassword = 'Confirm Password';
  static const String fullName = 'Full Name';
  static const String phoneNumber = 'Phone Number';

  // ==================== PLACEHOLDERS ====================
  static const String enterEmail = 'Enter your email';
  static const String enterPassword = 'Enter your password';
  static const String enterFullName = 'Enter your full name';
  static const String enterPhoneNumber = 'Enter your phone number';
  static const String searchProperties = 'Search properties...';

  // ==================== VALIDATION MESSAGES ====================
  static const String emailRequired = 'Email is required';
  static const String emailInvalid = 'Please enter a valid email';
  static const String passwordRequired = 'Password is required';
  static const String passwordTooShort = 'Password must be at least 6 characters';
  static const String passwordsNoMatch = 'Passwords do not match';
  static const String nameRequired = 'Name is required';
  static const String phoneRequired = 'Phone number is required';

  // ==================== ERROR MESSAGES ====================
  static const String networkError = 'No internet connection';
  static const String serverError = 'Something went wrong. Please try again';
  static const String unknownError = 'An unknown error occurred';

  // ==================== SUCCESS MESSAGES ====================
  static const String loginSuccess = 'Login successful!';
  static const String signupSuccess = 'Account created successfully!';
  static const String bookingSuccess = 'Booking confirmed!';
  static const String profileUpdated = 'Profile updated successfully';

  // ==================== COMMON ====================
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String cancel = 'Cancel';
  static const String done = 'Done';
  static const String save = 'Save';
  static const String delete = 'Delete';
  static const String edit = 'Edit';
  static const String search = 'Search';
  static const String filter = 'Filter';
  static const String apply = 'Apply';
  static const String reset = 'Reset';
  static const String loading = 'Loading...';
  static const String noDataFound = 'No data found';
  static const String somethingWentWrong = 'Something went wrong';

  // ==================== PROPERTY ====================
  static const String properties = 'Properties';
  static const String propertyDetails = 'Property Details';
  static const String amenities = 'Amenities';
  static const String reviews = 'Reviews';
  static const String bookNow = 'Book Now';
  static const String viewDetails = 'View Details';

  // ==================== BOOKING ====================
  static const String myBookings = 'My Bookings';
  static const String bookingDetails = 'Booking Details';
  static const String checkIn = 'Check-in';
  static const String checkOut = 'Check-out';
  static const String guests = 'Guests';

  // ==================== SETTINGS ====================
  static const String settings = 'Settings';
  static const String profile = 'Profile';
  static const String darkMode = 'Dark Mode';
  static const String notifications = 'Notifications';
  static const String logout = 'Logout';
  static const String changePassword = 'Change Password';

  // ==================== EMPTY STATES ====================
  static const String noPropertiesFound = 'No properties found';
  static const String noBookingsYet = 'No bookings yet';
  static const String noFavoritesYet = 'No favorites yet';
  static const String startExploring = 'Start exploring properties near you';
}
