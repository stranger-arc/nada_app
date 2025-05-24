import 'package:nada_dco/Screens/Home.dart';
import 'package:nada_dco/Screens/TravelDetails.dart';
import 'package:nada_dco/Screens/TravelPlans.dart';
import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_font.dart';
import 'package:flutter/material.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class TravelSubCategory extends StatefulWidget {
  static String routeName = './TravelSubCategory';
  const TravelSubCategory({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _TravelSubCategoryState createState() => _TravelSubCategoryState();
}

class _TravelSubCategoryState extends State<TravelSubCategory> {
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.white,
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
                  MaterialPageRoute(
                      builder: (context) => Home(

                          )),
                );
              },
            )),
        title: Text(
          AppLanguage.TravelPlanText[language],
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
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
                   Navigator.pushNamed(context,TravelPlans.routeName);
                  
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
                      top: -34,
                      
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Image.asset(
                              AppImage.shareIcon,
                          
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
                              AppLanguage.ShareTicketDetailsText[language],
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
                   Navigator.pushNamed(context,TravelDetails.routeName);
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
                              AppImage.desIcon,
                            
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
                              AppLanguage.ViewTicketDetailsText[language],
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
    );
  }
}
