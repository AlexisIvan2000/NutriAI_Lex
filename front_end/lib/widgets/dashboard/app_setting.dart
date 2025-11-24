import 'package:flutter/material.dart';
import 'package:front_end/data/db.dart';

class AppSetting extends StatefulWidget {
  const AppSetting({super.key});

  @override
  State<AppSetting> createState() => _AppSettingState();
}

class _AppSettingState extends State<AppSetting> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'App Version',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  '3.4.0',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Language', style: Theme.of(context).textTheme.bodyMedium),
                DropdownButton(
                  borderRadius: BorderRadius.circular(8.0),
                  items: Db.languages.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(
                        level,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                  value: Db.languages[0],
                  onChanged: (_) {
                   // Handle language change
                  },
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Theme', style: Theme.of(context).textTheme.bodyMedium),
                DropdownButton(
                  borderRadius: BorderRadius.circular(8.0),
                  items: Db.themes.map((level) {
                    return DropdownMenuItem(
                      value: level,
                      child: Text(
                        level,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                  value: Db.themes[0],
                  onChanged: (_) {
                    // Handle theme change
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
