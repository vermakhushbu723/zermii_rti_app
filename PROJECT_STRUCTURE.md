# Zermii RTI - Your Complete Interior Design Solution
## Complete Project Structure & Documentation

### 📱 App Overview
Zermii RTI is a comprehensive multi-user Flutter application for interior design, construction, real estate services with **Sky Blue Theme**.

### 🎨 Color Theme
- **Primary Background**: Sky Blue (`#E0F6FF`)
- **Primary Color**: Sky Blue (`#87CEEB`)
- **Accent**: Deep Sky Blue (`#00BFFF`)
- **Text**: Dark for contrast on sky blue background
- **Buttons**: Sky blue with white text

---

## 📂 Complete Folder Structure

```
rti_app/
├── lib/
│   ├── main.dart                          # App entry point
│   │
│   ├── config/                            # Core configuration
│   │   ├── app_colors.dart               # Sky blue color palette
│   │   ├── app_theme.dart                # Material theme config
│   │   ├── app_routes.dart               # All route paths
│   │   ├── app_constants.dart            # App constants
│   │   └── route_generator.dart          # Route management
│   │
│   ├── screens/                           # All app screens (94 screens)
│   │   │
│   │   ├── auth/                         # ✅ Authentication Module (6 screens)
│   │   │   ├── splash_screen.dart
│   │   │   ├── get_started_screen.dart
│   │   │   ├── select_user_type_screen.dart
│   │   │   ├── login_screen.dart
│   │   │   ├── otp_verification_screen.dart
│   │   │   └── forgot_password_screen.dart
│   │   │
│   │   ├── customer/                     # 🟦 Customer Module (24 screens)
│   │   │   ├── customer_dashboard.dart
│   │   │   │
│   │   │   ├── online_design/
│   │   │   │   ├── online_design_home.dart
│   │   │   │   ├── designer_list.dart
│   │   │   │   ├── designer_details.dart
│   │   │   │   ├── online_design_form.dart
│   │   │   │   ├── appointment_calendar.dart
│   │   │   │   ├── video_chat_screen.dart
│   │   │   │   ├── make_plan_screen.dart
│   │   │   │   └── make_3d_plan_screen.dart
│   │   │   │
│   │   │   ├── dealer/
│   │   │   │   ├── nearest_dealer_list.dart
│   │   │   │   └── dealer_details.dart
│   │   │   │
│   │   │   ├── booking/
│   │   │   │   ├── slot_booking.dart
│   │   │   │   ├── site_visit_booking.dart
│   │   │   │   └── installation_booking.dart
│   │   │   │
│   │   │   ├── progress/
│   │   │   │   ├── work_progress_dashboard.dart
│   │   │   │   ├── design_progress.dart
│   │   │   │   ├── design_3d_progress.dart
│   │   │   │   ├── material_progress.dart
│   │   │   │   └── furniture_progress.dart
│   │   │   │
│   │   │   └── downloads/
│   │   │       ├── downloads_home.dart
│   │   │       ├── design_files.dart
│   │   │       ├── booking_files.dart
│   │   │       ├── furniture_list.dart
│   │   │       └── billing_downloads.dart
│   │   │
│   │   ├── agent/                        # 🟩 Agent Module (22 screens)
│   │   │   ├── agent_dashboard.dart
│   │   │   │
│   │   │   ├── online_design/
│   │   │   │   ├── agent_designer_list.dart
│   │   │   │   ├── agent_designer_details.dart
│   │   │   │   ├── agent_design_form.dart
│   │   │   │   ├── agent_appointment.dart
│   │   │   │   ├── agent_video_chat.dart
│   │   │   │   ├── agent_make_plan.dart
│   │   │   │   └── agent_make_3d_plan.dart
│   │   │   │
│   │   │   ├── land/
│   │   │   │   ├── upload_land.dart
│   │   │   │   ├── uploaded_lands_list.dart
│   │   │   │   ├── company_land_slots.dart
│   │   │   │   └── slot_details.dart
│   │   │   │
│   │   │   ├── work/
│   │   │   │   ├── agent_work_progress.dart
│   │   │   │   └── agent_chat.dart
│   │   │   │
│   │   │   ├── finance/
│   │   │   │   ├── monthly_payout.dart
│   │   │   │   ├── payout_history.dart
│   │   │   │   ├── wallet_home.dart
│   │   │   │   ├── add_money.dart
│   │   │   │   └── withdraw_request.dart
│   │   │   │
│   │   │   └── orders/
│   │   │       ├── my_orders.dart
│   │   │       ├── cart_page.dart
│   │   │       └── payment_process.dart
│   │   │
│   │   ├── designer/                     # 🟧 Designer Module (7 screens)
│   │   │   ├── designer_dashboard.dart
│   │   │   ├── new_messages.dart
│   │   │   ├── design_requests.dart
│   │   │   ├── screen_share.dart
│   │   │   ├── customer_chat.dart
│   │   │   ├── work_upload.dart
│   │   │   └── profile_verification.dart
│   │   │
│   │   ├── vendor/                       # 🟨 Vendor Module (5 screens)
│   │   │   ├── vendor_dashboard.dart
│   │   │   ├── vendor_design_requests.dart
│   │   │   ├── vendor_screen_share.dart
│   │   │   ├── vendor_work_upload.dart
│   │   │   └── vendor_chat.dart
│   │   │
│   │   ├── delivery/                     # 🟫 Delivery Module (6 screens)
│   │   │   ├── delivery_dashboard.dart
│   │   │   ├── orders_list.dart
│   │   │   ├── order_details.dart
│   │   │   ├── start_delivery.dart
│   │   │   ├── mark_delivered.dart
│   │   │   └── collect_payment.dart
│   │   │
│   │   └── admin/                        # 🟥 Admin/HR Module (24 screens)
│   │       ├── hr_dashboard.dart
│   │       │
│   │       ├── hiring/
│   │       │   ├── add_job.dart
│   │       │   ├── candidates_list.dart
│   │       │   ├── video_interview.dart
│   │       │   ├── reject_list.dart
│   │       │   └── final_selection.dart
│   │       │
│   │       ├── attendance/
│   │       │   ├── attendance_list.dart
│   │       │   ├── live_attendance.dart
│   │       │   └── monthly_attendance.dart
│   │       │
│   │       ├── payroll/
│   │       │   ├── salary_list.dart
│   │       │   ├── payslip_list.dart
│   │       │   └── salary_dashboard.dart
│   │       │
│   │       ├── offer/
│   │       │   ├── offer_letters.dart
│   │       │   ├── send_offer.dart
│   │       │   └── cancel_offer.dart
│   │       │
│   │       ├── reporting/
│   │       │   ├── daily_summary.dart
│   │       │   └── target_list.dart
│   │       │
│   │       └── documentation/
│   │           ├── kyc_page.dart
│   │           ├── submitted_docs.dart
│   │           ├── pending_docs.dart
│   │           ├── employee_id_card.dart
│   │           └── kyc_completed.dart
│   │
│   ├── widgets/                           # Shared/Reusable widgets
│   │   ├── custom_button.dart
│   │   ├── custom_textfield.dart
│   │   ├── loading_indicator.dart
│   │   ├── custom_card.dart
│   │   └── app_drawer.dart
│   │
│   ├── models/                            # Data models
│   │   ├── user_model.dart
│   │   ├── designer_model.dart
│   │   ├── project_model.dart
│   │   └── booking_model.dart
│   │
│   ├── services/                          # API & Business Logic
│   │   ├── api_service.dart
│   │   ├── auth_service.dart
│   │   ├── storage_service.dart
│   │   └── location_service.dart
│   │
│   └── utils/                             # Utility functions
│       ├── validators.dart
│       ├── helpers.dart
│       └── constants.dart
│
├── assets/
│   ├── images/
│   ├── icons/
│   └── logos/
│
├── pubspec.yaml
├── README.md
└── PROJECT_STRUCTURE.md
```

