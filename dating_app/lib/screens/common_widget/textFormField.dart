import 'package:dating_app/core/constants/color_constants.dart';
import 'package:dating_app/core/constants/path_constants.dart';
import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String title;
  final String placeholder;
  final String errorText;
  final bool obscureText;
  final bool isError;
  final TextEditingController? controller;
  final VoidCallback onTextChanged;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;

  const TextFieldWidget({
    required this.title,
    required this.placeholder,
    this.obscureText = false,
    this.isError = false,
    this.controller,
    required this.onTextChanged,
    required this.errorText,
    this.textInputAction = TextInputAction.done,
    this.keyboardType,
    Key? key,
  }) : super(key: key);

  @override
  _TextFieldWidgetState createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  final focusNode = FocusNode();
  bool stateObscureText = false;
  bool stateIsError = false;

  @override
  void initState() {
    super.initState();

    focusNode.addListener(
      () {
        setState(() {
          if (focusNode.hasFocus) {
            stateIsError = false;
          }
        });
      },
    );

    stateObscureText = widget.obscureText;
    stateIsError = widget.isError;
  }

  @override
  void didUpdateWidget(covariant TextFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    stateObscureText = widget.obscureText;
    stateIsError = focusNode.hasFocus ? false : widget.isError;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createHeader(),
          const SizedBox(height: 5),
          _createTextFieldStack(),
          if (stateIsError) ...[
            _createError(),
          ],
        ],
      ),
    );
  }

  Widget _createHeader() {
    return Text(
      widget.title,
      style: TextStyle(
        color: _getUserNameColor(),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Color _getUserNameColor() {
    if (focusNode.hasFocus) {
      return ColorConstants.primary;
    } else if (stateIsError) {
      return ColorConstants.errorColor;
    } else if (widget.controller!.text.isNotEmpty) {
      return ColorConstants.primary;
    }
    return ColorConstants.primary;
  }

  Widget _createTextFieldStack() {
    return Stack(
      children: [
        _createTextField(),
        if (widget.obscureText) ...[
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: _createShowEye(),
          ),
        ],
      ],
    );
  }

  Widget _createTextField() {
    return TextField(
      focusNode: focusNode,
      controller: widget.controller,
      obscureText: stateObscureText,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      style: const TextStyle(
        color: ColorConstants.textBlack,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 12, vertical: 10), // <-- Adjust height
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: stateIsError
                ? ColorConstants.errorColor
                : ColorConstants.textFieldBorder.withOpacity(0.4),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: ColorConstants.primary,
          ),
        ),
        hintText: widget.placeholder,
        hintStyle: const TextStyle(
          color: ColorConstants.grey,
          fontSize: 16,
        ),
        filled: true,
        fillColor: ColorConstants.textFieldBackground,
      ),
      onChanged: (text) {
        setState(() {});
        widget.onTextChanged();
      },
    );
  }

  Widget _createShowEye() {
    return GestureDetector(
      onTap: () {
        setState(() {
          stateObscureText = !stateObscureText;
        });
      },
      child: !stateObscureText
          ? Image(
              image: const AssetImage(
                PathConstants.eye,
              ),
              color: widget.controller!.text.isNotEmpty
                  ? ColorConstants.primary
                  : ColorConstants.grey,
            )
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image(
                height: 8,
                width: 25,
                image: const AssetImage(
                  PathConstants.closedEye,
                ),
                color: widget.controller!.text.isNotEmpty
                    ? ColorConstants.primary
                    : ColorConstants.grey,
              ),
            ),
    );
  }

  Widget _createError() {
    return Container(
      padding: const EdgeInsets.only(top: 2),
      child: Text(
        widget.errorText,
        style: const TextStyle(
          fontSize: 14,
          color: ColorConstants.errorColor,
        ),
      ),
    );
  }
}
