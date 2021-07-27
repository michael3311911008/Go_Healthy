import 'package:flutter/material.dart';

class DefaultFormField extends StatefulWidget {
  final String labelText;
  final TextEditingController textEditingController;
  final String? hint;
  final Widget? icon;
  final bool isObscure;
  final FormFieldValidator<String>? validation;
  final TextInputType? inputType;
  const DefaultFormField({
    Key? key,
    required this.labelText,
    required this.textEditingController,
    this.hint,
    required this.icon,
    this.isObscure = false,
    this.validation,
    this.inputType,
  }) : super(key: key);

  @override
  _DefaultFormFieldState createState() => _DefaultFormFieldState();
}

class _DefaultFormFieldState extends State<DefaultFormField> {
  @override
  void initState() {
    isObscure = widget.isObscure;
    super.initState();
  }

  late bool isObscure;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: widget.textEditingController,
              obscureText: isObscure,
              validator: widget.validation,
              keyboardType: widget.inputType,
              decoration: InputDecoration(
                labelText: widget.labelText,
                hintText:
                    widget.hint ?? "please input your ${widget.labelText}",
                prefixIcon: widget.icon,
                border: OutlineInputBorder(),
                suffixIcon: widget.isObscure
                    ? IconButton(
                        icon: AnimatedContainer(
                          duration: Duration(milliseconds: 350),
                          child: isObscure
                              ? Icon(
                                  Icons.visibility_outlined,
                                  key: UniqueKey(),
                                )
                              : Icon(
                                  Icons.visibility_off_outlined,
                                  key: UniqueKey(),
                                ),
                        ),
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
