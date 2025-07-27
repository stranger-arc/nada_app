import 'package:nada_dco/Screens/EventsDetails.dart';
import 'package:nada_dco/Screens/Login.dart';
import 'package:nada_dco/Screens/TravelDetails.dart';
import 'package:nada_dco/Screens/ViewAttendanceDetail.dart';
import 'package:nada_dco/Screens/ViewCollectSampleDetail.dart';
import 'package:nada_dco/Screens/ViewDepositeSampleDetail.dart';
import 'package:nada_dco/Screens/ViewLogisticsDetails.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:flutter/material.dart';

import '../common/default_button.dart';
import '../utilities/app_image.dart';

class SuccessScreen extends StatelessWidget {
  static String routeName = '/Success_screen';

  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SuccessClass? object;

    object = ModalRoute.of(context)!.settings.arguments as SuccessClass;
    print(object.message);
    print(object.title);
    print(object.screenName);

    return Scaffold(
      body: SuccessScreenBody(
          title: object.title,
          message: object.message,
          screenName: object.screenName),
    );
  }
}

class SuccessScreenBody extends StatefulWidget {
  final String title;
  final String message;
  final String screenName;

  SuccessScreenBody(
      {Key? key,
      required this.title,
      required this.message,
      required this.screenName})
      : super(key: key);

  @override
  _SuccessScreenBodyState createState() => _SuccessScreenBodyState();
}

class _SuccessScreenBodyState extends State<SuccessScreenBody> {
  @override
  void initState() {
    super.initState();
    print(widget.screenName);
  }

  @override
  void dispose() {
    super.dispose();
  }

  navigateToNextPage(String screenName) {
    switch (screenName.toLowerCase()) {
      case "forgotscreen":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Login(title: '')),
        );
        break;
      case "eventscreen":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EventsDetails()),
        );
        break;
      case "eventdetailscreen":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EventsDetails()),
        );
        break;
      case "travelplanscreen":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const TravelDetails()),
        );
        break;
      case "viewlogisticdetailscreen":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ViewLogisticsDetails()),
        );
        break;
      case "markattendancescreen":
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ViewAttendanceDetail()),
        );
        break;
      case "depositesample":
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ViewDepositeSampleDetail()),
        );
        break;
      case "collectsampledetails":
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ViewCollectSampleDetail()),
        );
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 100 / 100,
              height: MediaQuery.of(context).size.height * 100 / 100,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    height: 130,
                    color: Colors.white,
                    child: Image.asset(
                      AppImage.checkIcon,
                      width: 140,
                      height: 130,
                     
                    ),
                  ),
                  Container(
                    child: Text(
                      widget.title.toString(),
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 1 / 100,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 92 / 100,
                    child: Text(
                      widget.message.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 4 / 100,
                  ),
                  DefaultButton(
                    text: 'Ok',
                    onPress: () {
                      navigateToNextPage(widget.screenName);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
