import 'package:flutter/material.dart';

Future showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  required Function() confirmAction,
  String? confirmText,
  String? cancelText,
}) {
  return showDialog(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        content: Text(content),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text(cancelText ?? 'Cancel',
                  style: const TextStyle(color: Colors.red))),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              confirmAction();
            },
            child: Text(confirmText ?? 'Confirm',
                style: TextStyle(color: Colors.green.shade600)),
          )
        ],
      );
    },
  );
}
