import 'package:flutter/material.dart';

class RadioButtonWidget extends StatelessWidget {
  final Widget radioButton;
  final String title;

  const RadioButtonWidget({Key key, this.radioButton, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [radioButton, Text(title)],
    );
  }
}

class AddressRadioButtonWidget extends StatelessWidget {
  final Widget radioButton;
  final String title;
  final Widget richTextField;
  FontWeight titleFontWeight = FontWeight.bold;

  AddressRadioButtonWidget(
      {Key key,
      this.radioButton,
      this.title,
      this.richTextField,
      this.titleFontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        radioButton,
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(fontWeight: titleFontWeight),
          ),
        ))
      ],
    );
  }
}
