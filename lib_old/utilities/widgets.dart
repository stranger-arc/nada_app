import 'package:nada_dco/utilities/app_color.dart';
import 'package:nada_dco/utilities/app_constant.dart';
import 'package:nada_dco/utilities/app_image.dart';
import 'package:flutter/material.dart';

class CustomRow extends StatelessWidget {
  const CustomRow({Key? key, required this.title, required this.status})
      : super(key: key);
  final String title;
  final bool status;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Image.asset(
            status == true
                ? AppImage.activateRadioIcon
                : AppImage.deactivateRadioIcon,
            width: MediaQuery.of(context).size.width * 6.5 / 100,
            height: MediaQuery.of(context).size.width * 6.5 / 100,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title.toString(),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.textModelColor,
            ),
          ),
        ],
      ),
    );
  }
}

