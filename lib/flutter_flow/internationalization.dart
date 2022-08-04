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
          'We\'ll send a verification code to your number so you can login or create an account',
      'ar': 'سنرسل رمز التحقق إلى رقمك حتى تتمكن من تسجيل الدخول أو إنشاء حساب',
    },
    '4m2r1iwr': {
      'en': 'Mobile Number',
      'ar': 'رقم الهاتف المحمول',
    },
    'f4tpckti': {
      'en': '+966 ',
      'ar': '+966',
    },
    'gr1za5xy': {
      'en': 'By clicking continue, you agree to our ',
      'ar': 'بالنقر فوق متابعة ، فإنك توافق على',
    },
    '5t0jhzug': {
      'en': 'terms & conditions',
      'ar': 'البنود و الظروف',
    },
    '5ard5tmn': {
      'en': ' & ',
      'ar': '&',
    },
    'irbrz9hi': {
      'en': 'privacy policy',
      'ar': 'سياسة الخصوصية',
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
      'en': 'Account',
      'ar': 'الملف الشخصي',
    },
  },
  // AddingInformation
  {
    '3zqs9v1q': {
      'en': 'Add your information',
      'ar': 'أضف معلوماتك',
    },
    '2xw55n00': {
      'en': 'Full name',
      'ar': 'الاسم الكامل',
    },
    'iegnrogi': {
      'en': ' ',
      'ar': '+966',
    },
    'dr5dq8mr': {
      'en': 'By clicking continue, you agree to our',
      'ar': 'بالنقر فوق متابعة ، فإنك توافق على',
    },
    't1oedq2h': {
      'en': 'terms & conditions ',
      'ar': 'الشروط والأحكام وسياسة الخصوصية',
    },
    'uzfzq8tl': {
      'en': '& ',
      'ar': 'الشروط والأحكام وسياسة الخصوصية',
    },
    'c1o6ckwl': {
      'en': 'privacy policy',
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
    'jxwg61ha': {
      'en': 'Near to me',
      'ar': 'بالقرب مني',
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
  // Offers
  {
    'mthnzz7x': {
      'en': 'Offers',
      'ar': 'عروض',
    },
    'r282eka0': {
      'en': 'You have ',
      'ar': 'عندك',
    },
    '9i2we2yx': {
      'en': ' offers active',
      'ar': '4 عروض نشطة',
    },
    't2kwojss': {
      'en': 'Offers #',
      'ar': 'عروض للحجز #',
    },
    'n5d3s79r': {
      'en': 'Last update: ',
      'ar': '',
    },
    'lre09mx2': {
      'en': 'New Offer',
      'ar': 'عرض جديد',
    },
    'nu7aeeks': {
      'en': 'Pending',
      'ar': 'قيد الانتظار',
    },
    'np7vw75o': {
      'en': 'Property',
      'ar': 'ملكية',
    },
    'vs0xmudi': {
      'en': 'Booking Ref.',
      'ar': 'مرجع الحجز.',
    },
    '2bmjizhc': {
      'en': '#',
      'ar': '',
    },
    'ez8wbssn': {
      'en': 'Initial installment',
      'ar': 'القسط الأولي',
    },
    'ldwv6qbd': {
      'en': '.00',
      'ar': '',
    },
    'z7x7wv59': {
      'en': 'SAR',
      'ar': '',
    },
    '4ha591ne': {
      'en': 'Installment period',
      'ar': 'فترة التقسيط',
    },
    'b1jmmlnc': {
      'en': 'Month',
      'ar': 'شهر',
    },
    '2kxnix92': {
      'en': 'Total price',
      'ar': 'السعر الكلي',
    },
    'c0ty6rbh': {
      'en': '.00',
      'ar': '',
    },
    'h47bvnhi': {
      'en': 'SAR',
      'ar': '',
    },
    'wxex1r7b': {
      'en': 'Agent Name',
      'ar': 'اسم العميل',
    },
    'pasrxjal': {
      'en': 'Chat with ',
      'ar': 'الدردشة مع',
    },
    'n6rgv2jr': {
      'en': 'Accept offer',
      'ar': 'اقبل العرض',
    },
    '5gvwuuh2': {
      'en': 'Completed or canceled offers',
      'ar': 'العروض المكتملة أو الملغاة',
    },
    'km9ey405': {
      'en': 'Offers',
      'ar': 'عروض',
    },
  },
  // PastOffers
  {
    'qvv3lsb7': {
      'en': 'Past & canceled offers',
      'ar': 'العروض السابقة والملغاة',
    },
    '3pqboynr': {
      'en': 'Offers #',
      'ar': 'عروض للحجز #',
    },
    'mne0k69i': {
      'en': 'Last update: ',
      'ar': '',
    },
    '7r7omofu': {
      'en': 'Accepted',
      'ar': 'وافقت',
    },
    'ftvaehka': {
      'en': 'Expired',
      'ar': 'منتهي الصلاحية',
    },
    'y5epausm': {
      'en': 'Rejected',
      'ar': 'مرفوض',
    },
    'dzlim6kq': {
      'en': 'Disqualified',
      'ar': 'غير مؤهل',
    },
    '6e3dl9a5': {
      'en': 'Property',
      'ar': 'ملكية',
    },
    'dcv75stq': {
      'en': 'Booking Ref.',
      'ar': 'مرجع الحجز.',
    },
    '0kssv8ii': {
      'en': '#',
      'ar': '',
    },
    'tpwleczh': {
      'en': 'Initial installment',
      'ar': 'القسط الأولي',
    },
    '6yumrre4': {
      'en': '.00',
      'ar': '',
    },
    '2szdgt5y': {
      'en': 'SAR',
      'ar': '',
    },
    'yv9roric': {
      'en': 'Installment period',
      'ar': 'فترة التقسيط',
    },
    '3v67jmtb': {
      'en': 'Month',
      'ar': 'شهر',
    },
    '3htsv7vx': {
      'en': 'Total price',
      'ar': 'السعر الكلي',
    },
    '3q0s7kis': {
      'en': '.00',
      'ar': '',
    },
    'k4nw3frq': {
      'en': 'SAR',
      'ar': '',
    },
    '4x5ij9es': {
      'en': 'Agent Name',
      'ar': 'اسم العميل',
    },
    'kct7wk1t': {
      'en': 'Home',
      'ar': '',
    },
  },
  // Filter
  {
    'h84toi7e': {
      'en': 'Reset',
      'ar': 'إعادة',
    },
    'hy8565b9': {
      'en': 'Filter',
      'ar': 'فرز',
    },
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
      'ar': 'جدة',
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
    'k57fhygg': {
      'en': ' - ',
      'ar': '',
    },
    'krfzs4ot': {
      'en': ' SAR',
      'ar': '',
    },
    'q62w4vtf': {
      'en': 'Minimum',
      'ar': 'الحد الأدنى',
    },
    'wlsjihmj': {
      'en': 'Maximum',
      'ar': 'أقصى',
    },
    '2m2ni5iy': {
      'en': 'Furnishing',
      'ar': 'مفروشة',
    },
    'jrw6qvww': {
      'en': 'All',
      'ar': 'مفروشة',
    },
    'skyj7jpv': {
      'en': 'Furnished',
      'ar': 'غير مفروشة',
    },
    '8x7rkqnv': {
      'en': 'Un-furnished',
      'ar': 'نصف مفروش أو نصف مجهز أو شبه مفروش',
    },
    'mhyiav30': {
      'en': 'Semi-furnished',
      'ar': '',
    },
    '7fpsv2qy': {
      'en': '',
      'ar': 'الجميع',
    },
    'dgzjfbdt': {
      'en': 'Show  Properties',
      'ar': 'إظهار الخصائص',
    },
    '5wfrx94q': {
      'en': 'Offers',
      'ar': 'مسكن',
    },
  },
  // filterResults
  {
    'kmjdnh1c': {
      'en': 'Filter results ',
      'ar': 'نتائج البحث',
    },
    'wpcx1tpl': {
      'en': ' properties found',
      'ar': 'وجدت خصائص',
    },
    '7egi5iad': {
      'en': 'All',
      'ar': 'الجميع',
    },
    'ujth28u8': {
      'en': 'House',
      'ar': 'منزل',
    },
    'n3j4w46j': {
      'en': 'Apartment',
      'ar': 'شقة',
    },
    'e97m1en4': {
      'en': 'Flat',
      'ar': 'مسطحة',
    },
    'tkhi1190': {
      'en': 'Town house',
      'ar': '',
    },
    '30rthsk2': {
      'en': 'Mansion',
      'ar': '',
    },
    'sn4q62fr': {
      'en': 'All',
      'ar': 'الجميع',
    },
    'y61ahqus': {
      'en': 'Approved Banks',
      'ar': '',
    },
    'n8poxzbo': {
      'en': ', ',
      'ar': '،',
    },
    '4ib4fmbw': {
      'en': 'Installment starting from',
      'ar': 'القسط يبدأ من',
    },
    'df86lsot': {
      'en': 'Total property price',
      'ar': 'القسط يبدأ من',
    },
    'xk3izs5s': {
      'en': ' SAR/Monthly',
      'ar': 'ريال سعودي / شهري',
    },
    '66rkg6uk': {
      'en': ' SAR',
      'ar': 'ريال سعودي',
    },
    'wcatvw4s': {
      'en': 'Home',
      'ar': '',
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
      'en': 'Booked',
      'ar': 'حجز',
    },
    'sfs0xn10': {
      'en': 'Offer Accepted',
      'ar': 'عرض قبول',
    },
    '55a9qb7p': {
      'en': 'Wait for customer acceptance',
      'ar': 'انتظر قبول العميل',
    },
    'hv5vj04i': {
      'en': 'Collect Offer',
      'ar': 'جمع العرض',
    },
    'r3xdvf7i': {
      'en': 'Completed',
      'ar': 'مكتمل',
    },
    '0pgvkbhl': {
      'en': 'Pending Payment',
      'ar': 'في انتظار الدفع',
    },
    'cwzirftq': {
      'en': 'Cancel',
      'ar': 'يلغي',
    },
    'ksi1ofk3': {
      'en': 'Reserved',
      'ar': 'محجوز',
    },
    'tu9ytzrl': {
      'en': 'Booking ref: ',
      'ar': 'مرجع الحجز:',
    },
    'j1l9ymld': {
      'en': 'View Details',
      'ar': 'عرض التفاصيل',
    },
    'o7mo3ne7': {
      'en': 'View Offers',
      'ar': 'مشاهدة العروض',
    },
    '6pr2fkpk': {
      'en': 'Pay now',
      'ar': 'ادفع الآن',
    },
    '4uvlncbs': {
      'en': 'Favorite',
      'ar': 'مفضلة',
    },
    'j1mv6jzk': {
      'en': ', ',
      'ar': ' ،',
    },
    'qsvkss0x': {
      'en': ' sqm',
      'ar': '',
    },
    'lhqoha7d': {
      'en': 'My Properties',
      'ar': 'ممتلكاتي',
    },
  },
  // WhereAreYouLooking
  {
    'qlysszro': {
      'en': 'Where are you  looking ?',
      'ar': 'أين تنظر ؟',
    },
    'wptanz77': {
      'en': ' properties available',
      'ar': '',
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
    'regy8zap': {
      'en': 'View on map',
      'ar': '',
    },
    'd1l98zzs': {
      'en': ' Bedrooms',
      'ar': 'غرف نوم',
    },
    'gqq478h5': {
      'en': ' Bathrooms',
      'ar': 'الحمامات',
    },
    'swyvkhf5': {
      'en': ' sqm',
      'ar': 'متر مربع',
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
    'bidhdd2g': {
      'en': 'Floor Number',
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
    'ntqkfyop': {
      'en': ' m',
      'ar': '30 م',
    },
    'e52iigjz': {
      'en': 'Total Price',
      'ar': 'السعر الكلي',
    },
    've2ud2ws': {
      'en': ' SAR',
      'ar': '',
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
    '67qymqb4': {
      'en': 'Similar Properties',
      'ar': 'خصائص مماثلة',
    },
    'dw0ntbtl': {
      'en': 'Approved Banks',
      'ar': '',
    },
    'daq1tb18': {
      'en': ', ',
      'ar': '،',
    },
    '5fi3eht5': {
      'en': 'Installment starting from',
      'ar': 'القسط يبدأ من',
    },
    'asvlp34j': {
      'en': 'Total property price',
      'ar': 'القسط يبدأ من',
    },
    'vfqf83co': {
      'en': ' SAR/Monthly',
      'ar': 'ريال سعودي / شهري',
    },
    'o3rzhl0v': {
      'en': ' SAR',
      'ar': 'ريال سعودي',
    },
    'i17ddd6l': {
      'en': 'Installment starting from',
      'ar': 'القسط يبدأ من',
    },
    'mgi2d0o9': {
      'en': ' SAR/Monthly',
      'ar': ' ريال سعودي / شهري',
    },
    'dpmrt150': {
      'en': 'Reserve',
      'ar': 'محجوز',
    },
    'wzirx8i7': {
      'en': 'Booked',
      'ar': 'حجز',
    },
  },
  // SearchCityResult
  {
    '5s0m6vc5': {
      'en': 'Approved Banks',
      'ar': '',
    },
    'f2n56efp': {
      'en': ', ',
      'ar': '،',
    },
    'by2cxdfu': {
      'en': 'Installment starting from',
      'ar': 'القسط يبدأ من',
    },
    'e3d13l9e': {
      'en': 'Total property price',
      'ar': 'القسط يبدأ من',
    },
    'bm7ytrkl': {
      'en': ' SAR/Monthly',
      'ar': 'ريال سعودي / شهري',
    },
    's8nfdgfe': {
      'en': ' SAR',
      'ar': 'ريال سعودي',
    },
    'cv6ymemd': {
      'en': 'Search results ',
      'ar': 'نتائج البحث',
    },
    'i7hby2rh': {
      'en': '\"',
      'ar': '',
    },
    '6gnj1yz7': {
      'en': '\"',
      'ar': '',
    },
    'nukctvmg': {
      'en': ' properties found',
      'ar': 'وجدت خصائص',
    },
    'ntrpmj08': {
      'en': 'Home',
      'ar': '',
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
    '67mealxd': {
      'en': '#',
      'ar': '',
    },
    'qlfkupzn': {
      'en': 'Show booking details',
      'ar': 'إظهار تفاصيل الحجز',
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
  // AddCardDetails
  {
    'f861qahz': {
      'en': 'Add your credit card',
      'ar': '',
    },
    'ijpogm7i': {
      'en': 'Please fill in the fields below to submit your booking',
      'ar': '',
    },
    '192j9655': {
      'en': 'Card Number',
      'ar': 'رقم الهاتف المحمول',
    },
    's7o0t1vo': {
      'en': '0000 0000 0000 0000',
      'ar': '+966',
    },
    'i8uaihjd': {
      'en': 'Expiry Date',
      'ar': 'رقم الهاتف المحمول',
    },
    '6xvwrsr6': {
      'en': 'MM/YY',
      'ar': '+966',
    },
    'r8lh7z72': {
      'en': 'Expiry Date',
      'ar': 'رقم الهاتف المحمول',
    },
    'u48o2mqd': {
      'en': 'MM/YY',
      'ar': '+966',
    },
    'vcwtqv1r': {
      'en': 'Home',
      'ar': '',
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
  // BookingDetails
  {
    'trw95gom': {
      'en': 'Booking Ref. : ',
      'ar': '',
    },
    '8eahonhl': {
      'en': 'Order Process',
      'ar': 'مراحل الطلب',
    },
    'w2795v66': {
      'en': 'Property Reserved',
      'ar': 'الملكية محفوظة',
    },
    'm30m3lz9': {
      'en': 'Payment Confirmed',
      'ar': 'تم تأكيد عملية الدفع',
    },
    'zpv0x3sj': {
      'en': 'Collect offers',
      'ar': 'جمع العروض',
    },
    'b21jlid1': {
      'en': '0',
      'ar': '',
    },
    'mls6x5hy': {
      'en': '/3',
      'ar': '',
    },
    '3a3j0qu5': {
      'en': 'Waitng for Offer Acceptance',
      'ar': 'انتظار قبول العرض',
    },
    'oqathjmt': {
      'en': 'Offer Accepted',
      'ar': 'عرض قبول',
    },
    'nhrc354h': {
      'en': 'Transferring Ownership to you ',
      'ar': 'نقل الملكية إليك',
    },
    'dd079ljk': {
      'en': 'Cancelled',
      'ar': 'ألغيت',
    },
    'nxmc61bl': {
      'en': 'Property details',
      'ar': 'تفاصيل اوضح',
    },
    'sfe2y1t7': {
      'en': ', ',
      'ar': 'و',
    },
    'x91g5vu9': {
      'en': ' sqm',
      'ar': '',
    },
    '6cg0ue0u': {
      'en': 'View More',
      'ar': 'عرض المزيد',
    },
    'qkoz8020': {
      'en': 'Transaction details',
      'ar': 'تفاصيل الصفقه',
    },
    'qxs4ycvd': {
      'en': 'Transaction Ref.',
      'ar': 'المرجع المعاملة.',
    },
    'snmoyj94': {
      'en': '#',
      'ar': '',
    },
    '0ck5hck8': {
      'en': 'Payment Method',
      'ar': 'طريقة الدفع او السداد',
    },
    'zagvs0yx': {
      'en': 'Amount',
      'ar': 'المبلغ',
    },
    '17eaou67': {
      'en': '.00 SAR',
      'ar': '',
    },
    'x0ed6u9h': {
      'en': 'Date & Time',
      'ar': 'التاريخ والوقت',
    },
    'i7w1em00': {
      'en': 'View Receipt Transaction',
      'ar': 'عرض إيصال المعاملة',
    },
    'vrsc3lt4': {
      'en': 'Home',
      'ar': 'الصفحة الرئيسية',
    },
  },
  // NotFoundPage
  {
    'gmbuwmld': {
      'en': 'No Result Found',
      'ar': 'لم يتم العثور على نتائج',
    },
  },
  // bankDetailsBottomSheet
  {
    'qb244g7f': {
      'en': 'Bank Details',
      'ar': '',
    },
    'ua6uqn3o': {
      'en': 'Close',
      'ar': '',
    },
  },
  // NoResultsFound
  {
    '1yep0j1q': {
      'en': 'Explore our properties',
      'ar': '',
    },
  },
  // reservationBottomSheet
  {
    'jaefs5yd': {
      'en': 'Reservation confirmation',
      'ar': 'تأكيد الحجز',
    },
    'pdty4a6r': {
      'en':
          'To confirm the reservation, you need to pay an administration fee. By confirming payment, you ',
      'ar': 'لتأكيد الحجز ، يتعين عليك دفع رسوم إدارية. بتأكيد الدفع ، أنت',
    },
    'njswqwdn': {
      'en': 'agree to our ',
      'ar': 'توافق على',
    },
    '0gizrv8a': {
      'en': 'terms & conditions ',
      'ar': 'البنود و الظروف',
    },
    'iyjhj02m': {
      'en': 'Reservation cost',
      'ar': '',
    },
    'ovajaogv': {
      'en': '.00',
      'ar': '',
    },
    'wqlgaavg': {
      'en': 'SAR',
      'ar': '',
    },
    'sohxgusa': {
      'en': 'Note: Reservation cost is non-refundable ',
      'ar': '',
    },
    'p0n3wi8y': {
      'en': 'Select Payment Method',
      'ar': '',
    },
    '0pkqdf0l': {
      'en': 'Mada/Visa',
      'ar': '',
    },
    'icwlzrr6': {
      'en': 'ApplePay',
      'ar': '',
    },
    'p50ponkb': {
      'en': 'Pay',
      'ar': '',
    },
  },
  // cancelReserveBottomSheet
  {
    'wb43h3r4': {
      'en': 'Cancel Reserve',
      'ar': '',
    },
    't7s7qd09': {
      'en': 'Cancel',
      'ar': '',
    },
  },
  // Miscellaneous
  {
    'qr81nfm0': {
      'en': '',
      'ar': '',
    },
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
