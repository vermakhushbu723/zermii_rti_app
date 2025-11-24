import 'package:flutter/material.dart';

// Auth Screens
import '../screens/auth/splash_screen.dart';
import '../screens/auth/get_started_screen.dart';
import '../screens/auth/select_user_type_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/agent_login_screen.dart';
import '../screens/auth/designer_login_screen.dart';
import '../screens/auth/vendor_login_screen.dart';
import '../screens/auth/delivery_login_screen.dart';
import '../screens/auth/admin_login_screen.dart';
import '../screens/auth/customer_signup_screen.dart';
import '../screens/auth/agent_signup_screen.dart';
import '../screens/auth/designer_signup_screen.dart';
import '../screens/auth/vendor_signup_screen.dart';
import '../screens/auth/delivery_signup_screen.dart';
import '../screens/auth/admin_signup_screen.dart';
import '../screens/auth/otp_verification_screen.dart';

// Customer Screens
import '../screens/customer/customer_dashboard.dart';
import '../screens/customer/customer_profile_screen.dart';
import '../screens/customer/customer_account_screen.dart';
import '../screens/customer/customer_orders_screen.dart';
import '../screens/customer/customer_notifications_screen.dart';
import '../screens/customer/customer_saved_address_screen.dart';
import '../screens/customer/customer_saved_cards_screen.dart';
import '../screens/customer/customer_settings_screen.dart';
import '../screens/customer/customer_help_screen.dart';
import '../screens/customer/customer_change_password_screen.dart';
import '../screens/customer/customer_preferences_screen.dart';
import '../screens/customer/customer_change_avatar_screen.dart';
import '../screens/customer/customer_business_account_screen.dart';
import '../screens/customer/customer_sign_in_different_email_screen.dart';
import '../screens/customer/customer_downloads_screen.dart';
import '../screens/customer/customer_wallet_dashboard.dart';
import '../screens/customer/nearby_dealer_screen.dart';
import '../screens/customer/online_design/online_design_home.dart';
import '../screens/customer/online_design/designer_list.dart';
import '../screens/customer/online_design/designer_details.dart';

// Customer Cart & Orders
import '../screens/customer/cart/cart_screen.dart';
import '../screens/customer/cart/cart_checkout_screen.dart';
import '../screens/customer/cart/payment_method_screen.dart';
import '../screens/customer/cart/order_tracking_screen.dart';
import '../screens/customer/cart/order_details_screen.dart';

// Agent Screens
import '../screens/agent/agent_dashboard.dart';
import '../screens/agent/online_design/agent_designer_list.dart';
import '../screens/agent/online_design/agent_designer_details.dart';
import '../screens/agent/online_design/agent_online_design_form.dart';
import '../screens/agent/online_design/appointment_calendar.dart';
import '../screens/agent/online_design/video_chat_screen.dart';
import '../screens/agent/online_design/make_plan.dart';
import '../screens/agent/online_design/make_3d_plan.dart';
import '../screens/agent/upload_land/upload_land_form.dart';
import '../screens/agent/upload_land/my_uploaded_lands.dart';
import '../screens/agent/company_land/company_land_slots.dart';
import '../screens/agent/company_land/slot_booking_details.dart';
import '../screens/agent/work_progress/agent_work_progress.dart';
import '../screens/agent/work_progress/agent_chat.dart';
import '../screens/agent/downloads/agent_downloads.dart';
import '../screens/agent/payout/monthly_payout.dart';
import '../screens/agent/payout/payout_history.dart';
import '../screens/agent/wallet/agent_wallet.dart';
import '../screens/agent/wallet/add_money_screen.dart';
import '../screens/agent/wallet/withdraw_request.dart';
import '../screens/agent/wallet/cart_page.dart';
import '../screens/agent/wallet/process_payment.dart';
import '../screens/agent/orders/agent_orders.dart';

// Designer Screens
import '../screens/designer/designer_dashboard.dart';
import '../screens/designer/designer_messages_screen.dart';
import '../screens/designer/designer_requests_screen.dart';
import '../screens/designer/designer_screen_share_screen.dart';
import '../screens/designer/designer_chat_screen.dart';
import '../screens/designer/designer_work_upload_screen.dart';
import '../screens/designer/designer_profile_screen.dart';
import '../screens/designer/designer_payout_screen.dart';
import '../screens/designer/designer_settings_screen.dart';

// Vendor Screens
import '../screens/vendor/vendor_dashboard.dart';

// Delivery Screens
import '../screens/delivery/delivery_dashboard.dart';

// Admin/HR Screens
import '../screens/admin/admin_dashboard.dart';
import '../screens/admin/hr_dashboard.dart';

