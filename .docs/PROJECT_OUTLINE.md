# HostelApp Project Outline

> Complete project structure and file organization  
> Last Updated: 2026-01-12

---

## 📁 Root Structure

```
hostelApp/
├── .docs/                    # Team documentation
├── lib/                      # Main source code
├── android/                  # Android platform
├── ios/                      # iOS platform
├── web/                      # Web platform
├── pubspec.yaml              # Dependencies
├── README.md                 # Project readme
└── REFACTORING_CHANGELOG.md  # Code changes log
```

---

## 📂 lib/ Structure

```
lib/
├── main.dart                 # App entry point
└── app/
    ├── config/               # Configuration
    │   ├── theme/
    │   │   └── app_theme.dart
    │   └── constants/
    │       ├── app_constants.dart
    │       └── app_strings.dart
    │
    ├── core/                 # Core utilities
    │   ├── utils/
    │   │   ├── validators.dart
    │   │   └── helpers.dart
    │   └── errors/
    │       └── exceptions.dart
    │
    ├── data/                 # Data layer
    │   ├── models/           # Data models
    │   │   ├── property_model.dart
    │   │   ├── booking_model.dart
    │   │   ├── transaction_model.dart
    │   │   └── user_model.dart
    │   └── services/         # Business logic
    │       └── property_service.dart
    │
    ├── global_widgets/       # Reusable components
    │   ├── buttons/
    │   │   ├── primary_button.dart
    │   │   ├── secondary_button.dart
    │   │   └── social_button.dart
    │   ├── inputs/
    │   │   ├── app_text_field.dart
    │   │   ├── password_field.dart
    │   │   └── search_field.dart
    │   ├── cards/
    │   │   └── info_card.dart
    │   ├── layouts/
    │   │   ├── empty_state.dart
    │   │   └── loading_overlay.dart
    │   └── utils/
    │       ├── rating_stars.dart
    │       └── tag_chip.dart
    │
    ├── modules/              # Feature modules
    │   ├── splash/
    │   ├── onboarding/
    │   ├── login/
    │   ├── signup/
    │   ├── forgot_password/
    │   ├── reset_password/
    │   ├── otp/
    │   ├── tenant_home/
    │   ├── owner_home/
    │   ├── admin_home/
    │   ├── property_detail/
    │   ├── booking/
    │   ├── payment/
    │   ├── chat/
    │   ├── video_call/
    │   ├── settings/
    │   └── add_property/
    │
    └── routes/               # Navigation
        └── app_routes.dart
```

---

## 📂 .docs/ Structure

```
.docs/
├── TEAM_OVERVIEW.md          # Quick reference
├── PROJECT_STATUS.md         # Branch & completed work
├── REMAINING_TASKS.md        # Todo list
├── SUGGESTIONS.md            # Ideas
├── ANTIGRAVITY_PROMPT.md     # AI prompt for team
├── PROJECT_OUTLINE.md        # This file
└── logs/
    ├── moazzam/
    │   └── 2026-01-11.md
    └── tammer/
        └── TEMPLATE.md
```

---

## 🧩 Module Structure (Each Feature)

```
modules/[feature_name]/
├── bindings/
│   └── [feature]_binding.dart    # Dependency injection
├── controllers/
│   └── [feature]_controller.dart # Business logic
├── views/
│   └── [feature]_view.dart       # UI
└── widgets/                      # Feature-specific widgets
```

---

## 🎨 Global Widgets Quick Reference

| Widget | Path | Purpose |
|--------|------|---------|
| `PrimaryButton` | buttons/ | Main CTA button |
| `SecondaryButton` | buttons/ | Secondary action |
| `SocialButton` | buttons/ | OAuth buttons |
| `AppTextField` | inputs/ | Text input |
| `PasswordField` | inputs/ | Password input |
| `SearchField` | inputs/ | Search bar |
| `InfoCard` | cards/ | Stats display |
| `EmptyState` | layouts/ | Empty lists |
| `LoadingOverlay` | layouts/ | Loading screen |
| `RatingStars` | utils/ | Star ratings |
| `TagChip` | utils/ | Filter chips |

---

## 🔧 Key Files

| File | Purpose |
|------|---------|
| `main.dart` | App entry, theme setup |
| `app_theme.dart` | Light/dark themes |
| `app_constants.dart` | Spacing, sizing values |
| `app_strings.dart` | All text strings |
| `validators.dart` | Form validation |
| `helpers.dart` | Utility functions |
| `property_service.dart` | Data management |

---

## 👥 User Roles

1. **Tenant** - Browse, book, pay
2. **Owner** - Manage properties
3. **Admin** - Oversee all
