import 'package:cupid_knot_assessment_test/widgets/my_text_field.dart';
import 'package:flutter/material.dart';

export 'package:cupid_knot_assessment_test/widgets/my_text_field.dart';

class InputField extends StatelessWidget {
  static const id = 'InputField';

  final String? title;
  final String? hintText;
  final Widget? icon;
  final bool useAccentColor;
  final bool readOnly;
  final bool obscureText;
  final VoidCallback? onTap;
  final int? maxLines;
  final void Function(String?)? onChanged;
  final MyTextInputType inputType;
  final String? Function(String?)? validator;
  final String? defaultValue;
  final bool autofocus;
  final TextEditingController? controller;
  final double? height;
  final int? maxLength;
  final double bottomPadding;

  const InputField({
    Key? key,
    this.maxLength,
    this.height,
    this.hintText,
    this.onTap,
    this.icon,
    this.readOnly = false,
    this.obscureText = false,
    this.useAccentColor = false,
    this.title,
    this.controller,
    this.maxLines = 1,
    this.bottomPadding = 20,
    this.autofocus = false,
    this.onChanged,
    this.validator,
    this.defaultValue,
    this.inputType = MyTextInputType.sentences,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          Text(
            title!,
            style: Theme.of(context).textTheme.headline6,
          ),
        Row(
          children: [
            if (icon != null) ...[
              icon!,
              const SizedBox(width: 10),
            ],
            Expanded(
              child: MyTextField(
                obscureText: obscureText,
                readOnly: readOnly,
                labelText: title,
                inputType: inputType,
                margin: title == null
                    ? EdgeInsets.zero
                    : const EdgeInsets.only(top: 10),
                onTap: onTap,
                maxLines: maxLines,
                onChanged: onChanged,
                validator: validator,
                hintText: hintText,
                overrideHintText: hintText != null,
                defaultValue: defaultValue,
                height: height,
                autofocus: autofocus,
                controller: controller,
                maxLength: maxLength,
                bgColor: useAccentColor
                    ? Theme.of(context).colorScheme.secondary.withOpacity(0.1)
                    : null,
              ),
            ),
          ],
        ),
        SizedBox(height: bottomPadding),
      ],
    );
  }
}
