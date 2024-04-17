import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/colors.dart';
import '../../core/utils/styles.dart';






class CustomButtonWidget extends StatelessWidget {
  final Color? buttonColor;
  final Color? buttonTextColor;
  final String buttonText;
  final String? buttonIconPath;
  final Color? borderColor;
  final Function()? onTap;
  final double? buttonRadius;
  final bool? isFloatButton;
  final bool? isLoading;
  final double? height;
  final double? width;
  const CustomButtonWidget({
    Key? key,
    required this.buttonText,
    this.onTap,
    this.buttonColor,
    this.buttonIconPath,
    this.buttonTextColor,
    this.borderColor,
    this.buttonRadius,
    this.isFloatButton,
    this.height, this.isLoading, this.width,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: SizedBox(
        height: height ?? Get.height * 0.07,
        width: width,
        child: isFloatButton ?? false
            ? Align(
          alignment: Alignment.centerRight,
          child: FloatingActionButton(
            onPressed: onTap,
            child: const Icon(Icons.add),
          ),
        )
            :  ElevatedButton(
          style: ButtonStyle(
              minimumSize:
              MaterialStateProperty.all(Size.zero), // Set this
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              backgroundColor: MaterialStateProperty.all(
                  buttonColor ?? AppColors.primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(buttonRadius ?? 50.0),
                      side: BorderSide(
                          color: borderColor ??
                              buttonColor ??
                              AppColors.primaryColor)))),
          onPressed: onTap,
          child: isLoading ?? false
              ? const Center(child: CircularProgressIndicator(
            color: AppColors.whiteColor,
          ))
              : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buttonIconPath != null
                  ? Container(
                decoration: BoxDecoration(
                  color: buttonColor ?? buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    buttonIconPath!,
                    width: context.height * 0.033,
                    height: context.height * 0.033,
                    fit: BoxFit.fill,
                  ),
                ),
              )
                  : SizedBox(
                width: context.width * 0.001,
              ),
              Text(
                buttonText,
                style: AppTextStyles.title?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,


                    color: buttonTextColor ?? AppColors.whiteColor),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,

              ),
              SizedBox(
                width: context.width * 0.001,
              )
            ],
          ),
        ),

      ),
    );
  }
}
