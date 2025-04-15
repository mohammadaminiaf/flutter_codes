import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum StyleType { bordered, underline }

class OTPTextField extends StatefulWidget {
  final double spacing;

  final int length;
  final StyleType styleType;
  final double borderWidth;
  final Color borderColor;
  final Color focusBorderColor;
  final TextStyle textStyle;
  final Function(String)? onComplete;
  final double? height;
  final double? width;

  const OTPTextField({
    super.key,
    this.length = 4,
    this.styleType = StyleType.bordered,
    this.onComplete,

    this.spacing = 8,
    this.borderWidth = 2,
    this.focusBorderColor = Colors.blue,
    this.borderColor = Colors.grey,
    this.height,
    this.width,
    this.textStyle = const TextStyle(
      color: Colors.blue,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
  }) : assert(length >= 4 && length <= 8, 'Length must be between 4 and 8');

  @override
  State<OTPTextField> createState() => _OTPTextFieldState();
}

class _OTPTextFieldState extends State<OTPTextField> {
  List<TextEditingController> _controllers = [];
  List<FocusNode> _focusNodes = [];
  bool _isDisposed = false;

  @override
  void didUpdateWidget(OTPTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.length != widget.length) {
      // Dispose old controllers and nodes
      for (final controller in _controllers) {
        controller.dispose();
      }
      for (final node in _focusNodes) {
        node.dispose();
      }
      _controllers.clear();
      _focusNodes.clear();
      _initializeControllersAndFocusNodes();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeControllersAndFocusNodes();
  }

  void _initializeControllersAndFocusNodes() {
    _controllers = List.generate(
      widget.length,
      (index) => TextEditingController(),
    );
    _focusNodes = List.generate(widget.length, (index) => FocusNode());
  }

  InputDecoration _buildDecoration(int index) {
    switch (widget.styleType) {
      case StyleType.bordered:
        return InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: widget.borderColor,
              width: widget.borderWidth,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: widget.borderColor,
              width: widget.borderWidth / 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: widget.focusBorderColor,
              width: widget.borderWidth,
            ),
          ),
          counterText: '',
          contentPadding: EdgeInsets.zero,
        );
      case StyleType.underline:
        return InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
              width: widget.borderWidth,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: widget.focusBorderColor,
              width: widget.borderWidth,
            ),
          ),
          counterText: '',
        );
    }
  }

  void _handleChanged(String value, int index) {
    if (_isDisposed) return;
    if (value.isNotEmpty) {
      if (index < widget.length - 1) {
        FocusScope.of(context).nextFocus();
      }
      _checkComplete();
    } else if (index > 0) {
      FocusScope.of(context).previousFocus();
    }
  }

  void _checkComplete() {
    if (_isDisposed) return;
    final code = _controllers.map((c) => c.text).join();
    if (code.length == widget.length) {
      widget.onComplete?.call(code);
      // Dismiss keyboard
      FocusScope.of(context).unfocus();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    for (final controller in _controllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    _controllers.clear();
    _focusNodes.clear();
    super.dispose();
  }

  // Helper method to build a text field
  Widget _buildTextField(int index) {
    return TextField(
      controller: _controllers[index],
      focusNode: _focusNodes[index],
      textAlign: TextAlign.center,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(1),
      ],
      decoration: _buildDecoration(index),
      onChanged: (value) => _handleChanged(value, index),
      onSubmitted: (value) => _handleChanged(value, index),
      onEditingComplete: () => _checkComplete(),
      onTap:
          () =>
              _controllers[index].selection = TextSelection.collapsed(
                offset: _controllers[index].text.length,
              ),
      style: widget.textStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableWidth = constraints.maxWidth;
        final totalSpacing = widget.spacing * (widget.length - 1);
        final fieldWidth = (availableWidth - totalSpacing) / widget.length;
        
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.length, (index) {
            return Container(
              width: widget.width ?? fieldWidth,
              margin: EdgeInsets.only(left: index > 0 ? widget.spacing : 0),
              height: widget.height,
              child: _buildTextField(index),
            );
          }),
        );
      },
    );
  }
}
