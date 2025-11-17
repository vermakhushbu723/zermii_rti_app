# Zermii RTI - Your Complete Interior Design Solution 🏠

A comprehensive multi-user Flutter application for interior design, construction, real estate services, and property management.

## 🎨 Theme
**Sky Blue Color Scheme** throughout the application:
- Background: Light Sky Blue (#E0F6FF)
- Primary: Sky Blue (#87CEEB)
- Accent: Deep Sky Blue (#00BFFF)
- Text: Dark colors for contrast

---

## 📱 Key Features

### 🔐 Multi-Login System
Six different user types with dedicated dashboards:
1. **Customer** - Browse designs, book consultations
2. **Agent** - Manage properties, earn commissions
3. **Designer** - Create designs, video consultations
4. **Vendor** - Supply materials, manage orders
5. **Delivery** - Handle deliveries with GPS tracking
6. **Admin/HR** - Manage employees, payroll, hiring

### ✨ Core Modules

#### Customer Module (24 screens)
- Online design consultation with video chat
- Designer search and selection
- Site visit booking
- Work progress tracking
- Download design files and invoices

#### Agent Module (22 screens)
- All customer features
- Land upload and management
- Monthly payout tracking
- Wallet system
- Order management

#### Designer Module (7 screens)
- Design request management
- Screen sharing
- Work upload
- Customer communication

#### Vendor Module (5 screens)
- Material request handling
- Work uploads
- Customer chat

#### Delivery Module (6 screens)
- Order tracking
- GPS-based delivery
- Payment collection

#### Admin/HR Module (24 screens)
- Hiring & recruitment
- Attendance management
- Payroll processing
- Documentation & KYC

---

## 🚀 Getting Started

### Prerequisites
```bash
Flutter SDK: >=3.9.2
Dart SDK
Android Studio / VS Code
```

### Installation

```bash
# Navigate to project
cd rti_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 📂 Project Structure

```
lib/
├── main.dart                     # Entry point
├── config/                       # App configuration
│   ├── app_colors.dart          # Sky blue theme colors
│   ├── app_theme.dart           # Material theme
│   ├── app_routes.dart          # Route definitions
│   ├── app_constants.dart       # Constants
│   └── route_generator.dart     # Route management
├── screens/                      # All screens (94 total)
│   ├── auth/                    # 6 auth screens
│   ├── customer/                # 24 customer screens
│   ├── agent/                   # 22 agent screens
│   ├── designer/                # 7 designer screens
│   ├── vendor/                  # 5 vendor screens
│   ├── delivery/                # 6 delivery screens
│   └── admin/                   # 24 HR screens
├── widgets/                      # Reusable widgets
├── models/                       # Data models
├── services/                     # API & services
└── utils/                        # Utilities
```

---

## 🎯 Total Screens: **94**

| Module | Count | Status |
|--------|-------|--------|
| Authentication | 6 | ✅ |
| Customer | 24 | ✅ |
| Agent | 22 | ✅ |
| Designer | 7 | ✅ |
| Vendor | 5 | ✅ |
| Delivery | 6 | ✅ |
| Admin/HR | 24 | ✅ |

---

## 📦 Key Dependencies

- **State Management**: Provider, GetX
- **Navigation**: go_router
- **HTTP**: Dio
- **Storage**: shared_preferences, sqflite
- **Maps**: google_maps_flutter, geolocator
- **Media**: image_picker, file_picker
- **UI**: carousel_slider, shimmer, fl_chart

See `pubspec.yaml` for complete list.

---

## 🔧 Configuration

Edit `lib/config/app_constants.dart`:
```dart
static const String baseUrl = 'YOUR_API_URL';
```

---

## 📱 Screenshots
(Add screenshots here after running the app)

---

## 🏗️ Development Roadmap

### Phase 1: ✅ Complete
- Project structure
- All screen files created
- Sky blue theme implemented
- Routing configured

### Phase 2: 🚧 In Progress
- Backend API integration
- State management implementation
- Database setup

### Phase 3: 📋 Planned
- Video chat integration
- Payment gateway
- Push notifications
- Real-time updates

---

## 🤝 Contributing
This is a private project. Contact admin for contribution access.

---

## 📄 License
All rights reserved © 2025

---

## 📞 Support
For issues or queries, contact the development team.

---

**Built with ❤️ using Flutter**

**Version**: 1.0.0
**Last Updated**: 2025
