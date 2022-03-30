import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:cupid_knot_assessment_test/widgets/input_field.dart';
import 'package:flutter/material.dart';

class GenderGetter extends StatefulWidget {
  static const id = 'GenderGetter';

  final String? defaultValue;
  final Function(String) onChange;

  const GenderGetter({
    Key? key,
    this.defaultValue,
    required this.onChange,
  }) : super(key: key);

  @override
  State<GenderGetter> createState() => _GenderGetterState();
}

class _GenderGetterState extends State<GenderGetter> {
  static const _genders = ['Male', 'Female'];

  late String _selectedGender;

  @override
  void initState() {
    _selectedGender = widget.defaultValue == null
        ? _genders.first
        : capitalizeFirst(widget.defaultValue);

    // on register screen
    if (widget.defaultValue == null) {
      widget.onChange(_selectedGender.toUpperCase());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InputField.buildTitle(context, title: 'Gender'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: _genders
                .map(
                  (gender) => Expanded(
                    child: RadioListTile<String>(
                      title: Text(gender),
                      value: gender.toUpperCase(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      contentPadding: EdgeInsets.zero,
                      groupValue: _selectedGender.toUpperCase(),
                      onChanged: (v) {
                        setState(() => _selectedGender = v!);
                        widget.onChange(v!);
                      },
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
