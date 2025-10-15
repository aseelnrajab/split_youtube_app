import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../l10n/app_localizations.dart';

Future<bool> ensureCameraPermission(BuildContext context) async {
  var status = await Permission.camera.status;

  if (status.isDenied) {
    status = await Permission.camera.request();
  }

  if (status.isPermanentlyDenied) {
    _showPermissionDialog(context);
    return false;
  }

  if (!status.isGranted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context)!.cameraPermissionDenied),
      ),
    );
    return false;
  }

  return true;
}

void _showPermissionDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(AppLocalizations.of(context)!.cameraPermissionNeeded),
      content: Text(AppLocalizations.of(context)!.cameraPermissionDescription),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
        TextButton(
          onPressed: () {
            openAppSettings();
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.openSettings),
        ),
      ],
    ),
  );
}
