import 'package:flutter/material.dart';

class CustomSuccessDialog extends StatelessWidget {
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;

  const CustomSuccessDialog({
    super.key,
    required this.message,
    this.buttonText = 'OK',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.check_circle_outline,
        color: Colors.green,
        size: 60,
      ),
      title: const Text(
        'Success',
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