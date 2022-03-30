import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:cupid_knot_assessment_test/widgets/input_field.dart';
import 'package:flutter/material.dart';

class DateOfBirthGetter extends StatefulWidget {
  static const id = 'DateOfBirthGetter';

  final DateTime? defaultValue;
  final void Function(String formattedDate)? onChange;

  const DateOfBirthGetter({
    Key? key,
    this.onChange,
    this.defaultValue,
  }) : super(key: key);

  @override
  State<DateOfBirthGetter> createState() => _DateOfBirthGetterState();
}

class _DateOfBirthGetterState extends State<DateOfBirthGetter> {
  DateTime? _selectedDateTime;
  late final TextEditingController _controller;

  @override
  void initState() {
    _selectedDateTime = widget.defaultValue;

    _controller = TextEditingController();
    if (_selectedDateTime != null) {
      _controller.text = getDisplayDate(_selectedDateTime!);
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InputField(
      title: 'Date of Birth',
      controller: _controller,
      readOnly: true,
      hintText: 'Select Date of Birth',
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _selectedDateTime ?? DateTime(2000),
          firstDate: DateTime(1800),
          lastDate: DateTime.now(),
        );
        if (date != null) {
          _selectedDateTime = date;
          _controller.text = getDisplayDate(date);
          widget.onChange?.call(getFormattedDate(date));
        }
      },
      validator: (v) {
        if (isNullOrBlank(v)) {
          return 'Date of birth cannot be empty!';
        }
        return null;
      },
    );
  }
}
