class AppRoutes {
  // Auth Routes
  static const String splash = '/';
  static const String getStarted = '/get-started';
  static const String selectUserType = '/select-user-type';
  static const String login = '/login';
  static const String agentLogin = '/agent-login';
  static const String designerLogin = '/designer-login';
  static const String vendorLogin = '/vendor-login';
  static const String deliveryLogin = '/delivery-login';
  static const String adminLogin = '/admin-login';
  static const String customerSignup = '/customer-signup';
  static const String agentSignup = '/agent-signup';
  static const String designerSignup = '/designer-signup';
  static const String vendorSignup = '/vendor-signup';
  static const String deliverySignup = '/delivery-signup';
  static const String adminSignup = '/admin-signup';
  static const String otpVerification = '/otp-verification';
  static const String forgotPassword = '/forgot-password';
  static const String resetPassword = '/reset-password';

  // Customer Routes
  static const String customerDashboard = '/customer/dashboard';
  static const String onlineDesignHome = '/customer/online-design';
  static const String designerList = '/customer/designer-list';
  static const String designerDetails = '/customer/designer-details';
  static const String onlineDesignForm = '/customer/design-form';
  static const String appointmentCalendar = '/customer/appointment';
  static const String videoChat = '/customer/video-chat';
  static const String makePlan = '/customer/make-plan';
  static const String make3DPlan = '/customer/make-3d-plan';
  static const String nearestDealer = '/customer/nearest-dealer';
  static const String dealerDetails = '/customer/dealer-details';
  static const String slotBooking = '/customer/slot-booking';
  static const String siteVisitBooking = '/customer/site-visit';
  static const String installationBooking = '/customer/installation';
  static const String workProgress = '/customer/work-progress';
  static const String designProgress = '/customer/design-progress';
  static const String design3DProgress = '/customer/3d-progress';
  static const String materialProgress = '/customer/material-progress';
  static const String furnitureProgress = '/customer/furniture-progress';
  static const String customerDownloads = '/customer/downloads';

  // Agent Routes
  static const String agentDashboard = '/agent/dashboard';
  static const String agentDesignerList = '/agent/designer-list';
  static const String agentDesignerDetails = '/agent/designer-details';
  static const String agentDesignForm = '/agent/design-form';
  static const String agentAppointment = '/agent/appointment';
  static const String agentVideoChat = '/agent/video-chat';
  static const String agentMakePlan = '/agent/make-plan';
  static const String agentMake3DPlan = '/agent/make-3d-plan';
  static const String uploadLand = '/agent/upload-land';
  static const String myUploadedLands = '/agent/uploaded-lands';
  static const String companyLandSlots = '/agent/company-land-slots';
  static const String slotBookingDetails = '/agent/slotBookingDetails';
  static const String agentWorkProgress = '/agent/work-progress';
  static const String agentChat = '/agent/chat';
  static const String agentDownloads = '/agent/downloads';
  static const String monthlyPayout = '/agent/monthly-payout';
  static const String payoutHistory = '/agent/payout-history';
  static const String agentWallet = '/agent/wallet';
  static const String agentAddMoney = '/agent/add-money';
  static const String agentWithdraw = '/agent/withdraw';
  static const String agentOrders = '/agent/orders';
  static const String agentCart = '/agent/cart';
  static const String agentPayment = '/agent/payment';

  // Designer Routes
  static const String designerDashboard = '/designer/dashboard';
  static const String designerMessages = '/designer/messages';
  static const String designerRequests = '/designer/requests';
  static const String designerScreenShare = '/designer/screen-share';
  static const String designerChat = '/designer/chat';
  static const String designerWorkUpload = '/designer/work-upload';
  static const String designerProfile = '/designer/profile';

  // Vendor Routes
  static const String vendorDashboard = '/vendor/dashboard';
  static const String vendorRequests = '/vendor/requests';
  static const String vendorScreenShare = '/vendor/screen-share';
  static const String vendorWorkUpload = '/vendor/work-upload';
  static const String vendorChat = '/vendor/chat';

  // Delivery Routes
  static const String deliveryDashboard = '/delivery/dashboard';
  static const String ordersList = '/delivery/orders';
  static const String orderDetails = '/delivery/order-details';
  static const String startDelivery = '/delivery/start-delivery';
  static const String markDelivered = '/delivery/mark-delivered';
  static const String collectPayment = '/delivery/collect-payment';

  // Admin/HR Routes
  static const String adminDashboard = '/admin/dashboard';
  static const String hrDashboard = '/hr/dashboard';

  // Hiring
  static const String addJob = '/hr/add-job';
  static const String candidatesList = '/hr/candidates';
  static const String videoInterview = '/hr/video-interview';
  static const String rejectList = '/hr/reject-list';
  static const String finalSelection = '/hr/final-selection';

  // Attendance
  static const String attendanceList = '/hr/attendance-list';
  static const String liveAttendance = '/hr/live-attendance';
  static const String monthlyAttendance = '/hr/monthly-attendance';

  // Payroll
  static const String salaryList = '/hr/salary-list';
  static const String payslipList = '/hr/payslip-list';
  static const String salaryDashboard = '/hr/salary-dashboard';

  // Offer Letter
  static const String offerLetters = '/hr/offer-letters';
  static const String sendOfferLetter = '/hr/send-offer';
  static const String cancelOfferLetter = '/hr/cancel-offer';

  // Daily Reporting
  static const String dailyWorkSummary = '/hr/daily-summary';
  static const String targetList = '/hr/target-list';

  // Documentation
  static const String kycPage = '/hr/kyc';
  static const String submittedDocuments = '/hr/submitted-docs';
  static const String pendingDocuments = '/hr/pending-docs';
  static const String employeeIdCard = '/hr/employee-id';
  static const String kycCompleted = '/hr/kyc-completed';
}
