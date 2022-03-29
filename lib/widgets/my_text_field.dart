import 'package:easy_container/easy_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum MyTextInputType {
  sentences,
  email,
  phone,
  integer,
  decimal,
  url,
  none,
  multiline,
}

class MyTextField extends StatelessWidget {
  final String? labelText;
  final void Function(String?)? onChanged;
  final void Function(String?)? onFieldSubmitted;
  final VoidCallback? trailingFunction;
  final String? defaultValue;
  final Widget? leading;
  final Widget? trailing;
  final bool autofocus;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final double borderRadius;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintTextStyle;
  final bool overrideHintText;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets contentPadding;
  final MyTextInputType inputType;
  final int? maxLines;
  final bool readOnly;
  final bool obscureText;
  final FocusNode? focusNode;
  final Color? bgColor;
  final double? height;
  final int? maxLength;
  final VoidCallback? onTap;

  const MyTextField({
    Key? key,
    this.onTap,
    this.maxLength,
    this.height,
    this.bgColor,
    this.labelText,
    this.textStyle,
    this.hintTextStyle,
    this.onChanged,
    this.onFieldSubmitted,
    this.hintText,
    this.trailingFunction,
    this.defaultValue,
    this.controller,
    this.validator,
    this.leading,
    this.trailing,
    this.width,
    this.margin,
    this.focusNode,
    this.maxLines = 1,
    this.readOnly = false,
    this.obscureText = false,
    this.overrideHintText = false,
    this.autofocus = false,
    this.borderRadius = 10,
    this.inputType = MyTextInputType.sentences,
    this.contentPadding = const EdgeInsets.all(7.5),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyContainer(
      width: width,
      elevation: 0,
      padding: 0,
      height: height,
      borderRadius: borderRadius,
      customMargin: margin ?? EdgeInsets.zero,
      alignment: null,
      child: TextFormField(
        focusNode: focusNode,
        obscureText: obscureText,
        maxLength: maxLength,
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        validator: validator,
        style: textStyle,
        initialValue: defaultValue,
        maxLines: maxLines,
        onTap: onTap,
        textAlignVertical: TextAlignVertical.center,
        autofocus: autofocus,
        keyboardType: _inputTypeData['textInputType'],
        inputFormatters: _inputTypeData['textInputFormatters'],
        textCapitalization: _inputTypeData['textCapitalization'],
        onChanged: onChanged,
        readOnly: readOnly,
        decoration: InputDecoration(
          hintText: 'Enter Value',
          hintStyle: hintTextStyle ??
              const TextStyle(
                color: Color(0xFF7C7272),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
          contentPadding: contentPadding,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent, width: 2),
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ).copyWith(
          hintText: overrideHintText ? hintText : 'Enter $labelText',
          prefixIcon: leading,
          suffixIcon: trailing,
        ),
      ),
    );
  }

  Map<String, dynamic> get _inputTypeData {
    late final List<TextInputFormatter> textInputFormatters;
    late final TextInputType textInputType;
    late final TextCapitalization textCapitalization;

    switch (inputType) {
      case MyTextInputType.multiline:
        textInputType = TextInputType.multiline;
        textCapitalization = TextCapitalization.sentences;
        textInputFormatters = [];
        break;
      case MyTextInputType.sentences:
        textInputType = TextInputType.text;
        textCapitalization = TextCapitalization.sentences;
        textInputFormatters = [];
        break;
      case MyTextInputType.url:
        textInputType = TextInputType.url;
        textCapitalization = TextCapitalization.none;
        textInputFormatters = [];
        break;
      case MyTextInputType.none:
        textInputType = TextInputType.text;
        textCapitalization = TextCapitalization.none;
        textInputFormatters = [];
        break;
      case MyTextInputType.email:
        textInputType = TextInputType.emailAddress;
        textCapitalization = TextCapitalization.none;
        textInputFormatters = [];
        break;
      case MyTextInputType.phone:
        textInputType = TextInputType.number;
        textCapitalization = TextCapitalization.none;
        textInputFormatters = [
          FilteringTextInputFormatter.digitsOnly,
          FilteringTextInputFormatter.deny('.'),
        ];
        break;
      case MyTextInputType.integer:
        textInputType = TextInputType.number;
        textCapitalization = TextCapitalization.none;
        textInputFormatters = [FilteringTextInputFormatter.digitsOnly];
        break;
      case MyTextInputType.decimal:
        textInputType = const TextInputType.numberWithOptions(
          decimal: true,
          signed: false,
        );
        textCapitalization = TextCapitalization.none;
        textInputFormatters = [];
        break;
    }

    return {
      'textInputFormatter': textInputFormatters,
      'textCapitalization': textCapitalization,
      'textInputType': textInputType,
    };
  }
}
