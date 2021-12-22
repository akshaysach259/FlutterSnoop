import 'package:flutter/material.dart';
import 'package:snoop/ui/Screens/Login/components/text_field_container.dart';


import '../../../constants.dart';

class RoundedTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController editingController;
  final ValueChanged<String> onChanged;
  final TextInputType inputType;
  const RoundedTextField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    @required this.editingController,
    this.inputType = TextInputType.text,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        keyboardType: inputType,
        controller: editingController,
        onChanged: onChanged,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
