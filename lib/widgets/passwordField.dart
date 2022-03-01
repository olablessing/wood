import "package:flutter/material.dart";
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PasswordField extends StatefulWidget {
  const PasswordField(
      {this.fieldKey,
      this.hintText,
      this.labelText,
      this.helperText,
      this.style,
      this.labelStyle,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.borderDecoration,
      this.errorborderDecoration,
      this.focusedborderDecoration,
      this.onChanged,
      this.errorText,
      this.prefixIcon,
      this.controller,
      this.focusNode,
      this.fillColor,
      this.filled: false,
      Key? key})
      : super(key: key);

  final Key? fieldKey;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final String? errorText;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final FormFieldSetter<String>? onSaved;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onFieldSubmitted;
  final InputBorder? borderDecoration;
  final InputBorder? errorborderDecoration;
  final InputBorder? focusedborderDecoration;
  final ValueChanged<String>? onChanged;
  final Icon? prefixIcon;
  final Color? fillColor;
  final bool filled;

  @override
  _PasswordFieldState createState() => new _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.fieldKey,
      // autovalidate: true,
      enabled: true,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      onFieldSubmitted: widget.onFieldSubmitted,
      onChanged: widget.onChanged,
      controller: widget.controller,
      style: widget.style,
      decoration: InputDecoration(
        fillColor: widget.fillColor,
        filled: widget.filled,
        border: widget.borderDecoration,
        errorBorder: widget.errorborderDecoration,
        focusedErrorBorder: widget.errorborderDecoration,
        focusedBorder: widget.focusedborderDecoration,
        hintText: widget.hintText,
        labelText: widget.labelText,
        labelStyle: widget.labelStyle,
        helperText: widget.helperText,
        errorText: widget.errorText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
          child: Icon(_obscureText ? MdiIcons.eye : MdiIcons.eyeOff, size: 16),
        ),
      ),
    );
  }
}
