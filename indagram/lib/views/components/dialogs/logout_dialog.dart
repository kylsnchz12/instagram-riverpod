import 'package:flutter/material.dart';
import 'package:indagram/views/components/dialogs/alert_dialog_model.dart';

@immutable
class LogoutDialog extends AlertDialogModel<bool> {
  const LogoutDialog()
      : super(
            title: 'Log out',
            message: 'Are you sure you want to log out?',
            buttons: const {
              'Cancel': false,
              'Log out': true,
            });
}
