import 'package:nada_dco/Screens/Settings.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_image.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:flutter/material.dart';

import '../common/default_button.dart';

class Contactus extends StatefulWidget {
  Contactus({super.key, required this.title});

  final String title;
  @override
  _ContactusState createState() => _ContactusState();
}

class _ContactusState extends State<Contactus> {
  bool _passwordVisible = true;
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
                    MaterialPageRoute(
                        builder: (context) => Settings(
                              title: "",
                            )),
                  );
                },
              )),
          title: Text(AppLanguage.ContactUsText[language],
              style: Constant.appBarCenterTitleStyle),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 3 / 100),
                 
                    Container(
                      //  padding: EdgeInsets.only(top:1),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                child: Image.asset(AppImage.userprofileicon),
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.3 / 100,
                                height: MediaQuery.of(context).size.height *
                                    3.3 /
                                    100,
                                color: Colors.grey,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 77 / 100,
                                // height:
                                //     MediaQuery.of(context).size.height * 6.0 / 100,
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.name,
                                  maxLength: 50,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    //  contentPadding:EdgeInsets.only(bottom: 0.5,left: 8),
                                    counterText: '',
                                    hintText:
                                        AppLanguage.EnterFullNameText[language],
                                    hintStyle: Constant.textFilledStyle,
                                       
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            //  margin: EdgeInsets.only(top: 1),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 3 / 100),
                  
                   
                    Container(
                      //  padding: EdgeInsets.only(top:1),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                           
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                width: 25,
                                height: 25,
                                child: Image.asset(AppImage.emailIcon),
                                
                              ),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 0.3 / 100,
                                height: MediaQuery.of(context).size.height *
                                    3.3 /
                                    100,
                                color: Colors.grey,
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 77 / 100,
                                //  height:
                                //       MediaQuery.of(context).size .height * 6.0 / 100,
                                child: TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  keyboardType: TextInputType.emailAddress,
                                  maxLength: 50,
                                  decoration:  InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: Colors.white,
                                    filled: true,
                                    counterText: '',
                                    hintText: AppLanguage.EnterEmailText[language],
                                    contentPadding:
                                        EdgeInsets.only(bottom: 0.5, left: 8),
                                    hintStyle: Constant.textFilledStyle
                                      
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            //  margin: EdgeInsets.only(top: 1),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 4 / 100,
                    ),
                     Container(
                      //  padding: EdgeInsets.only(top:1),
                      width: MediaQuery.of(context).size.width * 90 / 100,
                      // height: MediaQuery.of(context).size.height * 6 / 100,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 2 / 100,
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 7),
                                width:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                height:
                                    MediaQuery.of(context).size.width * 7 / 100,
                                child: Image.asset(AppImage.descriptionIcon),
                                
                              ),
                            
                             
                              Container(
                                width:
                                    MediaQuery.of(context).size.width * 77 / 100,
                                //  height:
                                //       MediaQuery.of(context).size .height * 6.0 / 100,
                                  
                        child: TextFormField(
                          style: const TextStyle(color: Colors.black),
                          keyboardType: TextInputType.multiline,
                          // textInputAction: TextInputAction.done,
                          maxLines: 5,
                          maxLength: 250,
                          decoration:  InputDecoration(
                            counterText: "",
                            border: InputBorder.none,
                            fillColor: Colors.white,
                            filled: true,
                            hintText: AppLanguage.DescriptionText[language],
                            hintStyle: Constant.textFilledStyle
                          ),
                        ),
                      ),
                  
                            
                            ],
                          ),
                          Container(
                            //  margin: EdgeInsets.only(top: 1),
                            width: MediaQuery.of(context).size.width * 88 / 100,
                            height:
                                MediaQuery.of(context).size.height * 0.1 / 100,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  
                   
                  
                   SizedBox(
                      height: MediaQuery.of(context).size.height * 8 / 100,
                    ),
                    DefaultButton(
                      text: AppLanguage.SendText[language],
                      onPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Settings(title: "")),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
