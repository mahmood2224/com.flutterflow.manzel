import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/flutter_flow/flutter_flow_util.dart';
import 'package:manzel/flutter_flow/flutter_flow_widgets.dart';

class CommonAlertDialog extends StatefulWidget {

  final String? alertBoxTitle;
  final VoidCallback? onCancel;

  const CommonAlertDialog({
    Key? key,
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
        widget.alertBoxTitle ?? FFLocalizations.of(context).getText(
          'pleaseCheckInternet' /* Please Check */,
        ),
        style: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(fontWeight: FontWeight.normal),
        textAlign: TextAlign.start,
      ),
      actions: [
        SizedBox(
            width: 120, // <-- Your width
            height: 40, // <-- Your height
            child: FFButtonWidget(
              onPressed: widget.onCancel!,
              text: FFLocalizations.of(context).getText(
                't7s7qd09' /* Cancel */,
              ),
              options: FFButtonOptions(
                height: 38,
                padding: EdgeInsetsDirectional.fromSTEB(9, 0, 0, 0),
                color: FlutterFlowTheme.of(context).primaryColor,
                textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                  fontFamily: 'AvenirArabic',
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  useGoogleFonts: false,
                ),
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            )
        ),
      ],
    );
  }
}
