import 'package:nada_dco/common/default_button.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';
import 'Settings.dart';

class ChangePassword extends StatefulWidget {
  static String routeName = './ChangePassword';
  const ChangePassword({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool _passwordVisible = true;
  bool newPasswordVisible = true;
  bool confirmPasswordVisible = true;
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
                    MaterialPageRoute(builder: (context) => Settings(title: '')),
                  );
                },
              )),
          title: Text(AppLanguage.ChangePasswordText[language],
              style: Constant.appBarCenterTitleStyle),
        ),
        body: SafeArea(
          child: Container(
            width: MediaQuery.of(context).size.width * 100 / 100,
            height: MediaQuery.of(context).size.height * 100 / 100,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
               
              
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
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 8 / 100,
                            height: MediaQuery.of(context).size.width * 8 / 100,
                            child: Image.asset(AppImage.LockIcon),
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
                            width: MediaQuery.of(context).size.width * 75 / 100,
                          
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              obscureText: _passwordVisible,
                              cursorColor: Colors.black,
                              maxLength: 16,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                                //  contentPadding:EdgeInsets.only(bottom: 2.0,left: 8),
                                suffixIcon: TextButton(
                                  child: Text(
                                    _passwordVisible
                                        ? AppLanguage.ShowText[language]
                                        : AppLanguage.HideText[language],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                hintText:
                                    AppLanguage.CurrentPasswordText[language],
                                hintStyle: Constant.textFilledStyle
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //  margin: EdgeInsets.only(top: 1),
                        width: MediaQuery.of(context).size.width * 88 / 100,
                        height: MediaQuery.of(context).size.height * 0.1 / 100,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 100,
                ),
           
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
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 8 / 100,
                            height: MediaQuery.of(context).size.width * 8 / 100,
                            child: Image.asset(AppImage.LockIcon),
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
                            width: MediaQuery.of(context).size.width * 75 / 100,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              obscureText: newPasswordVisible,
                              cursorColor: Colors.black,
                               textAlignVertical: TextAlignVertical.center,
                              maxLength: 16,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                                //  contentPadding:EdgeInsets.only(bottom: 2.0,left: 8),
                                suffixIcon: TextButton(
                                  child: Text(
                                    newPasswordVisible
                                        ? AppLanguage.ShowText[language]
                                        : AppLanguage.HideText[language],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      newPasswordVisible = !newPasswordVisible;
                                    });
                                  },
                                ),
                                hintText: AppLanguage.NewpasswordText[language],
                                hintStyle: Constant.textFilledStyle
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //  margin: EdgeInsets.only(top: 1),
                        width: MediaQuery.of(context).size.width * 88 / 100,
                        height: MediaQuery.of(context).size.height * 0.1 / 100,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 3 / 100,
                ),
               
                Container(
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
                            width: MediaQuery.of(context).size.width * 2 / 100,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 8 / 100,
                            height: MediaQuery.of(context).size.width * 8 / 100,
                            child: Image.asset(AppImage.LockIcon),
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
                            width: MediaQuery.of(context).size.width * 75 / 100,
                            child: TextFormField(
                              style: const TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              obscureText: confirmPasswordVisible,
                               textAlignVertical: TextAlignVertical.center,
                              cursorColor: Colors.black,
                              maxLength: 16,
                              decoration: InputDecoration(
                                counterText: '',
                                border: InputBorder.none,
                                fillColor: Colors.white,
                                filled: true,
                                //  contentPadding:EdgeInsets.only(bottom: 2.0,left: 8),
                                suffixIcon: TextButton(
                                  child: Text(
                                    confirmPasswordVisible
                                        ? AppLanguage.ShowText[language]
                                        : AppLanguage.HideText[language],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      confirmPasswordVisible =
                                          !confirmPasswordVisible;
                                    });
                                  },
                                ),
                                hintText:
                                    AppLanguage.ConfirmPasswordText[language],
                                hintStyle: Constant.textFilledStyle
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        //  margin: EdgeInsets.only(top: 1),
                        width: MediaQuery.of(context).size.width * 88 / 100,
                        height: MediaQuery.of(context).size.height * 0.1 / 100,
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 50),
                    child: DefaultButton(
                        text: AppLanguage.UpdatePasswordText[language],
                        onPress: () {
                           Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Settings(title:"")),
                  );
                        })),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
