import 'package:flutter/material.dart';

class CustomErrorDialog extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;

  const CustomErrorDialog({
    super.key,
    required this.message,
    this.buttonText = 'OK',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 60,
      ),
      title: const Text(
        'Error',
        textAlign: TextAlign.center,
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed ?? () => Navigator.pop(context),
            child: Text(buttonText),
          ),
        ),
      ],
    );
  }
}