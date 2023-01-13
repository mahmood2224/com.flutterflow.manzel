import 'package:flutter/material.dart';
import 'package:manzel/flutter_flow/flutter_flow_theme.dart';
import 'package:manzel/shared/styles/sizes.dart';

class CustomTextField extends StatefulWidget {
  TextEditingController controller;
  String? hint;
  double? width;
  double? height;
  bool required;
  bool obscure;
  String? label;
  IconData? suffixIcon;
  Widget? suffixIconWidget;
  IconData? prefixIcon;
  Widget? prefixIconWidget;
  Color? labelColor;
  TextInputType? textType;
  Function? onChange;
  Function? iconPressed;
  Function? onPressed;
  bool enabled;
  double? borderRaduis;
  TextAlign? align;
  FocusNode? focusNode;
  int? maxLines;
  bool withShadow;
  String? Function(String?)? validator;
  Color? backgroundColor;
  Color? borderColor;
  int? minLines;
  double? fontSizeHint;
  double? fontSizeLabel;
  Function? onFieldSubmitted;
  CustomTextField(
      {required this.controller,
      this.hint = "",
      this.width,
      this.height,
      this.validator,
      this.withShadow = true,
      this.borderRaduis,
      this.obscure = false,
      this.label,
      this.suffixIcon,
      this.suffixIconWidget,
      this.enabled = true,
      this.labelColor,
      this.backgroundColor,
      this.onFieldSubmitted,
      this.borderColor,
      this.textType,
      this.onPressed,
      this.align,
      this.required = false,
      this.prefixIcon,
      this.prefixIconWidget,
      this.focusNode,
      this.maxLines,
      this.minLines,
      this.iconPressed,
      this.onChange,
      this.fontSizeHint,
      this.fontSizeLabel});
  @override
  _CustomTextFieldState createState() {
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  void initState() {
    super.initState();
  }

  InputBorder getInputBorder(){
    return OutlineInputBorder(
        borderSide: BorderSide(
            color: widget.borderColor ?? FlutterFlowTheme.of(context).textViewBackground),
        borderRadius:
        BorderRadius.circular(widget.borderRaduis ?? 12));
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => {if (widget.onPressed != null) widget.onPressed!()},
      child: Container(
        height: widget.height,
        width: widget.width ?? (getWidth(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.label != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Text(
                      widget.label ?? "",
                      style: TextStyle(fontSize: widget.fontSizeLabel ?? 14),
                    ),
                    ...widget.required
                        ? [
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "*",
                              style: TextStyle(fontSize: 14, color: Colors.red),
                            ),
                          ]
                        : []
                  ],
                ),
              ),
            Container(
              child: Center(
                child: TextFormField(
                  minLines: widget.minLines ?? 1,
                  maxLines: widget.maxLines ?? 1,
                  enabled: widget.enabled,
                  onFieldSubmitted: (val) => {
                    if (widget.onFieldSubmitted != null)
                      widget.onFieldSubmitted!()
                  },
                  keyboardType: widget.textType ?? TextInputType.text,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  validator: widget.validator,
                  onChanged: (txt) {
                    if (widget.onChange != null) widget.onChange!(txt);
                  },

                  textInputAction: TextInputAction.next,
                  obscureText: widget.obscure,
                  textAlign: widget.align ?? TextAlign.start,
                  decoration: InputDecoration(
                    hintText: widget.hint ?? "",
                    hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: widget.fontSizeHint ?? 16),
                    labelStyle: TextStyle(fontSize: 14, color: Colors.black),
                    contentPadding:
                        EdgeInsets.only(top: 12, right: 16, left: 16),
                    enabledBorder: getInputBorder(),
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).textViewBackground,
                    focusedBorder: getInputBorder(),
                    border:getInputBorder(),
                    focusedErrorBorder: getInputBorder(),
                    disabledBorder: getInputBorder(),
                    errorBorder:getInputBorder(),
                    suffixIcon: widget.suffixIconWidget == null
                        ? (widget.suffixIcon == null
                            ? null
                            : InkWell(
                                onTap: () {
                                  if (widget.iconPressed != null)
                                    widget.iconPressed!();
                                },
                                child: Icon(
                                  widget.suffixIcon,
                                  size: 18,
                                  color: Colors.grey,
                                )))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              widget.suffixIconWidget ?? Container(),
                            ],
                          ),
                    prefixIcon: widget.prefixIconWidget == null
                        ? (widget.prefixIcon == null
                            ? null
                            : Icon(
                                widget.prefixIcon,
                                size: 18,
                                color: Colors.grey,
                              ))
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              widget.prefixIconWidget ?? Container(),
                            ],
                          ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
