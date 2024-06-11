import 'package:flutter/material.dart';

class TextfieldWidget extends StatefulWidget {
  final String text;
  final IconData icon;
  final bool? obscureText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const TextfieldWidget({
    Key? key,
    required this.text,
    required this.icon,
    this.obscureText = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  late bool _showError;
  late String _errorMessage;
  late bool _isPasswordVisible;

  @override
  void initState() {
    super.initState();
    _showError = false;
    _errorMessage = '';
    _isPasswordVisible = false;
  }

  // Method to toggle password visibility
  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: _showError ? Colors.red : Colors.transparent,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: widget.obscureText! && !_isPasswordVisible,
            onChanged: (value) {
              setState(() {
                _showError = widget.validator != null && widget.validator!(value) != null;
                _errorMessage = widget.validator != null ? widget.validator!(value) ?? '' : '';
              });
            },
            style: const TextStyle(
              fontFamily: "Zen Kaku Gothic Antique",
            ),
            cursorColor: const Color(0xFF19b888),
            decoration: InputDecoration(
              hintText: widget.text,
              hintStyle: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Colors.grey,
                fontSize: 13,
              ),
              suffixIcon: widget.icon == Icons.lock ? Padding(
                padding: const EdgeInsets.only(right: 20), // Adjust the padding from the right here
                child: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.lock_open_outlined : Icons.lock,
                    color: const Color(0xFF19b888),
                  ),
                  onPressed: _togglePasswordVisibility,
                ),
              ) : Padding(
                padding: const EdgeInsets.only(right: 30),
                child: Icon(
                  widget.icon,
                  color: const Color(0xFF19b888),
                ),
              ),
              border: InputBorder.none,
              errorText: _showError ? null : null,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 26.0,
                vertical: 23.0,
              ),
            ),
          ),
        ),
        if (_showError)
          Padding(
            padding: const EdgeInsets.only(top: 8.0,left: 20),
            child: Text(
                _errorMessage,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    color: Colors.red
                )
            ),
          ),
      ],
    );
  }
}
