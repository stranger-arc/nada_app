// All our routes will be available here
import 'package:nada_dco/Screens/ChangePassword.dart';
import 'package:nada_dco/Screens/CollectSampleDetails.dart';
import 'package:nada_dco/Screens/DepositeSamples.dart';
import 'package:nada_dco/Screens/EducationAwareness.dart';
import 'package:nada_dco/Screens/EducationAwarenessAthleeRights.dart';
import 'package:nada_dco/Screens/EducationAwarenessRights.dart';
import 'package:nada_dco/Screens/EventSubCategory.dart';
import 'package:nada_dco/Screens/EventsDetails.dart';
import 'package:nada_dco/Screens/ForgotPassword.dart';
import 'package:nada_dco/Screens/IdCardDetails.dart';
import 'package:nada_dco/Screens/LocationScreen.dart';
import 'package:nada_dco/Screens/Logistics.dart';
import 'package:nada_dco/Screens/LogisticsSubCategory.dart';
import 'package:nada_dco/Screens/MarkAttendance.dart';
import 'package:nada_dco/Screens/Notification.dart';
import 'package:nada_dco/Screens/SampleCollectionSubCategory.dart';
import 'package:nada_dco/Screens/SampleDepositeSubCategory.dart';
import 'package:nada_dco/Screens/SelectGender.dart';
import 'package:nada_dco/Screens/Success.dart';
import 'package:nada_dco/Screens/TravelDetails.dart';
import 'package:nada_dco/Screens/TravelPlans.dart';
import 'package:nada_dco/Screens/TravelSubCategory.dart';
import 'package:nada_dco/Screens/ViewAttendanceDetail.dart';
import 'package:nada_dco/Screens/ViewCollectSampleDetail.dart';
import 'package:nada_dco/Screens/ViewDepositeSampleDetail.dart';
import 'package:nada_dco/Screens/AttendanceSubCategory.dart';
import 'package:nada_dco/Screens/ViewLogisticsDetails.dart';
import 'package:nada_dco/utilities/app_footer.dart';
import 'package:flutter/material.dart';
import 'package:nada_dco/Screens/EditProfile.dart';
import 'package:nada_dco/Screens/Sorry.dart';

final Map<String, WidgetBuilder> routes = {
  Sorry.routeName: (context) => const Sorry(),
  EditProfile.routeName: (context) => const EditProfile(),
  NotificationScreen.routeName: (context) => const NotificationScreen(),
  FootertWidget.routeName: (context) => const FootertWidget(),
  EventSubCategory.routeName: (context) => const EventSubCategory(),
  EventsDetails.routeName: (context) => const EventsDetails(),
  SuccessScreen.routeName: (context) => const SuccessScreen(),
  TravelSubCategory.routeName: (context) => const TravelSubCategory(),
  LogisticsSubCategory.routeName: (context) => const LogisticsSubCategory(),
  AttendanceSubCategory.routeName: (context) => const AttendanceSubCategory(),
  SampleCollectionSubCategory.routeName: (context) =>
      const SampleCollectionSubCategory(),
  SampleDepositeSubCategory.routeName: (context) =>
      const SampleDepositeSubCategory(),
  TravelPlans.routeName: (context) => const TravelPlans(),
  TravelDetails.routeName: (context) => const TravelDetails(),
  Logistics.routeName: (context) => const Logistics(),
  MarkAttendance.routeName: (context) => const MarkAttendance(),
  ViewAttendanceDetail.routeName: (context) => const ViewAttendanceDetail(),
  DepositeSamples.routeName: (context) => const DepositeSamples(),
  ViewDepositeSampleDetail.routeName: (context) =>
      const ViewDepositeSampleDetail(),
  ViewCollectSampleDetail.routeName: (context) =>
      const ViewCollectSampleDetail(),
  CollectSampleDetails.routeName: (context) => const CollectSampleDetails(),
  ForgotPassword.routeName: (context) => const ForgotPassword(),
  IdCardDetails.routeName: (context) => const IdCardDetails(),
  ViewLogisticsDetails.routeName: (context) => const ViewLogisticsDetails(),
  EducationAwareness.routeName: (context) => const EducationAwareness(),
  EducationAwarenessAthleeRights.routeName: (context) =>
      const EducationAwarenessAthleeRights(),
  EducationAwarenessRights.routeName: (context) =>
      const EducationAwarenessRights(),
  LocationScreen.routeName: ((context) => const LocationScreen()),
  ChangePassword.routeName:(context) =>  const ChangePassword(),
  SelectGender.routeName:(context) => const SelectGender(),
};
