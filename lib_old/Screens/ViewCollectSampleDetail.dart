import 'package:nada_dco/Screens/SampleCollectionSubCategory.dart';

import 'package:nada_dco/Screens/Success.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:flutter/material.dart';

import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class ViewCollectSampleDetail extends StatefulWidget {
  static String routeName = '/ViewCollectSampleDetail';
  const ViewCollectSampleDetail({Key? key}) : super(key: key);

  @override
  State<ViewCollectSampleDetail> createState() =>
      _ViewDepositeSampleDetailState();
}

class _ViewDepositeSampleDetailState extends State<ViewCollectSampleDetail> {
  List<SampleCollectList> list = [
    SampleCollectList(name: "Michael Jorden", details: 'Boxing', total: '22'),
    SampleCollectList(
        name: "Michael Jorden", details: 'Basketball', total: '44'),
    SampleCollectList(
        name: "Michael Jorden", details: 'Table Tennis', total: '51'),
  ];

   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
          systemOverlayStyle:Constant.systemUiOverlayStyle,
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
                    context, SampleCollectionSubCategory.routeName);
              },
            )),
        title: Text(AppLanguage.ViewCollectedSamplesDetailText[language],
            style: Constant.appBarCenterTitleStyle),
      ),
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(top: 10),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    // color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                   gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xffE3f5AB), Colors.white],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 90 / 100,
                  height: MediaQuery.of(context).size.height * 15 / 100,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical:14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ViewCollectSampleDetailRow(
                            title1: AppLanguage.EventText[language], title2: list[index].details),
                        ViewCollectSampleDetailRow(
                            title1: AppLanguage.SampleCodeText[language], title2: list[index].total),
                        ViewCollectSampleDetailRow(
                            title1: AppLanguage.AthleteNameText[language], title2: list[index].name),
                             ViewCollectSampleDetailRow(
                            title1: AppLanguage.SampleTypeText[language], title2: "Blood"),
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

class ViewCollectSampleDetailRow extends StatelessWidget {
  ViewCollectSampleDetailRow({
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
              color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w500),
        ),
        Text(
          title2.toString(),
          style: const TextStyle(
              color: Colors.black, fontSize: 15.0, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }
}

class SampleCollectList {
  String name, details, total;
  SampleCollectList({
    required this.name,
    required this.details,
    required this.total,
  });
}
