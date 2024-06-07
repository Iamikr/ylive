import 'package:flutter/material.dart';

import '../core/utils/colors.dart';
import '../core/utils/styles.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    Key? key,
    this.onEditingComplete,
    this.validator,
    this.keyboardType,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.suffixIcon,
    this.maxline = 1,
    this.onChange,
    this.maxLength,
    this.intialValue,
    this.focusnode,
    this.onFieldSubmitted,

    this.onTap,
    this.expands,
    this.hintMaxLines,
    this.isuffixIconPassword,
    this.prefixIconColor,
    this.borderRadius,
    this.fillColor,
    this.borderColor,
  }) : super(key: key);

  final String? Function(String?)? validator;
  final void Function()? onEditingComplete;
  final String? intialValue;
  final String hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Function(String)? onChange;
  final int? maxline;
  final int? maxLength;
  final FocusNode? focusnode;
  final void Function(String)? onFieldSubmitted;
  final VoidCallback? onTap;
  final bool? expands;
  final int? hintMaxLines;
  final bool? isuffixIconPassword;
  final Color? prefixIconColor;
  final Color? fillColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;

  @override
  State<CustomFormField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomFormField> {
  late bool obscureText;

  @override
  void initState() {
    obscureText = widget.isuffixIconPassword == true;
    super.initState();
  }

  void togglePasswordVisibility() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      expands: widget.expands ?? false,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onFieldSubmitted,
      onEditingComplete: widget.onEditingComplete,
      initialValue: widget.intialValue,
      maxLength: widget.maxLength,
      focusNode: widget.focusnode,
      maxLines: widget.maxline,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: AppTextStyles.title.copyWith(
        color: AppColors.blackColor,
      ),
      keyboardType: widget.keyboardType ?? TextInputType.text,
      cursorColor: AppColors.blackColor,
      obscureText: obscureText,
      controller: widget.controller,
      onChanged: widget.onChange,
      validator: widget.validator,
      decoration: InputDecoration(
        helperMaxLines: widget.hintMaxLines ?? 1,
        contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 20 , bottom: 20),
        alignLabelWithHint: true,
        prefixIcon: widget.prefixIcon == null
            ? null
            : Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: widget.prefixIcon,
        ),
        suffixIcon: widget.isuffixIconPassword == true
            ? GestureDetector(
          onTap: togglePasswordVisibility,
          child: Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: Icon(
              obscureText
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: AppColors.buttonColor,
              size: 20,
            ),
          ),
        )
            : widget.suffixIcon,
        counterText: '',
        fillColor: widget.fillColor ?? AppColors.whiteColor,
        filled: true,
        hintText: widget.hintText,
        hintStyle: AppTextStyles.title,
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
          borderSide: BorderSide(
            color: widget.borderColor ?? AppColors.hintColor,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
          borderSide: BorderSide(
            color: widget.borderColor ?? Colors.transparent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
          borderSide: BorderSide(
            color: widget.borderColor ??Colors.transparent,
          ),
        ),
      ),
    );
  }
}
