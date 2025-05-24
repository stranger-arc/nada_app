import 'package:nada_dco/Screens/EditProfile.dart';
import 'package:nada_dco/common/default_button.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_image.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:flutter/material.dart';

import '../utilities/app_color.dart';

class SelectGender extends StatefulWidget {
  static String routeName = './SelectGender';
  const SelectGender(
      {Key? key, })
      : super(key: key);
  
  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  
  int selectGender=0;
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
                  MaterialPageRoute(builder: (context) => const EditProfile()),
                );
              },
            )),
        title: Text(AppLanguage.SelectGenderText[language],
            style: Constant.appBarCenterTitleStyle),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 100 / 100,
          height: MediaQuery.of(context).size.height * 100 / 100,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 3 / 100,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 84 / 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (() {
                        setState(() {
                          selectGender=0;
                        });
                      }),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 38 / 100,
                        height: MediaQuery.of(context).size.width * 38 / 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(width: 4, color:selectGender==0? AppColor.themeColor:AppColor.boderColor),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                AppImage.maleIcon,
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
                            Text(
                              AppLanguage.MaleText[language],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        setState(() {
                         selectGender=1;
                        });
                      }),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 38 / 100,
                        height: MediaQuery.of(context).size.width * 38 / 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(width: 4, color:selectGender==1? AppColor.themeColor:AppColor.boderColor),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                AppImage.femaleIcon,
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
                            Text(
                              AppLanguage.FemaleText[language],
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 7 / 100,
              ),
              DefaultButton(
                  text: AppLanguage.ContinueText[language],
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
