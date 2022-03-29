import 'package:cupid_knot_assessment_test/controllers/theme_controller.dart';
import 'package:cupid_knot_assessment_test/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeChanger extends StatelessWidget {
  static const id = 'ThemeChanger';

  const ThemeChanger({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            'Change Theme',
            style: Theme.of(
              context,
            ).textTheme.bodyText2?.copyWith(fontSize: 16),
          ),
        ),
      ),
      onTap: () => _showChangeThemeDialog(context),
    );
  }
}

void _showChangeThemeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => const _ChooseThemeDialog(),
  );
}

class _ChooseThemeDialog extends StatelessWidget {
  const _ChooseThemeDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeController>(
      builder: (context, themeCon, _) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Choose Theme',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            ...ThemeMode.values.map(
              (themeMode) => RadioListTile<String>(
                title: Text(capitalizeFirst(themeMode.name)),
                value: themeMode.name,
                groupValue: themeCon.themeMode?.name,
                onChanged: (v) => themeCon.setThemeString(v!),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('OK'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
