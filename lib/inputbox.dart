import 'package:flutter/material.dart';
import 'package:namesclash/main.dart';

class InputBox extends StatelessWidget {
  final String initialValue;
  final int maxLength;
  final int maxLines;
  final bool enabled;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final TextEditingController econtroller;
  final TextInputAction textInputAction;
  final FocusNode focusNode, nextFocusNode;
  final VoidCallback submitAction;
  final bool obscureText;
  final FormFieldValidator<String> validateFunction;
  final void Function(String) onSaved, onChange;
  final Widget sufIcon;
  final Widget icon;
  final String helpertext;
  final Key key;

  InputBox({
    this.initialValue,
    this.maxLength,
    this.maxLines,
    this.enabled,
    this.hintText,
    this.labelText,
    this.textInputType,
    this.econtroller,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.obscureText = false,
    this.validateFunction,
    this.onSaved,
    this.onChange,
    this.sufIcon,
    this.icon,
    this.helpertext,
    this.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        decoration: BoxDecoration(color: bg2),
        child: TextFormField(
          maxLength: maxLength,
          obscureText: obscureText,
          enabled: enabled,
          onChanged: onChange,
          validator: validateFunction,
          key: key,
          controller: econtroller,
          keyboardType: textInputType,
          onSaved: onSaved,
          textInputAction: textInputAction,
          focusNode: focusNode,
          maxLines: maxLines,
          onFieldSubmitted: (String term) {
            if (nextFocusNode != null) {
              focusNode.unfocus();
              FocusScope.of(context).requestFocus(nextFocusNode);
            } else {
              submitAction();
            }
          },
          style: TextStyle(fontSize: 24, color: Colors.grey[200]),
          decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).primaryColor, width: 0.5)),
            hintText: hintText,
            labelText: labelText ?? hintText,
            labelStyle:
                TextStyle(fontSize: 16.0, height: 0.5, color: Colors.grey[500]),
            prefixIcon: icon,
            suffixIcon: sufIcon,
            helperText: helpertext,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
