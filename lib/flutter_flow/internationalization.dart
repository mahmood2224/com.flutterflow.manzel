import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations);

  static List<String> languages() => ['en', 'ar'];

  String get languageCode => locale.languageCode;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.languageCode] ?? '';

  String getVariableText({
    String enText = '',
    String arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      FFLocalizations.languages().contains(locale.languageCode);

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // Login
  {
    'cp1d00ba': {
      'en': 'Enter your mobile number',
      'ar': 'أدخل رقم هاتفك المحمول',
    },
    '364dhoh3': {
      'en':
          'We\'ll send a verification code to your number so \nyou can login or create an account',
      'ar': 'سنرسل رمز التحقق إلى رقمك حتى تتمكن من تسجيل الدخول أو إنشاء حساب',
    },
    '4m2r1iwr': {
      'en': 'Mobile Number',
      'ar': 'رقم الهاتف المحمول',
    },
    'f4tpckti': {
      'en': '+966',
      'ar': '+966',
    },
    '11ilbwge': {
      'en': '+966',
      'ar': '+966',
    },
    'gr1za5xy': {
      'en': 'By clicking continue, you agree to our ',
      'ar': 'بالنقر فوق متابعة ، فإنك توافق على',
    },
    '5t0jhzug': {
      'en': 'terms & conditions',
      'ar': 'الشروط والأحكام وسياسة الخصوصية',
    },
    '5ard5tmn': {
      'en': ' & ',
      'ar': 'الشروط والأحكام وسياسة الخصوصية',
    },
    'irbrz9hi': {
      'en': 'privacy policy',
      'ar': 'الشروط والأحكام وسياسة الخصوصية',
    },
    'l3ozn1az': {
      'en': 'Continue',
      'ar': 'متابعة',
    },
    '5q8adg81': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // OnboardingView
  {
    '0rkg3m44': {
      'en': 'The perfect choice for \nyour future home',
      'ar': 'الخيار الأمثل لمنزلك المستقبلي',
    },
    'bl6z0bqv': {
      'en': 'The perfect choice for \nyour future home',
      'ar': 'الخيار الأمثل لمنزلك المستقبلي',
    },
    't9rvb8ym': {
      'en': 'The perfect choice for \nyour future home',
      'ar': 'الخيار الأمثل لمنزلك المستقبلي',
    },
    'bgkoinqg': {
      'en': 'Get Started ',
      'ar': 'البدء',
    },
    'ua0lzucz': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
    },
    '1poahrm7': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // ConfirmOTP
  {
    '19xaosk5': {
      'en': 'Confirm your mobile number',
      'ar': 'قم بتأكيد رقم هاتفك المحمول',
    },
    'pgz55f9t': {
      'en': 'We\'ve sent you a 6 digital code via SMS to ',
      'ar': 'لقد أرسلنا لك 6 رموز رقمية عبر رسالة نصية قصيرة إلى',
    },
    '4ndu996h': {
      'en': 'Enter the OTP number',
      'ar': 'أدخل رقم التحقق',
    },
    'lbqhlsdp': {
      'en': 'Continue',
      'ar': 'متابعة',
    },
    'gkcoxytt': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // Profile
  {
    'zpi4cs66': {
      'en': 'Account',
      'ar': 'الحساب',
    },
    '9iofccrl': {
      'en': 'Personal info',
      'ar': 'المعلومات الشخصية',
    },
    '0qus6h1d': {
      'en': 'Payment & Cards',
      'ar': 'الدفع والبطاقات',
    },
    'vjemd3mv': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
    },
    'f0scnkco': {
      'en': 'Help & Support',
      'ar': 'المساعدة و الدعم',
    },
    '6mgqpd1r': {
      'en': 'Language',
      'ar': 'اللغة',
    },
    'u8ivo1rr': {
      'en': 'FAQ',
      'ar': 'الأسئلة الشائعة',
    },
    'ltqtegrk': {
      'en': 'Help Center',
      'ar': 'مركز المساعدة',
    },
    'hyxsohqj': {
      'en': 'About manzel',
      'ar': 'عن منزل',
    },
    'n8o0zh47': {
      'en': 'Terms & Conditions',
      'ar': 'البنود و الشروط',
    },
    '2csoqw0t': {
      'en': 'Logout',
      'ar': 'تسجيل خروج',
    },
    'qhxlmijh': {
      'en': 'App bulid 2.1.1 (231)',
      'ar': 'مجمع التطبيق 2.1.1 (231)',
    },
    'umgvt8b8': {
      'en': 'Profile',
      'ar': 'الملف الشخصي',
    },
  },
  // AddingInformation
  {
    '3zqs9v1q': {
      'en': 'Add your information',
      'ar': 'أضف معلوماتك',
    },
    'yi3j31m9': {
      'en': 'Full name',
      'ar': 'الاسم الكامل',
    },
    'dr5dq8mr': {
      'en': 'By clicking continue, you agree to our',
      'ar': 'بالنقر فوق متابعة ، فإنك توافق على',
    },
    't1oedq2h': {
      'en': 'terms & conditions & privacy policy',
      'ar': 'الشروط والأحكام وسياسة الخصوصية',
    },
    'fnkwu8bx': {
      'en': 'Continue',
      'ar': 'متابعة',
    },
    '1cb69bnh': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // TermsConditions
  {
    'tw2xsj9g': {
      'en': 'Terms & Conditions',
      'ar': 'البنود و الشروط',
    },
    'yiyc7r9g': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // EditPersonallInfo
  {
    'w7fbktqj': {
      'en': 'Edit Personal Info',
      'ar': 'تحرير المعلومات الشخصية',
    },
    'lrqyceei': {
      'en': 'Full name',
      'ar': 'الاسم الكامل',
    },
    '9gp42g0b': {
      'en': 'Your name',
      'ar': 'اسمك',
    },
    'vxe1d85b': {
      'en': 'Email',
      'ar': 'البريد الإلكتروني',
    },
    'mgxrufe9': {
      'en': 'Email',
      'ar': 'البريد الإلكتروني',
    },
    'kpcecp9o': {
      'en': 'Mobile number',
      'ar': 'رقم الهاتف المحمول',
    },
    'lbyulmrk': {
      'en': 'Edit',
      'ar': 'تعديل',
    },
    '91pyvwfe': {
      'en': 'Save changes',
      'ar': 'احفظ التغييرات',
    },
    'x4a06mk8': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // EditMobileNumber
  {
    '095f9xno': {
      'en': 'Edit mobile number',
      'ar': 'تغيير رقم الهاتف المحمول',
    },
    '4eszxwjq': {
      'en':
          'We\'ll send a verification code to your new number when modification is confirmed',
      'ar': 'سنرسل رمز التحقق إلى رقمك الجديد لتأكيد التعديل',
    },
    'por97wlv': {
      'en': 'Mobile Number',
      'ar': 'رقم الهاتف المحمول',
    },
    'dkoyvgce': {
      'en': '+966',
      'ar': '+966',
    },
    'v8y7fwba': {
      'en': 'Continue',
      'ar': 'متابعة',
    },
    'piivs0xr': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // ConfirmNewNumberOTP
  {
    'nzqyszrd': {
      'en': 'Confirm your mobile number',
      'ar': 'قم بتأكيد رقم هاتفك المحمول',
    },
    '0qmluaen': {
      'en': 'We\'ve sent you a 6 digital code via SMS to ',
      'ar': 'لقد أرسلنا لك 6 رموز رقمية عبر رسالة نصية قصيرة إلى',
    },
    '3c5hrl5f': {
      'en': 'Enter the OTP number',
      'ar': 'أدخل رقم التحقق',
    },
    'f1zsgncf': {
      'en': 'Continue',
      'ar': 'متابعة',
    },
    'qgqzw5o6': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // HomeScreen
  {
    'waavnvd4': {
      'en': '1',
      'ar': '1',
    },
    'qnr0o42y': {
      'en': 'Where are you looking?',
      'ar': 'أين تنظر؟',
    },
    'fei6w05f': {
      'en': 'Sort By',
      'ar': '',
    },
    '29sok3od': {
      'en': 'Near to me',
      'ar': '',
    },
    'etpebw43': {
      'en': 'Approved Banks',
      'ar': '',
    },
    'efcxmcgl': {
      'en': ', ',
      'ar': '،',
    },
    '998is2ya': {
      'en': 'Installment starting from',
      'ar': 'القسط يبدأ من',
    },
    'gqe4w739': {
      'en': 'Total property price',
      'ar': 'القسط يبدأ من',
    },
    'l38if619': {
      'en': ' SAR/Monthly',
      'ar': 'ريال سعودي / شهري',
    },
    'dhoik8q5': {
      'en': ' SAR',
      'ar': 'ريال سعودي',
    },
    'd9p577jz': {
      'en': 'Explore',
      'ar': 'اكتشف',
    },
  },
  // Notifications
  {
    'azq2kgbb': {
      'en':
          'A new proposal received from  Al Rajhi Bank to your booking  “Almajdiah Apartment“',
      'ar': 'تم استلام عرض جديد من مصرف الراجحي لحجزك \"شقة الماجدية\" ',
    },
    'muysw2pl': {
      'en': 'Today',
      'ar': 'اليوم',
    },
    'nm3bcvix': {
      'en': 'Notifications',
      'ar': 'إشعارات',
    },
    'mvocppdr': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // Filter
  {
    'b8bqw4hw': {
      'en': 'City',
      'ar': 'مدينة',
    },
    '1cqnd28g': {
      'en': 'Riyadh',
      'ar': 'الرياض',
    },
    'ka7r97er': {
      'en': 'Jeddah',
      'ar': '',
    },
    'fwphp18w': {
      'en': 'Mecca',
      'ar': '',
    },
    'xagmgkfm': {
      'en': 'Dubai',
      'ar': '',
    },
    'le1j7gvf': {
      'en': 'Select City',
      'ar': 'اختر مدينة',
    },
    'n51panna': {
      'en': 'Type',
      'ar': 'نوع',
    },
    'rtp5z5fb': {
      'en': 'All',
      'ar': 'الجميع',
    },
    '6oes70ac': {
      'en': 'House',
      'ar': 'منزل',
    },
    'zhs5gh3i': {
      'en': 'Apartment',
      'ar': 'شقة',
    },
    '3g790jsh': {
      'en': 'Flat',
      'ar': 'مسطحة',
    },
    '9c20unp8': {
      'en': 'Town house',
      'ar': '',
    },
    '378fpsns': {
      'en': 'Mansion',
      'ar': '',
    },
    '2jdd174j': {
      'en': 'All',
      'ar': 'الجميع',
    },
    '4mz2rd2p': {
      'en': 'Installment Range',
      'ar': 'نطاق التقسيط',
    },
    '2m2ni5iy': {
      'en': 'Furnishing',
      'ar': 'مفروشة',
    },
    'p4ffui1h': {
      'en': 'All',
      'ar': 'الجميع',
    },
    'jrw6qvww': {
      'en': 'Furnishing',
      'ar': 'مفروشة',
    },
    'skyj7jpv': {
      'en': 'Un-Furnishing',
      'ar': 'غير مفروشة',
    },
    '8x7rkqnv': {
      'en': 'Semi-Furnished',
      'ar': '',
    },
    '7fpsv2qy': {
      'en': 'All',
      'ar': 'الجميع',
    },
    'dgzjfbdt': {
      'en': 'Show  Properties',
      'ar': 'إظهار الخصائص',
    },
    'h84toi7e': {
      'en': 'Reset',
      'ar': 'إعادة',
    },
    'hy8565b9': {
      'en': 'Filter',
      'ar': 'فرز',
    },
    '5wfrx94q': {
      'en': 'Home',
      'ar': 'مسكن',
    },
  },
  // MyProperties
  {
    '21gpsvgr': {
      'en': 'My Properties',
      'ar': 'ممتلكاتي',
    },
    '6silbaqf': {
      'en': 'Login',
      'ar': 'تسجيل الدخول',
    },
    'gl02050s': {
      'en': 'Purchased',
      'ar': 'محجوز',
    },
    'tu9ytzrl': {
      'en': 'Booking ref: ',
      'ar': 'مرجع الحجز:',
    },
    'kdwkp7d8': {
      'en': ' ,',
      'ar': ' ،',
    },
    'a2yvcqcr': {
      'en': 'View Details',
      'ar': 'عرض التفاصيل',
    },
    'mt7pfmk1': {
      'en': 'Reserved',
      'ar': 'حجز',
    },
    'ry827uul': {
      'en': 'Booking ref: ',
      'ar': 'مرجع الحجز:',
    },
    'tjiw2bkf': {
      'en': ' ,',
      'ar': ' ،',
    },
    'zypmgjph': {
      'en': 'View Details',
      'ar': 'عرض التفاصيل',
    },
    '4uvlncbs': {
      'en': 'Saved',
      'ar': 'مفضلة',
    },
    'j1mv6jzk': {
      'en': ' ,',
      'ar': ' ،',
    },
    'lhqoha7d': {
      'en': 'My Properties',
      'ar': 'ممتلكاتي',
    },
  },
  // WhereAreYouLooking
  {
    'o5kmjt96': {
      'en': 'Where are you looking?',
      'ar': 'أين تبحث؟',
    },
    'nu1b6t0o': {
      'en': 'Riyadh',
      'ar': '',
    },
    '8po9ixlq': {
      'en': 'Where are you looking?',
      'ar': 'أين تبحث؟',
    },
    'fce9ky0f': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // PropertyDetails
  {
    'ak0ss5un': {
      'en': 'Updated: ',
      'ar': 'محدث:',
    },
    'kqc4ney0': {
      'en': 'Property manage by ',
      'ar': 'إدارة الممتلكات عن طريق',
    },
    '73rcbvl6': {
      'en': ', ',
      'ar': '،',
    },
    'd1l98zzs': {
      'en': ' Bedrooms',
      'ar': 'غرف نوم',
    },
    'swyvkhf5': {
      'en': ' sqm',
      'ar': 'متر مربع',
    },
    'gqq478h5': {
      'en': ' Bathrooms',
      'ar': 'الحمامات',
    },
    '7xi05192': {
      'en': ' Years',
      'ar': 'سنوات',
    },
    'u0xq15h6': {
      'en': ' Livingrooms',
      'ar': 'غرف المعيشة',
    },
    'nq19lw60': {
      'en': 'Features and Amenities',
      'ar': 'الميزات والمرافق',
    },
    '6brswcwm': {
      'en': 'Ref no.',
      'ar': 'مصدر رقم.',
    },
    'ku7u4p9w': {
      'en': 'Floors',
      'ar': 'عدد الطوابق',
    },
    'vrdckjrg': {
      'en': 'Furnishing type',
      'ar': 'نوع التأثيث',
    },
    'fk1mf2ip': {
      'en': 'Street width',
      'ar': 'عرض الشارع',
    },
    'e52iigjz': {
      'en': 'Total Price',
      'ar': 'السعر الكلي',
    },
    'fobsike6': {
      'en': 'Supported Banks',
      'ar': 'البنوك الداعمة',
    },
    '1v1r516t': {
      'en': 'More Details',
      'ar': 'المزيد من التفاصيل',
    },
    '8fdy3f5a': {
      'en': 'Location',
      'ar': 'موقع',
    },
    'i17ddd6l': {
      'en': 'Installment starting from',
      'ar': 'القسط يبدأ من',
    },
    'mgi2d0o9': {
      'en': 'SAR/Monthly',
      'ar': ' ريال سعودي / شهري',
    },
    'dpmrt150': {
      'en': 'Reserve',
      'ar': 'محجوز',
    },
  },
  // bankDetails
  {
    'fohz964z': {
      'en': 'Close',
      'ar': 'اغلق',
    },
    'ng6azmpt': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // ReservationConfirmation
  {
    'hc6is5tp': {
      'en': 'Reservation confirmation',
      'ar': 'تأكيد الحجز',
    },
    'plhqknku': {
      'en':
          'To confirm the reservation, you need to pay an administration fee. By confirming payment, you agree to our terms & conditions ',
      'ar':
          'لتأكيد الحجز ، يتعين عليك دفع رسوم إدارية. بتأكيد الدفع ، فإنك توافق على الشروط والأحكام الخاصة بنا',
    },
    'jwz7tx3y': {
      'en': 'Reservation cost',
      'ar': 'تكلفة الحجز',
    },
    'lrvnkupp': {
      'en': ' SAR',
      'ar': 'ريال سعودي',
    },
    'a57p0brt': {
      'en': 'Note: Reservation cost is non-refundable ',
      'ar': 'ملاحظة: تكلفة الحجز غير قابلة للاسترداد',
    },
    'ls77bs9d': {
      'en': 'Select Payment Method',
      'ar': 'اختار طريقة الدفع',
    },
    'yzl0bppo': {
      'en': 'Mada/Visa ',
      'ar': 'مدى / فيزا',
    },
    '54vch0v9': {
      'en': 'ApplePay',
      'ar': 'ApplePay',
    },
    '8j5d0340': {
      'en': 'Pay',
      'ar': 'ادفع',
    },
    's7jia86m': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // Confirmation
  {
    'fnewib0l': {
      'en': 'Your Booking Confirmed',
      'ar': 'تم تأكيد حجزك',
    },
    'is83qb7v': {
      'en': 'Booking ref: ',
      'ar': 'مرجع الحجز:',
    },
    '8ptcdhhd': {
      'en': 'Property details',
      'ar': 'تفاصيل الملكية ',
    },
    '4qmvz3gw': {
      'en': ' ,',
      'ar': 'و',
    },
    '514bcidn': {
      'en': 'Transaction details',
      'ar': 'تفاصيل الصفقه',
    },
    'g7t2uz7u': {
      'en': 'Transaction Ref.',
      'ar': 'مرجع المعاملة.',
    },
    '48t9kq7r': {
      'en': '#29877de2887',
      'ar': '# 29877de2887',
    },
    'nfajktl1': {
      'en': 'Payment Method',
      'ar': 'طريقة الدفع او السداد',
    },
    'xihd37di': {
      'en': 'Amount',
      'ar': 'المبلغ',
    },
    's1mfpoki': {
      'en': 'Date & Time',
      'ar': 'التاريخ والوقت',
    },
    'a5vxpwan': {
      'en': 'View Receipt Transaction',
      'ar': 'عرض إيصال المعاملة',
    },
    '4s4pqyjw': {
      'en': 'View Booking Details',
      'ar': 'عرض تفاصيل الحجز',
    },
    'dla66jhs': {
      'en': 'Back to Home',
      'ar': 'العودة إلى الصفحة الرئيسية',
    },
    'jdsnk395': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // OrderDetails
  {
    'obc5bmtb': {
      'en': 'Riyadh, Alyasmeen',
      'ar': 'الرياض الياسمين',
    },
    'dghbf6mg': {
      'en': 'View Property Details',
      'ar': 'عرض تفاصيل الملكية',
    },
    '6on06i4j': {
      'en': 'Order Process',
      'ar': 'مراحل الطلب',
    },
    'nkd2c7wt': {
      'en': 'Reservation & Payment Confirmed',
      'ar': 'تأكيد الحجز والدفع',
    },
    'l5s89kan': {
      'en': 'Send deal to Banks',
      'ar': 'أرسل الصفقة إلى البنوك',
    },
    'mll46yo8': {
      'en': 'Completing Documents',
      'ar': 'استكمال المستندات',
    },
    'dm8dxmsv': {
      'en': 'Upload Documents',
      'ar': 'تحميل المستندات',
    },
    'hojjvz6d': {
      'en': 'Get banks proposals',
      'ar': 'احصل على مقترحات البنوك',
    },
    'oqjt6apm': {
      'en': 'Close Deal',
      'ar': 'انتهت الصفقة',
    },
    '07sk94co': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // KYC
  {
    'q70051st': {
      'en': 'Identity verification',
      'ar': 'التحقق من الهوية',
    },
    'znz2idhe': {
      'en':
          'To confirm your booking we need to collect some information from you to fulfill our regulatory obligations.',
      'ar':
          'لتأكيد حجزك ، نحتاج إلى جمع بعض المعلومات منك للوفاء بالتزاماتنا التنظيمية.',
    },
    '6sbw69l9': {
      'en': 'Absher verification',
      'ar': 'التحقق من تطبيق أبشر',
    },
    'iatzsuhm': {
      'en': 'Verified',
      'ar': 'تم التحقق',
    },
    'rc0wawsq': {
      'en': 'Personal & Employment Details',
      'ar': 'البيانات الشخصية والتوظيفية',
    },
    'bcujyzy2': {
      'en': 'An offical proof of adderss',
      'ar': 'دليل رسمي من adders',
    },
    'eck1dxoe': {
      'en': 'Continue',
      'ar': 'المتابعة',
    },
    'jjmf6n0e': {
      'en': 'I’ll do this later',
      'ar': 'سأفعل هذا لاحقًا',
    },
    'rxkp23bz': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // AbsherVerification
  {
    'rtnjo9zy': {
      'en': 'Absher Verification',
      'ar': 'التحقق من أبشر',
    },
    'ch5dgyyj': {
      'en': 'Absher Verification',
      'ar': 'التحقق من أبشر',
    },
    '820iwo6l': {
      'en':
          'To verify your identity, you should be registered in Absher first.',
      'ar': 'للتحقق من هويتك ، يجب أن تكون مسجلاً في أبشر أولاً.',
    },
    'sagsx4yq': {
      'en': 'ID Number',
      'ar': 'رقم الهوية',
    },
    'qpey20he': {
      'en': 'Birthday',
      'ar': 'يوم الميلاد',
    },
    's2h8gxw5': {
      'en': 'Continue',
      'ar': 'يكمل',
    },
    'ty5u3tc8': {
      'en': 'Home',
      'ar': 'مسكن',
    },
  },
  // ConfirmAbsher
  {
    'qh014cm1': {
      'en': 'Absher Verification',
      'ar': 'التحقق من أبشر',
    },
    'jbeldlu4': {
      'en': 'OTP Absher',
      'ar': 'رمز التحقق من أبشر',
    },
    't6diss1v': {
      'en': 'We\'ve sent you a 6 digital code via SMS to ',
      'ar': 'لقد أرسلنا لك 6 رموز رقمية عبر رسالة نصية قصيرة إلى',
    },
    '8b44886a': {
      'en': 'Enter the OTP number',
      'ar': 'أدخل رقم التحقق',
    },
    'd7rdpmot': {
      'en': 'Continue',
      'ar': 'متابعة',
    },
    'wcja92zr': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // PersonalEmploymentDetails
  {
    '56kjw7e5': {
      'en': 'Personal & Employment Details',
      'ar': 'البيانات الشخصية والتوظيفية',
    },
    '8gduxe32': {
      'en':
          'We need to collect some information from you to fulfill our regulatory obligations. Don\'t worry your information is stored safely',
      'ar':
          'نحتاج إلى جمع بعض المعلومات منك للوفاء بالتزاماتنا التنظيمية. لا تقلق ، يتم تخزين معلوماتك بأمان',
    },
    '3pne660j': {
      'en': 'Personal details',
      'ar': 'تفاصيل شخصية',
    },
    'f40bwimn': {
      'en': 'Full Name',
      'ar': 'الاسم الكامل',
    },
    'rypubckx': {
      'en': 'Email',
      'ar': 'البريد الإلكتروني',
    },
    'm513rsgp': {
      'en': 'Employment details',
      'ar': 'تفاصيل العمل',
    },
    'pky5i3u5': {
      'en': '2000 - 5000 SAR',
      'ar': '2000-5000 ريال سعودي',
    },
    '1ucut902': {
      'en': '5000 - 10000 SAR',
      'ar': '5000-10000 ريال سعودي',
    },
    'tiwdj1lc': {
      'en': '10000 - 30000 SAR',
      'ar': '10000 - 30000 ريال سعودي',
    },
    'r31pneec': {
      'en': 'Monthly income',
      'ar': 'الدخل الشهري',
    },
    'ueg5zdc6': {
      'en': 'Private Sector',
      'ar': 'القطاع الخاص',
    },
    'rbeky186': {
      'en': 'Private Sector',
      'ar': 'القطاع الخاص',
    },
    'yfeu3no3': {
      'en': 'Goverment sector',
      'ar': 'قطاع الحكومة',
    },
    'tli98cm2': {
      'en': 'Hafiz',
      'ar': 'حافز',
    },
    'yfkb666m': {
      'en': 'Retired',
      'ar': 'متقاعد',
    },
    'v1163114': {
      'en': 'Self Employment',
      'ar': 'العمل الحر',
    },
    '1fyb88yc': {
      'en': 'Student',
      'ar': 'طالب',
    },
    '5vzz34pm': {
      'en': 'Unemployed',
      'ar': 'عاطل عن العمل',
    },
    '35o1hqb9': {
      'en': 'Employment status',
      'ar': 'الحالة الوظيفية',
    },
    '730iu6wb': {
      'en': 'AlRajhi Bank',
      'ar': 'مصرف الراجحي',
    },
    'zmhh0w3q': {
      'en': 'Alinma Bank',
      'ar': 'مصرف الإنماء',
    },
    '4h360xlf': {
      'en': 'Alahli Bank',
      'ar': 'البنك الاهلي',
    },
    'omiqb5pp': {
      'en': 'SAAB Bank',
      'ar': 'بنك ساب',
    },
    'jfgvqahn': {
      'en': 'Salary bank',
      'ar': 'بنك الراتب',
    },
    'araxruq2': {
      'en': 'Does the Sakani loan cover you?',
      'ar': 'هل القرض السكني يغطيك؟',
    },
    '7adrd83m': {
      'en': 'Yes',
      'ar': 'نعم',
    },
    'q1kks67n': {
      'en': 'No',
      'ar': 'لا',
    },
    'u22s8pus': {
      'en': 'Continue',
      'ar': 'المتابعة',
    },
    'r2cco6t4': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // FilterCopy
  {
    'bfc0jvhc': {
      'en': 'City',
      'ar': 'مدينة',
    },
    '1snf3qye': {
      'en': 'Riyadh',
      'ar': 'الرياض',
    },
    '5kec6c0m': {
      'en': 'Select City',
      'ar': 'اختر مدينة',
    },
    '1xtsbq2y': {
      'en': 'Type',
      'ar': 'نوع',
    },
    'rnc35lnt': {
      'en': 'All',
      'ar': 'الجميع',
    },
    'ducpx83i': {
      'en': 'House',
      'ar': 'منزل',
    },
    'fqnjkv6g': {
      'en': 'Apartment',
      'ar': 'شقة',
    },
    '0pjvwkk1': {
      'en': 'Flat',
      'ar': 'مسطحة',
    },
    'qhz0rrjr': {
      'en': 'All',
      'ar': 'الجميع',
    },
    'f872j8ol': {
      'en': 'All',
      'ar': 'الجميع',
    },
    '6xt16jt5': {
      'en': 'Installment Range',
      'ar': 'نطاق التقسيط',
    },
    '8ozjkl8w': {
      'en': 'Furnishing',
      'ar': 'مفروشة',
    },
    'o1h78xn1': {
      'en': 'All',
      'ar': 'الجميع',
    },
    '5sipykmn': {
      'en': 'Furnishing',
      'ar': 'مفروشة',
    },
    'emup7poc': {
      'en': 'Un-Furnishing',
      'ar': 'غير مفروشة',
    },
    'kgidgtfz': {
      'en': 'All',
      'ar': 'الجميع',
    },
    '3tmmjthp': {
      'en': 'Show  Properties',
      'ar': 'إظهار الخصائص',
    },
    '9wjco7f5': {
      'en': 'Reset',
      'ar': 'إعادة',
    },
    '4r6li7uf': {
      'en': 'Filter',
      'ar': 'فرز',
    },
    '9xztb8ua': {
      'en': 'Home',
      'ar': 'مسكن',
    },
  },
  // NotFoundPage
  {
    'gmbuwmld': {
      'en': 'No Result Found',
      'ar': 'لم يتم العثور على نتائج',
    },
  },
  // Miscellaneous
  {
    'uc1oksun': {
      'en': '',
      'ar': '',
    },
    '1q6kv0ag': {
      'en': '',
      'ar': '',
    },
    'hfba8ghq': {
      'en': '',
      'ar': '',
    },
    'iswxm5h0': {
      'en': '',
      'ar': '',
    },
    'nu2t0b0f': {
      'en': '',
      'ar': '',
    },
    'jsle1mmd': {
      'en': '',
      'ar': '',
    },
    '9xs0c7u8': {
      'en': '',
      'ar': '',
    },
    '9z16oone': {
      'en': '',
      'ar': '',
    },
    'fem3d7jn': {
      'en': '',
      'ar': '',
    },
    '6qutc3px': {
      'en': '',
      'ar': '',
    },
    'j7s33te0': {
      'en': '',
      'ar': '',
    },
    '8iccyr2w': {
      'en': '',
      'ar': '',
    },
    'z44qufyb': {
      'en': '',
      'ar': '',
    },
    'hbhjpb56': {
      'en': '',
      'ar': '',
    },
    'yhdnkgh9': {
      'en': '',
      'ar': '',
    },
    'ryrf4mu9': {
      'en': '',
      'ar': '',
    },
    'tgrrw1pg': {
      'en': '',
      'ar': '',
    },
    'ny2h6j0x': {
      'en': '',
      'ar': '',
    },
    'e79jfteg': {
      'en': '',
      'ar': '',
    },
    'igfljhsl': {
      'en': '',
      'ar': '',
    },
  },
].reduce((a, b) => a..addAll(b));
