// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'يوتيوب + كاميرا مباشرة';

  @override
  String get enableCamera => 'تشغيل الكاميرا';

  @override
  String get hideCamera => 'إخفاء الكاميرا';

  @override
  String get showCamera => 'إظهار الكاميرا';

  @override
  String get noCameraDetected => 'لم يتم العثور على كاميرا متاحة';

  @override
  String get cameraPermissionDenied => 'تم رفض إذن الكاميرا';

  @override
  String get cameraPermissionNeeded => 'يتطلب إذن الكاميرا';

  @override
  String get cameraPermissionDescription => 'تم رفض الوصول إلى الكاميرا بشكل دائم.\n\nيرجى تفعيله يدويًا من الإعدادات → الخصوصية → الكاميرا.';

  @override
  String get cancel => 'إلغاء';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get cameraInitError => 'حدث خطأ أثناء تشغيل الكاميرا:';

  @override
  String get noSecondaryCamera => 'لم يتم العثور على كاميرا ثانية';

  @override
  String get switchCam => 'تبديل الكاميرا';
}