---

## 🎯 Module-wise Screen Count

| Module | Screens | Status |
|--------|---------|--------|
| **Authentication** | 6 | ✅ Created |
| **Customer** | 24 | ✅ Created |
| **Agent** | 22 | ✅ Created |
| **Designer** | 7 | ✅ Created |
| **Vendor** | 5 | ✅ Created |
| **Delivery** | 6 | ✅ Created |
| **Admin/HR** | 24 | ✅ Created |
| **TOTAL** | **94** | ✅ Complete |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.9.2+)
- Dart SDK
- Android Studio / VS Code
- Git

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd rti_app

# Get dependencies
flutter pub get

# Run the app
flutter run
```

---

## 📱 App Features

### 1. Multi-Login System
- Customer
- Agent
- Designer
- Vendor
- Delivery Personnel
- Admin/HR

### 2. Customer Features
- Online design consultation
- Designer selection
- Video chat with designers
- Site visit booking
- Work progress tracking
- File downloads

### 3. Agent Features
- Same as customer
- Land upload
- Company land slots
- Monthly payout
- Wallet system

### 4. Designer Features
- Design requests
- Screen sharing
- Work upload
- Customer chat

### 5. Vendor Features
- Material requests
- Work upload
- Customer communication

### 6. Delivery Features
- Order management
- GPS tracking
- Payment collection

### 7. Admin/HR Features
- Hiring management
- Attendance tracking
- Payroll management
- Documentation

---

## 🎨 Design System

### Colors
- **Sky Blue Background**: `#E0F6FF`
- **Primary**: `#87CEEB`
- **Accent**: `#00BFFF`
- **Dark Sky Blue**: `#4682B4`

### Typography
- **Display**: Bold headings
- **Title**: Section headers
- **Body**: Regular text
- **Caption**: Small text

---

## 📦 Dependencies

### Core
- `provider` - State management
- `get` - Navigation & state
- `go_router` - Routing

### UI
- `cached_network_image` - Image caching
- `shimmer` - Loading effects
- `carousel_slider` - Image carousels
- `flutter_rating_bar` - Ratings

### Backend
- `dio` - HTTP client
- `shared_preferences` - Local storage
- `sqflite` - Local database

### Maps & Location
- `google_maps_flutter`
- `geolocator`
- `geocoding`

### Files
- `image_picker`
- `file_picker`
- `pdf`

---

## 🔧 Configuration

Edit `lib/config/app_constants.dart` for:
- API endpoints
- App settings
- Environment configs

---

## 📝 Development Notes

1. All screens use **Sky Blue theme**
2. Routing managed via `RouteGenerator`
3. Consistent UI with custom widgets
4. Ready for backend integration
5. Modular structure for easy maintenance

---

## 🤝 Contributing
This is a private project. Contact the project owner for contribution guidelines.

---

## 📄 License
Proprietary - All rights reserved

---

## 📞 Contact
For queries, contact the development team.

---

**Total Screens: 94**
**Status: ✅ Complete Structure Created**
