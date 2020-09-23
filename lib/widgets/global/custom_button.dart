/*
  * Author: Gerald Addo-Tetteh
  * Book Search App
  * Color Util
*/

/*
  This widget returns the apps default button.
*/

import 'package:flutter/material.dart';

import '../../utils/color_util.dart';
import '../../utils/default_util.dart';
import '../../utils/text_util.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key key,
    @required this.textUtil,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final TextUtil textUtil;
  final String text;
  final Function() onPressed;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: const EdgeInsets.symmetric(
        horizontal: 70.0,
        vertical: 10.0,
      ),
      color: ColorUtil.buttonColor,
      child: Text(
        widget.text,
        style: widget.textUtil.buttonStyle,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          DefaultUtil.borderRadiusValue,
        ),
      ),
      onPressed: _submit,
    );
  }
}
