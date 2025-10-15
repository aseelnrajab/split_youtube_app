// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'YouTube + Live Camera';

  @override
  String get enableCamera => 'Enable Camera';

  @override
  String get hideCamera => 'Hide Camera';

  @override
  String get showCamera => 'Show Camera';

  @override
  String get noCameraDetected => 'No available camera detected';

  @override
  String get cameraPermissionDenied => 'Camera permission denied';

  @override
  String get cameraPermissionNeeded => 'Camera Permission Needed';

  @override
  String get cameraPermissionDescription => 'Camera access has been permanently denied.\n\nPlease enable it manually in Settings → Privacy → Camera.';

  @override
  String get cancel => 'Cancel';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get cameraInitError => 'Camera initialization error:';

  @override
  String get noSecondaryCamera => 'No secondary camera found';

  @override
  String get switchCam => 'Swap Camera';
}
