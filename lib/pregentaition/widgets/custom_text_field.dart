
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscure;
  final Color? filColor;
  final Color? borderColor;
  final Color? hintextColor;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final int? maxLine;
  final double? hintextSize;
  final Widget? suffixIcon;
  final FormFieldValidator? validator;
  final bool isPassword;
  final bool? isEmail;
  final bool? readOnly;
  final double? borderRadio;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;


  const CustomTextField(
      {super.key,
        this.contentPaddingHorizontal,
        this.contentPaddingVertical,
        this.hintText,
        this.prefixIcon,
        this.suffixIcon,
        this.maxLine,
        this.validator,
        this.hintextColor,
        this.borderColor,
        this.isEmail,
        required this.controller,
        this.keyboardType = TextInputType.text,
        this.isObscureText = false,
        this.obscure = '*',
        this.filColor,
        this.hintextSize,
        this.labelText,
        this.isPassword = false,
        this.readOnly = false, this.borderRadio, this.onTap, this.onChanged});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      onTap:widget. onTap,
      readOnly: widget.readOnly!,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscuringCharacter: widget.obscure!,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: widget.maxLine ?? 1,
      // validator: widget.validator,
      validator: widget.validator ??
              (value) {
            if (widget.isEmail == null) {
              if (value!.isEmpty) {
                return "Please enter ${widget.hintText!.toLowerCase()}";
              } else if (widget.isPassword) {
                bool data = validatePassword(value);
                if (value.isEmpty) {
                  return "Please enter ${widget.hintText!.toLowerCase()}";
                } else if (data) {
                  return "Insecure password detected.";
                }
              }
            } else {
              bool data = emailValidate.hasMatch(value!);
              if (value.isEmpty) {
                return "Please enter ${widget.hintText!.toLowerCase()}";
              } else if (!data) {
                return "Please check your email!";
              }
            }
            return null;
          },

      cursorColor: Colors.black,
      obscureText: widget.isPassword ? obscureText : false,
      style: TextStyle(color: widget.hintextColor ?? Colors.black, fontSize: widget.hintextSize ?? 12.h),
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
              horizontal: widget.contentPaddingHorizontal ?? 20.w,
              vertical: widget.contentPaddingVertical ?? 10.h),
          fillColor: const Color(0xfff2f6fa),
          filled: true,
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? GestureDetector(
            onTap: toggle,
            child: _suffixIcon(
                obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined),
          )
              : widget.suffixIcon,
          prefixIconConstraints: BoxConstraints(minHeight: 24.w, minWidth: 24.w),
          labelText: widget.labelText,
          hintText: widget.hintText,
          hintStyle: TextStyle(color: widget.hintextColor ?? Colors.black, fontSize: widget.hintextSize ?? 12.h,fontWeight: FontWeight.w400),
          focusedBorder: focusedBorder(),
          enabledBorder: enabledBorder(),
          errorBorder: errorBorder(),
          border: focusedBorder(),
          errorStyle: TextStyle(fontSize: 12.h, fontWeight: FontWeight.w400)
      ),
    );
  }

  _suffixIcon(IconData icon) {
    return Padding(padding: const EdgeInsets.all(12.0), child: Icon(icon,color:AppColors.hinTextColor));
  }

  OutlineInputBorder focusedBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular( widget.borderRadio?.r ?? 16.r),
      borderSide:BorderSide(
          color: widget.borderColor ??AppColors.hinTextColor
      ),
    );
  }

  OutlineInputBorder enabledBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadio?.r ?? 16.r),
      borderSide:BorderSide(
          color: widget.borderColor ?? AppColors.hinTextColor
      ),
    );
  }

  OutlineInputBorder errorBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadio?.r ?? 16.r),
      borderSide: const BorderSide(
          color: Colors.red,width: 0.5
      ),
    );
  }
}


 RegExp emailValidate = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

 bool validatePassword(String value) {
RegExp regex = RegExp(r'^(?=.*[0-9])(?=.*[a-zA-Z]).{6,}$');
return regex.hasMatch(value);
}