import 'package:flutter/material.dart';

class StoreNameDialog extends StatelessWidget {
  const StoreNameDialog({
    required this.textEditingController,
    this.onOk,
    this.onCancel,
    super.key,
  });

  final TextEditingController textEditingController;
  final VoidCallback? onOk;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: TextField(
        decoration: const InputDecoration(label: Text('Name')),
        controller: textEditingController,
      ),
      actions: [
        TextButton(
          onPressed: onCancel?.call,
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onOk?.call,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