import 'app_routes.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // Auth Routes
      case AppRoutes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case AppRoutes.getStarted:
        return MaterialPageRoute(builder: (_) => const GetStartedScreen());

      case AppRoutes.selectUserType:
        return MaterialPageRoute(builder: (_) => const SelectUserTypeScreen());

      case AppRoutes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
          settings: settings,
        );

      case AppRoutes.agentLogin:
        return MaterialPageRoute(
          builder: (_) => const AgentLoginScreen(),
          settings: settings,
        );

      case AppRoutes.designerLogin:
        return MaterialPageRoute(
          builder: (_) => const DesignerLoginScreen(),
          settings: settings,
        );

      case AppRoutes.vendorLogin:
        return MaterialPageRoute(
          builder: (_) => const VendorLoginScreen(),
          settings: settings,
        );

      case AppRoutes.deliveryLogin:
        return MaterialPageRoute(
          builder: (_) => const DeliveryLoginScreen(),
          settings: settings,
        );

      case AppRoutes.adminLogin:
        return MaterialPageRoute(
          builder: (_) => const AdminLoginScreen(),
          settings: settings,
        );

      case AppRoutes.customerSignup:
        return MaterialPageRoute(builder: (_) => const CustomerSignupScreen());

      case AppRoutes.agentSignup:
        return MaterialPageRoute(builder: (_) => const AgentSignupScreen());

      case AppRoutes.designerSignup:
        return MaterialPageRoute(builder: (_) => const DesignerSignupScreen());

      case AppRoutes.vendorSignup:
        return MaterialPageRoute(builder: (_) => const VendorSignupScreen());

      case AppRoutes.deliverySignup:
        return MaterialPageRoute(builder: (_) => const DeliverySignupScreen());

      case AppRoutes.adminSignup:
        return MaterialPageRoute(builder: (_) => const AdminSignupScreen());

      case AppRoutes.otpVerification:
        return MaterialPageRoute(
          builder: (_) => const OtpVerificationScreen(),
          settings: settings,
        );

      // Customer Routes
      case AppRoutes.customerDashboard:
        return MaterialPageRoute(builder: (_) => const CustomerDashboard());

      case AppRoutes.onlineDesignHome:
        return MaterialPageRoute(builder: (_) => const OnlineDesignHome());

      case AppRoutes.designerList:
        return MaterialPageRoute(builder: (_) => const DesignerList());

      case AppRoutes.designerDetails:
        return MaterialPageRoute(builder: (_) => const DesignerDetails());

      case AppRoutes.customerProfile:
        return MaterialPageRoute(builder: (_) => const CustomerAccountScreen());

      case AppRoutes.customerAccount:
        return MaterialPageRoute(builder: (_) => const CustomerAccountScreen());

      case AppRoutes.customerMyProfile:
        return MaterialPageRoute(builder: (_) => const CustomerProfileScreen());

      case AppRoutes.customerOrders:
        return MaterialPageRoute(builder: (_) => const CustomerOrdersScreen());

      case AppRoutes.customerOrderTracking:
        return MaterialPageRoute(builder: (_) => const OrderTrackingScreen());

      case AppRoutes.customerOrderDetails:
        return MaterialPageRoute(builder: (_) => const OrderDetailsScreen());

      case AppRoutes.cartScreen:
        return MaterialPageRoute(builder: (_) => const CartScreen());

      case AppRoutes.cartCheckout:
        return MaterialPageRoute(builder: (_) => const CartCheckoutScreen());

      case AppRoutes.paymentMethod:
        return MaterialPageRoute(builder: (_) => const PaymentMethodScreen());

      case AppRoutes.customerNotifications:
        return MaterialPageRoute(
          builder: (_) => const CustomerNotificationsScreen(),
        );

      case AppRoutes.customerSavedAddress:
        return MaterialPageRoute(
          builder: (_) => const CustomerSavedAddressScreen(),
        );

      case AppRoutes.customerSavedCards:
        return MaterialPageRoute(
          builder: (_) => const CustomerSavedCardsScreen(),
        );

      case AppRoutes.customerSettings:
        return MaterialPageRoute(
          builder: (_) => const CustomerSettingsScreen(),
        );

      case AppRoutes.customerHelp:
        return MaterialPageRoute(builder: (_) => const CustomerHelpScreen());

      case AppRoutes.customerChangePassword:
        return MaterialPageRoute(
          builder: (_) => const CustomerChangePasswordScreen(),
        );

      case AppRoutes.customerPreferences:
        return MaterialPageRoute(
          builder: (_) => const CustomerPreferencesScreen(),
        );

      case AppRoutes.customerChangeAvatar:
        return MaterialPageRoute(
          builder: (_) => const CustomerChangeAvatarScreen(),
        );

      case AppRoutes.customerBusinessAccount:
        return MaterialPageRoute(
          builder: (_) => const CustomerBusinessAccountScreen(),
        );

      case AppRoutes.customerSignInDifferentEmail:
        return MaterialPageRoute(
          builder: (_) => const CustomerSignInDifferentEmailScreen(),
        );

      case AppRoutes.customerDownloads:
        return MaterialPageRoute(
          builder: (_) => const CustomerDownloadsScreen(),
        );

      case AppRoutes.customerWallet:
        return MaterialPageRoute(
          builder: (_) => const CustomerWalletDashboard(),
        );

      case AppRoutes.nearbyDealer:
        return MaterialPageRoute(builder: (_) => const NearbyDealerScreen());

      // Agent Routes
      case AppRoutes.agentDashboard:
        return MaterialPageRoute(builder: (_) => const AgentDashboard());

      case AppRoutes.agentDesignerList:
        return MaterialPageRoute(builder: (_) => const AgentDesignerList());

      case AppRoutes.agentDesignerDetails:
        return MaterialPageRoute(
          builder: (_) => const AgentDesignerDetails(),
          settings: settings,
        );

      case AppRoutes.agentDesignForm:
        return MaterialPageRoute(builder: (_) => const AgentOnlineDesignForm());

      case AppRoutes.agentAppointment:
        return MaterialPageRoute(builder: (_) => const AppointmentCalendar());

      case AppRoutes.agentVideoChat:
        return MaterialPageRoute(
          builder: (_) => const VideoChatScreen(),
          settings: settings,
        );

      case AppRoutes.agentMakePlan:
        return MaterialPageRoute(builder: (_) => const MakePlan());

      case AppRoutes.agentMake3DPlan:
        return MaterialPageRoute(builder: (_) => const Make3DPlan());

      case AppRoutes.uploadLand:
        return MaterialPageRoute(builder: (_) => const UploadLandForm());

      case AppRoutes.myUploadedLands:
        return MaterialPageRoute(builder: (_) => const MyUploadedLands());

      case AppRoutes.companyLandSlots:
        return MaterialPageRoute(builder: (_) => const CompanyLandSlots());

      case '/agent/slotBookingDetails':
        return MaterialPageRoute(
          builder: (_) => const SlotBookingDetails(),
          settings: settings,
        );

      case AppRoutes.agentWorkProgress:
        return MaterialPageRoute(builder: (_) => const AgentWorkProgress());

      case AppRoutes.agentChat:
        return MaterialPageRoute(
          builder: (_) => const AgentChat(),
          settings: settings,
        );

      case AppRoutes.agentDownloads:
        return MaterialPageRoute(builder: (_) => const AgentDownloads());

      case AppRoutes.monthlyPayout:
        return MaterialPageRoute(builder: (_) => const MonthlyPayout());

      case AppRoutes.payoutHistory:
        return MaterialPageRoute(builder: (_) => const PayoutHistory());

      case AppRoutes.agentWallet:
        return MaterialPageRoute(builder: (_) => const AgentWallet());

      case AppRoutes.agentAddMoney:
        return MaterialPageRoute(builder: (_) => const AddMoneyScreen());

      case AppRoutes.agentWithdraw:
        return MaterialPageRoute(builder: (_) => const WithdrawRequest());

      case AppRoutes.agentOrders:
        return MaterialPageRoute(builder: (_) => const AgentOrders());

      case AppRoutes.agentCart:
        return MaterialPageRoute(builder: (_) => const CartPage());

      case '/agent/processPayment':
        return MaterialPageRoute(
          builder: (_) => const ProcessPayment(),
          settings: settings,
        );

      // Designer Routes
      case AppRoutes.designerDashboard:
        return MaterialPageRoute(builder: (_) => const DesignerDashboard());

      case AppRoutes.designerMessages:
        return MaterialPageRoute(
          builder: (_) => const DesignerMessagesScreen(),
          settings: settings,
        );

      case AppRoutes.designerRequests:
        return MaterialPageRoute(
          builder: (_) => const DesignerRequestsScreen(),
          settings: settings,
        );

      case AppRoutes.designerScreenShare:
        return MaterialPageRoute(
          builder: (_) => const DesignerScreenShareScreen(),
          settings: settings,
        );

      case AppRoutes.designerChat:
        return MaterialPageRoute(
          builder: (_) => const DesignerChatScreen(),
          settings: settings,
        );

      case AppRoutes.designerWorkUpload:
        return MaterialPageRoute(
          builder: (_) => const DesignerWorkUploadScreen(),
          settings: settings,
        );

      case AppRoutes.designerProfile:
        return MaterialPageRoute(
          builder: (_) => const DesignerProfileScreen(),
          settings: settings,
        );

      case AppRoutes.designerPayout:
        return MaterialPageRoute(
          builder: (_) => const DesignerPayoutScreen(),
          settings: settings,
        );

      case AppRoutes.designerSettings:
        return MaterialPageRoute(
          builder: (_) => const DesignerSettingsScreen(),
          settings: settings,
        );

      // Vendor Routes
      case AppRoutes.vendorDashboard:
        return MaterialPageRoute(builder: (_) => const VendorDashboard());

      // Delivery Routes
      case AppRoutes.deliveryDashboard:
        return MaterialPageRoute(builder: (_) => const DeliveryDashboard());

      // Admin/HR Routes
      case AppRoutes.adminDashboard:
        return MaterialPageRoute(builder: (_) => const AdminDashboard());

      case AppRoutes.hrDashboard:
        return MaterialPageRoute(builder: (_) => const HRDashboard());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found!')),
      ),
    );
  }
}
