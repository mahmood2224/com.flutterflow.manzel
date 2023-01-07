import 'package:app_settings/app_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_util.dart';

class CommonAlertDialog extends StatefulWidget {

  final String? alertBoxTitle;
  final VoidCallback onCancel;
  final VoidCallback? onSettings;

  const CommonAlertDialog({
    Key? key,
    required this.onCancel,
    this.alertBoxTitle, this.onSettings,
  }) : super(key: key);

  @override
  State<CommonAlertDialog> createState() => _CommonAlertDialogState();
}

class _CommonAlertDialogState extends State<CommonAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Column(
        children: [
          Text(
            widget.alertBoxTitle ?? FFLocalizations.of(context).getText(
              'pleaseCheckInternet' /* Please Check */,
            ),
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.normal),
            textAlign: TextAlign.start,
          ),

        ],
      ),
      actions: [
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: widget.onCancel,
          child: Text(FFLocalizations.of(context).getText(
              't7s7qd09'), /* Cancel */
              ),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: widget.onSettings??
            AppSettings.openWIFISettings,
          child: Text(FFLocalizations.of(context).getText(
              'settings'), /* Cancel */
          ),
        ),
      ],
    );
  }
}
