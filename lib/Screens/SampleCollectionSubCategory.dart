import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_font.dart';
import 'package:flutter/material.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';
import 'CollectSampleDetails.dart';
import 'ViewCollectSampleDetail.dart';

class SampleCollectionSubCategory extends StatefulWidget {
  static String routeName = './SampleCollectionSubCategory';
  const SampleCollectionSubCategory({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  __SampleCollectionSubCategoryStateState createState() =>
      __SampleCollectionSubCategoryStateState();
}

class __SampleCollectionSubCategoryStateState
    extends State<SampleCollectionSubCategory> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
              )),
          title: Text(AppLanguage.SampleCollectionText[language],
              style: Constant.appBarCenterTitleStyle),
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width * 100 / 100,
            height: MediaQuery.of(context).size.height * 100 / 100,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 7 / 100),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, CollectSampleDetails.routeName);
                  },
                child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        height: MediaQuery.of(context).size.height * 14 / 100,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Text(
                            'Container 1',
                            style: TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -41,
                        
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                AppImage.collectedSampleIcon,
                                width: MediaQuery.of(context).size.width *
                                    24 /
                                    100,
                                height: MediaQuery.of(context).size.width *
                                    24 /
                                    100,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.5 / 100,
                            ),
                            Container(
                              child: Text(
                                AppLanguage.CollectSampleText[language],
                               style: Constant.homeTextStyle
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              
               ),
                SizedBox(height: MediaQuery.of(context).size.height * 8 / 100),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, ViewCollectSampleDetail.routeName);
                  },
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 7,
                              offset: Offset(0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        alignment: Alignment.centerRight,
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        height: MediaQuery.of(context).size.height * 14 / 100,
                        child: RotatedBox(
                          quarterTurns: 1,
                          child: Text(
                            'Container 1',
                            style: TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                      ),
                      Positioned(
                        top: -41,
                        // right: 30,
                        //  bottom: 60,
                        // top: 5,
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                AppImage.descollectedIcon,
                                width: MediaQuery.of(context).size.width *
                                    24 /
                                    100,
                                height: MediaQuery.of(context).size.width *
                                    24 /
                                    100,
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.5 / 100,
                            ),
                            Container(
                              child: Text(
                                AppLanguage.ViewCollectedSamplesDetailText[language],
                               style: Constant.homeTextStyle
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
              
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
