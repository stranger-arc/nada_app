import 'package:nada_dco/Screens/SampleDepositeSubCategory.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:flutter/material.dart';

import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class ViewDepositeSampleDetail extends StatefulWidget {
  static String routeName = '/view_deposite_sample_details';
  const ViewDepositeSampleDetail({Key? key}) : super(key: key);

  @override
  State<ViewDepositeSampleDetail> createState() =>
      _ViewDepositeSampleDetailState();
}

class _ViewDepositeSampleDetailState extends State<ViewDepositeSampleDetail> {
  List<SampleDepositeList> list = [
    SampleDepositeList(
        name: "Abhay Joshi",
        details: 'Courier',
        date: '22 Nov,2022',
        total: '12'),
    SampleDepositeList(
        name: "Abhay Joshi",
        details: 'Courier',
        date: '29 Nov,2022',
        total: '12'),
    SampleDepositeList(
        name: "Abhay Joshi",
        details: 'Courier',
        date: '26 Nov,2022',
        total: '12'),
    SampleDepositeList(
        name: "Abhay Joshi",
        details: 'Courier',
        date: 'View Details',
        total: '12'),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
        systemOverlayStyle: Constant.systemUiOverlayStyle,
        leading: InkWell(
            onTap: () {},
            child: IconButton(
              icon: Image.asset(
                AppImage.backicon,
                height: 25,
                width: 25,
              ),
              onPressed: () {
                Navigator.pushNamed(
                    context, SampleDepositeSubCategory.routeName);
              },
            )),
        title: Text(AppLanguage.ViewDepositedSampleDetailsText[language],
            style: Constant.appBarCenterTitleStyle),
      ),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300, width: 0.5),
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffE3f5AB), Colors.white],
                    ),
                  ),
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  height: MediaQuery.of(context).size.height * 18 / 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 13),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ViewDepositeSampleDetailRow(
                            title1: AppLanguage.EventText[language],
                            title2: "Olympic Game"),
                        ViewDepositeSampleDetailRow(
                            title1: AppLanguage.TotalSampleText[language],
                            title2: list[index].total),
                        ViewDepositeSampleDetailRow(
                            title1: AppLanguage.HandedOverDateText[language],
                            title2: list[index].date),
                        ViewDepositeSampleDetailRow(
                            title1: AppLanguage.HandedOverToText[language],
                            title2: list[index].details),
                        ViewDepositeSampleDetailRow(
                            title1: AppLanguage.PickerNameText[language],
                            title2: list[index].name),
                      ],
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}

class ViewDepositeSampleDetailRow extends StatelessWidget {
  ViewDepositeSampleDetailRow({
    Key? key,
    required this.title1,
    required this.title2,
  }) : super(key: key);
  final String title1;
  final String title2;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title1.toString(),
          style: const TextStyle(
              color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w600),
        ),
        Text(
          title2.toString(),
          style: const TextStyle(
              color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}

class SampleDepositeList {
  String name, details, date, total;
  SampleDepositeList({
    required this.name,
    required this.details,
    required this.date,
    required this.total,
  });
}
