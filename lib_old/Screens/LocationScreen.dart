import 'package:nada_dco/Screens/EditProfile.dart';
import 'package:nada_dco/common/default_button.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_image.dart';
import 'package:nada_dco/utilities/app_language.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  static String routeName = './locations';
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
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
        title: Text(AppLanguage.LocationText[language],
            style: Constant.appBarCenterTitleStyle),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width * 100 / 100,
          height: MediaQuery.of(context).size.height * 100 / 100,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage(AppImage.MapImage), fit: BoxFit.cover),
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
                      width: MediaQuery.of(context).size.width * 3 / 100,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 7 / 100,
                      height: MediaQuery.of(context).size.width * 7 / 100,
                      child: Image.asset(AppImage.searchIcon),
                    ),
                  
                    Container(
                   
                      width: MediaQuery.of(context).size.width * 76 / 100,
                      height: MediaQuery.of(context).size.height * 6 / 100,
                      child: TextFormField(
                        style: const TextStyle(color: Colors.black),
                        keyboardType: TextInputType.text,
                        maxLength: 15,
                        cursorColor: Colors.black,
                        textAlign: TextAlign.left,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.white,

                          filled: true,
                           contentPadding:EdgeInsets.only(bottom: 0,left: 8),
                          counterText: '',
                          hintText: "Search",
                          hintStyle: TextStyle(
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
                margin: const EdgeInsets.only(bottom: 10),
                child: DefaultButton(text: "Continue", onPress: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
