# Remaining Tasks

> Last Updated: 2026-01-12

---

## 🔴 High Priority

### View Refactoring (Follow login_view.dart pattern)

- [ ] `signup_view.dart` - Use PrimaryButton, AppTextField, PasswordField
- [ ] `forgot_password_view.dart` - Use global widgets
- [ ] `reset_password_view.dart` - Use global widgets
- [ ] `otp_view.dart` - Use global widgets

### Backend Integration

- [ ] Set up Firebase project
- [ ] Configure Firestore database
- [ ] Implement authentication service
- [ ] Replace mock data with real data

---

## 🟡 Medium Priority

### More View Refactoring

- [ ] `tenant_home_view.dart` - Use SearchField, TagChip
- [ ] `property_detail_view.dart` - Use RatingStars, PrimaryButton
- [ ] `booking_view.dart` - Use global widgets
- [ ] `payment_view.dart` - Use global widgets
- [ ] `owner_home_view.dart` - Use InfoCard
- [ ] `add_property_view.dart` - Use AppTextField
- [ ] `settings_view.dart` - Use global widgets

### Create Additional Widgets

- [ ] `DropdownField` - Consistent dropdown styling
- [ ] `DatePickerField` - Date input with calendar
- [ ] `PropertyCard` - Standardized property card
- [ ] `BookingCard` - Booking display card

---

## 🟢 Low Priority (Nice to Have)

### Code Quality

- [ ] Add unit tests for validators
- [ ] Add widget tests for global widgets
- [ ] Fix deprecated `withOpacity` warnings (~200 instances)
- [ ] Add `super.key` to all widgets

### Documentation

- [ ] Add inline documentation to all widgets
- [ ] Create widget catalog/storybook
- [ ] Add example usage in each widget file

### Super Admin Panel

- [ ] Set up Next.js project for super admin
- [ ] Design admin dashboard UI
- [ ] Implement analytics views

---

## 📊 Task Distribution Suggestion

| Developer | Suggested Focus |
|-----------|-----------------|
| Moazzam | Backend integration, Firebase setup |
| Tammer | View refactoring (signup, forgot password, etc.) |

---

## 🎯 Recommended Next Steps

1. **Merge `feature/code-refactoring` to `main`**
2. **Tammer:** Start refactoring `signup_view.dart`
3. **Moazzam:** Set up Firebase project
4. **Both:** Test app on devices regularly
