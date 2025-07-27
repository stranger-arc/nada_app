import 'package:nada_dco/Screens/EditProfile.dart';
import 'package:nada_dco/common/default_button.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:flutter/material.dart';
import '../utilities/app_image.dart';
import '../utilities/app_language.dart';

class Location extends StatefulWidget {
  static String routeName = './Location';
  const Location({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfile()),
                );
              },
            )),
        title: Text(
          AppLanguage.LocationText[language],
          style: const TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width * 100 / 100,
            height: MediaQuery.of(context).size.height * 100 / 100,
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 100 / 100,
                  height: MediaQuery.of(context).size.height * 90 / 100,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(AppImage.MapImage),
                        fit: BoxFit.cover),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width * 90 / 100,
                        height: MediaQuery.of(context).size.height * 7 / 100,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 3 / 100,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 7 / 100,
                              height:
                                  MediaQuery.of(context).size.width * 7 / 100,
                              child: Image.asset(AppImage.searchIcon),
                            ),
                            SizedBox(
                              width:
                                  MediaQuery.of(context).size.width * 0.8 / 100,
                            ),
                            Container(
                              width:
                                  MediaQuery.of(context).size.width * 76 / 100,
                              height:
                                  MediaQuery.of(context).size.height * 6 / 100,
                              child: TextFormField(
                                style: const TextStyle(color: Colors.black),
                                keyboardType: TextInputType.text,
                                maxLength: 15,
                                cursorColor: Colors.black,
                                textAlign: TextAlign.left,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  fillColor: Colors.white,
                                  filled: true,
                                  counterText: '',
                                  hintText: AppLanguage.ContinueText[language],
                                  hintStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: DefaultButton(
                            text: AppLanguage.ContinueText[language],
                            onPress: () {
                            
                            }),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
