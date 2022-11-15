import 'package:flutter/material.dart';

class CommonAlertDialog extends StatefulWidget {
  final String? alertBoxTitle;
  final VoidCallback? onSubmit;
  final VoidCallback? onCancel;

  const CommonAlertDialog({
    Key? key,
    required this.onSubmit,
    required this.onCancel,
    this.alertBoxTitle,
  }) : super(key: key);

  @override
  State<CommonAlertDialog> createState() => _CommonAlertDialogState();
}

class _CommonAlertDialogState extends State<CommonAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.alertBoxTitle ?? '',
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.normal),
        textAlign: TextAlign.start,
      ),
      actions: [
        SizedBox(
          width: 80, // <-- Your width
          height: 40, // <-- Your height
          child: ElevatedButton(
            onPressed: widget.onCancel,
            child: Text('Cancel'),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).errorColor.withOpacity(0.5),
              textStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(
          width: 80, // <-- Your width
          height: 40, // <-- Your height
          child: ElevatedButton(
            onPressed: widget.onSubmit,
            child: Text('Submit'),
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              textStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
        )
      ],
    );
  }
}
