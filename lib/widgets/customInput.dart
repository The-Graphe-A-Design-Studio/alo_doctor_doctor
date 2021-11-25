import '../utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomInput extends StatefulWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  final Icon prefixIcon;

  CustomInput(
      {this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField,
      this.prefixIcon});

  @override
  _CustomInputState createState() => _CustomInputState();
}

class _CustomInputState extends State<CustomInput> {
  bool _isPassword, _showVisibilityIcon;

  @override
  void initState() {
    super.initState();
    _isPassword = widget.isPasswordField ?? false;
    _showVisibilityIcon = widget.isPasswordField ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFA7F4E8),
            width: 1,
          )),
      child: TextField(
        obscureText: _isPassword,
        focusNode: widget.focusNode,
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        textInputAction: widget.textInputAction,
        decoration: InputDecoration(
            hintText: widget.hintText ?? 'Hint Text...',
            border: InputBorder.none,
            prefixIcon: widget.prefixIcon != null
                ? IconButton(
                    onPressed: () {},
                    icon: widget.prefixIcon,
                  )
                : null,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0)),
        style: Styles.buttonTextBlack,
      ),
    );
  }
}
