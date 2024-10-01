import 'package:flutter/services.dart';

import '../../constants/constant_exports.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    TextEditingController? controller,
    this.initialValue,
    this.obscureText = false,
    this.onChanged,
    this.onTap,
    this.filled = false,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.suffixIconColor,
    this.suffixIconSize,
    this.suffixIconConstraints,
    this.errorText,
    this.errorStyle,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.isDense = true,
    this.readOnly = false,
    this.alignLabelWithText,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.border,
    this.contentPadding,
    this.contentStyle,
    this.enabled = true,
    this.validator,
    this.cursorColor,  // New cursorColor property
    this.inputFormatters,
  })  : _controller = controller,
        super(key: key);

  final TextEditingController? _controller;
  final String? initialValue;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final BoxConstraints? suffixIconConstraints;
  final String? errorText;
  final TextStyle? errorStyle;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final bool isDense;
  final bool readOnly;
  final bool? alignLabelWithText;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentStyle;
  final Color? cursorColor;
  final String? Function(String?)? validator;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Material(
          borderRadius: BorderRadius.circular(8),
          child: TextFormField(
            focusNode: _focusNode,
            enabled: widget.enabled,
            initialValue: widget.initialValue,
            obscureText: _obscureText,
            cursorColor: widget.cursorColor ?? MathColorTheme().green,  // Set cursor color here
            decoration: InputDecoration(
              filled: widget.filled,
              fillColor: widget.fillColor,
              border: widget.border,
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: MathColorTheme().white,
                ),
              ),
              enabledBorder: widget.enabledBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: MathColorTheme().neutral200,  // Default border color
                    ),
                  ),
              focusedBorder: widget.focusedBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: MathColorTheme().green,  // Active border color
                      width: 2.0,  // Increase the width for active state
                    ),
                  ),
              errorBorder: widget.errorBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
              focusedErrorBorder: widget.focusedErrorBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.red),
                  ),
              errorText: widget.errorText,
              errorStyle: widget.errorStyle,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ??
                  MathTextTheme()
                      .subtext
                      .copyWith(color: MathColorTheme().neutral400),
              isDense: widget.isDense,
              suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              contentPadding: widget.contentPadding ??
                  const EdgeInsets.fromLTRB(16, 16, 16, 16),
              suffixIconConstraints: widget.suffixIconConstraints,
              labelText: widget.labelText,
              labelStyle: widget.enabled
                  ? widget.labelStyle ?? MathTextTheme().subtext
                  : MathTextTheme()
                  .subtext
                  .copyWith(color: MathColorTheme().neutral400),
              alignLabelWithHint: widget.alignLabelWithText,
            ),
            onTap: widget.onTap,
            readOnly: widget.readOnly,
            keyboardType: widget.keyboardType,
            controller: widget._controller,
            onChanged: widget.onChanged,
            validator: widget.validator,
            style: widget.contentStyle ?? MathTextTheme().subtext,
            maxLines: widget.maxLines,
            minLines: widget.minLines,
            inputFormatters: widget.inputFormatters,
          ),
        ),
        if (widget.obscureText)
          IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: MathColorTheme().neutral900,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
      ],
    );
  }
}
