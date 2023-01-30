import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/constants.dart';

class TextFormFieldForAddressing extends StatelessWidget {
  final Icon? icons;
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyBoardType;
  final List<TextInputFormatter>? formator;
  final int? maxLines;
  final int? maxLength;
  final String? Function(String?)? validator;

  const TextFormFieldForAddressing({
    Key? key,
    this.icons,
    required this.hintText,
    required this.controller,
    this.keyBoardType,
    this.formator,
    this.maxLength,
    this.maxLines,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      textCapitalization: TextCapitalization.words,
      smartQuotesType: SmartQuotesType.enabled,
      textInputAction: TextInputAction.next,
      cursorColor: primaryBackgroundColor,
      controller: controller,
      inputFormatters: formator,
      keyboardType: keyBoardType,
      maxLines: maxLines,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        counterStyle: const TextStyle(color: Colors.transparent),
        border: const OutlineInputBorder(),
        prefixIcon: icons,
        enabledBorder: const OutlineInputBorder(),
        hintText: hintText,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}
