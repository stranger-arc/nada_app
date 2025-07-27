import 'package:nada_dco/utilities/app_color.dart';
import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function onPress;

  const DefaultButton({
    Key? key,
    required this.text, required this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onPress() ;  
      },
      child: Container(
        
          width: MediaQuery.of(context).size.width * 90 / 100,
          height: MediaQuery.of(context).size.height * 6 / 100,
          decoration: const BoxDecoration(
            color: AppColor.themeColor,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 18),
          )),
    );
  }
}
