
import 'package:geotrack24fsc/screens/Employee_report/employee_report_screen.dart';
import 'package:geotrack24fsc/screens/activities/activities_screen.dart';
import 'package:geotrack24fsc/screens/auth/mobileLogin/mobileLoginScreen.dart';
import 'package:geotrack24fsc/screens/auth/verification/verification_screen.dart';
import 'package:geotrack24fsc/screens/circular/circular_photo.dart';
import 'package:geotrack24fsc/screens/dashboard/dashboard_screen.dart';
import 'package:geotrack24fsc/screens/home/home_screen.dart';
import 'package:geotrack24fsc/screens/onboarding/onboardingScreen.dart';
import 'package:geotrack24fsc/screens/performance_report/performance_report_screen.dart';
import 'package:geotrack24fsc/screens/profile/profile_screen.dart';
import 'package:geotrack24fsc/screens/reports/create_report/create_report_screen.dart';
import 'package:geotrack24fsc/screens/reports/visiting_report/visiting_report_screen.dart';
import 'package:get/get.dart';

import '../screens/circular/circular_screen.dart';
import '../screens/notification/notification_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
  GetPage(
  name: Routes.mobileLogin,
  page: () => MobileLoginScreen(),),
    GetPage(
      name: Routes.onboarding,
      page: () => OnboardingScreen(),),
    GetPage(
      name: Routes.verification,
      page: () => VerificationScreen(),),
    GetPage(
      name: Routes.home,
      page: () => HomeScreen(),),

    GetPage(
      name: Routes.notification,
      page: () => NotificationScreen(),),
    GetPage(
      name: Routes.profile,
      page: () => ProfileScreen(),),

    GetPage(
      name: Routes.dashboard,
      page: () => DashboardScreen(),),

    GetPage(
      name: Routes.visitingReport,
      page: () => VisitingReportScreen(),),

    GetPage(
      name: Routes.createReport,
      page: () => CreateReportScreen(),),

    GetPage(
      name: Routes.performanceReport,
      page: () => PerformanceReportScreen(),),

    GetPage(
      name: Routes.employeeReport,
      page: () => EmployeeReportScreen(),),
    GetPage(
      name: Routes.activities,
      page: () => ActivitiesScreen(),),

    GetPage(
      name: Routes.circular,
      page: () => CircularScreen(),),
    GetPage(
      name: Routes.circularPhoto,
      page: () => CircularPhotoScreen(),),

  ];}