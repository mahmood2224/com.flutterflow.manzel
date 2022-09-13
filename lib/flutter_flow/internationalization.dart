import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['en', 'ar'];

  String get languageCode => locale.toString();
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? enText = '',
    String? arText = '',
  }) =>
      [enText, arText][languageIndex] ?? '';
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      FFLocalizations.languages().contains(locale.toString());

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

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
      'ar': 'الشروط و الأحكام',
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
      'ar': ' الرئيسية',
    },
  },
  // OnboardingView
  {
    '0rkg3m44': {
      'en': 'The perfect choice for \nyour future home',
      'ar': 'الخيار الأمثل لمنزلك المستقبلي',
    },
    'bl6z0bqv': {
      'en': 'The dream home',
      'ar': 'الخيار الأمثل لمنزلك المستقبلي',
    },
    't9rvb8ym': {
      'en': 'The dream become true',
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
      'ar': ' الرئيسية',
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
      'ar': ' الرئيسية',
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
      'ar': 'الشروط والأحكام',
    },
    '2csoqw0t': {
      'en': 'Logout',
      'ar': 'تسجيل خروج',
    },
    'umgvt8b8': {
      'en': 'Account',
      'ar': 'الحساب',
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
      'ar': '',
    },
    'dr5dq8mr': {
      'en': 'By clicking continue, you agree to our',
      'ar': 'بالنقر فوق متابعة ، فإنك توافق على',
    },
    't1oedq2h': {
      'en': 'terms & conditions ',
      'ar': 'الشروط والأحكام',
    },
    'uzfzq8tl': {
      'en': '& ',
      'ar': '&',
    },
    'c1o6ckwl': {
      'en': 'privacy policy',
      'ar': 'سياسة الخصوصية',
    },
    'fnkwu8bx': {
      'en': 'Continue',
      'ar': 'متابعة',
    },
    '1cb69bnh': {
      'en': 'Home',
      'ar': ' الرئيسية',
    },
  },
  // TermsConditions
  {
    'tw2xsj9g': {
      'en': 'Terms & Conditions',
      'ar': 'الشروط و الأحكام',
    },
    'yiyc7r9g': {
      'en': 'Home',
      'ar': ' الرئيسية',
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
    'jj84j3p5': {
      'en': 'Employment details',
      'ar': 'تفاصيل العمل',
    },
    '4w16yzqb': {
      'en': '2000 - 5000 SAR',
      'ar': '2000-5000 ريال سعودي',
    },
    'him4ym4p': {
      'en': '5000 - 10000 SAR',
      'ar': '5000-10000 ريال سعودي',
    },
    'pb50wqi5': {
      'en': '10000 - 30000 SAR',
      'ar': '10000 - 30000 ريال سعودي',
    },
    'ae71fn4w': {
      'en': 'Monthly income',
      'ar': 'الدخل الشهري',
    },
    '1x1hia9l': {
      'en': 'Private Sector',
      'ar': 'القطاع الخاص',
    },
    'uj45ba83': {
      'en': 'Private Sector',
      'ar': 'القطاع الخاص',
    },
    'vsxglb98': {
      'en': 'Goverment sector',
      'ar': 'قطاع الحكومة',
    },
    '5bct8jic': {
      'en': 'Hafiz',
      'ar': 'حافز',
    },
    'm0exe07x': {
      'en': 'Retired',
      'ar': 'متقاعد',
    },
    'qjiyq3zw': {
      'en': 'Self Employment',
      'ar': 'العمل الحر',
    },
    '0bt0abl8': {
      'en': 'Student',
      'ar': 'طالب',
    },
    'ofijqhhe': {
      'en': 'Unemployed',
      'ar': 'عاطل عن العمل',
    },
    'gerdd7rv': {
      'en': 'Employment status',
      'ar': 'الحالة الوظيفية',
    },
    'xaoukvl0': {
      'en': 'AlRajhi Bank',
      'ar': 'مصرف الراجحي',
    },
    'jf2d59jp': {
      'en': 'Alinma Bank',
      'ar': 'مصرف الإنماء',
    },
    'rdd2pyla': {
      'en': 'Alahli Bank',
      'ar': 'مصرف الاهلي',
    },
    'unctzrqf': {
      'en': 'SAAB Bank',
      'ar': 'مصرف ساب',
    },
    'nfhf8rho': {
      'en': 'Salary bank',
      'ar': 'بنك الراتب',
    },
    'doqco3ap': {
      'en': 'Does the Sakani loan cover you?',
      'ar': '',
    },
    'ag8peu33': {
      'en': 'Yes',
      'ar': '',
    },
    'cxroduir': {
      'en': 'No',
      'ar': '',
    },
    '91pyvwfe': {
      'en': 'Submit',
      'ar': 'احفظ التغييرات',
    },
    'x4a06mk8': {
      'en': 'Home',
      'ar': ' الرئيسية',
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
      'ar': ' الرئيسية',
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
      'ar': ' الرئيسية',
    },
  },
  // HelpAndSupport
  {
    'ejwcvtm6': {
      'en': 'Please write us at',
      'ar': 'الرجاء الكتابة إلينا على',
    },
    'su9hen9u': {
      'en': 'manzel@manzel.app',
      'ar': 'manzel@manzel.app',
    },
    'j6a73di8': {
      'en': 'for any query and concern',
      'ar': 'لأي استفسار وقلق',
    },
    'w6ge88x2': {
      'en': 'Deactivate Account',
      'ar': 'حذف الحساب',
    },
    'io7ksyi7': {
      'en': 'Help & Support',
      'ar': 'ساعد لدعم',
    },
    'gm7tjh1u': {
      'en': 'Home',
      'ar': '',
    },
  },
  // HomeScreen
  {
    'qnr0o42y': {
      'en': 'Where are you looking?',
      'ar': 'أين تبحث ؟',
    },
    '2cud1oqj': {
      'en': 'Available',
      'ar': 'متوفرة',
    },
    'qtso45vv': {
      'en': 'Booked',
      'ar': 'حجز',
    },
    'juw40663': {
      'en': 'Coming soon',
      'ar': 'قريبا',
    },
    'etpebw43': {
      'en': 'Approved Banks',
      'ar': 'البنوك المعتمدة',
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
      'ar': 'إجمالي سعر العقار',
    },
    'l38if619': {
      'en': ' SAR/Monthly',
      'ar': 'ريال/ شهريا',
    },
    'dhoik8q5': {
      'en': ' SAR',
      'ar': 'ر.س',
    },
    'd9p577jz': {
      'en': 'Explore',
      'ar': 'اكتشف',
    },
  },
  // Notifications
  {
    'nm3bcvix': {
      'en': 'Notifications',
      'ar': 'إشعارات',
    },
    'mvocppdr': {
      'en': 'Home',
      'ar': ' الرئيسية',
    },
  },
  // Offers
  {
    'mthnzz7x': {
      'en': 'Offers',
      'ar': 'عروض',
    },
    'r282eka0': {
      'en': 'You have',
      'ar': 'عندك',
    },
    '9i2we2yx': {
      'en': 'offers active',
      'ar': 'العروض النشطة',
    },
    'z2siuoeg': {
      'en': ' ',
      'ar': '',
    },
    'muecz7ra': {
      'en': 'You need to create an account or ',
      'ar': 'تحتاج إلى إنشاء حساب أو',
    },
    'x824f0mb': {
      'en': 'login to see this section',
      'ar': 'تسجيل الدخول لرؤية هذا القسم',
    },
    '1cb5at0r': {
      'en': 'Login/Signup',
      'ar': 'الدخول التسجيل فى الموقع',
    },
    't2kwojss': {
      'en': 'Offers',
      'ar': 'عرض',
    },
    'n5d3s79r': {
      'en': 'Last update : ',
      'ar': 'اخر تحديث :',
    },
    'jcj51k47': {
      'en': 'Disqualified',
      'ar': 'غير مؤهل',
    },
    'zraegj7a': {
      'en': 'Rejected',
      'ar': 'مرفوض',
    },
    '2ak58fes': {
      'en': 'Expired',
      'ar': 'منتهي الصلاحية',
    },
    'vaaj8s0b': {
      'en': 'Accepted',
      'ar': 'مقبول',
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
      'ar': 'مرجع الحجز',
    },
    'ez8wbssn': {
      'en': 'Initial installment',
      'ar': 'القسط الأولي',
    },
    'z7x7wv59': {
      'en': 'SAR',
      'ar': 'ر.س',
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
    'h47bvnhi': {
      'en': 'SAR',
      'ar': 'ر.س',
    },
    'wxex1r7b': {
      'en': 'Agent Name',
      'ar': 'اسم الموظف',
    },
    'pasrxjal': {
      'en': 'Chat with',
      'ar': 'الدردشة مع',
    },
    'alqnps4o': {
      'en': ' ',
      'ar': '',
    },
    'ps7kcru7': {
      'en': 'bank',
      'ar': 'مصرف',
    },
    '8xn1x1ox': {
      'en': '1',
      'ar': '',
    },
    'y0qb0uvi': {
      'en': 'Accept offer',
      'ar': 'اقبل العرض',
    },
    '5gvwuuh2': {
      'en': 'Past Offers',
      'ar': 'العروض السابقة',
    },
    'km9ey405': {
      'en': 'Offers',
      'ar': 'عروض',
    },
  },
  // Filter
  {
    'h84toi7e': {
      'en': 'Reset',
      'ar': 'إعادة ضبط',
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
      'ar': 'مكة المكرمة',
    },
    'xagmgkfm': {
      'en': 'Dubai',
      'ar': 'دبي',
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
      'ar': 'الكل',
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
      'ar': 'تاون هاوس',
    },
    '378fpsns': {
      'en': 'Mansion',
      'ar': 'بيت كبير',
    },
    '2jdd174j': {
      'en': 'All',
      'ar': 'الكل',
    },
    '4mz2rd2p': {
      'en': 'Installment Range',
      'ar': 'نطاق التقسيط',
    },
    'k57fhygg': {
      'en': ' - ',
      'ar': '-',
    },
    'krfzs4ot': {
      'en': ' SAR',
      'ar': 'ريال سعودي',
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
      'ar': 'الكل',
    },
    'skyj7jpv': {
      'en': 'Furnished',
      'ar': ' مفروشة',
    },
    '8x7rkqnv': {
      'en': 'Un-furnished',
      'ar': 'غير مفروشة',
    },
    'mhyiav30': {
      'en': 'Semi-furnished',
      'ar': ' شبه مفروش',
    },
    '7fpsv2qy': {
      'en': '',
      'ar': 'الكل',
    },
    'dgzjfbdt': {
      'en': 'Show  Properties',
      'ar': 'إظهار الملكيات',
    },
    '5wfrx94q': {
      'en': 'Offers',
      'ar': 'عروض',
    },
  },
  // PastOffers
  {
    'qvv3lsb7': {
      'en': 'Past Offers',
      'ar': 'العروض السابقة',
    },
    '3pqboynr': {
      'en': 'Offers ',
      'ar': 'عروض',
    },
    'mne0k69i': {
      'en': 'Last update: ',
      'ar': 'اخر تحديث:',
    },
    '7r7omofu': {
      'en': 'Accepted',
      'ar': 'مقبول',
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
    '2h95uk6b': {
      'en': 'Canelled',
      'ar': 'غير مؤهل',
    },
    '6e3dl9a5': {
      'en': 'Property',
      'ar': 'ملكية',
    },
    'dcv75stq': {
      'en': 'Booking Ref.',
      'ar': 'مرجع الحجز',
    },
    'tpwleczh': {
      'en': 'Initial installment',
      'ar': 'القسط الأولي',
    },
    '2szdgt5y': {
      'en': 'SAR',
      'ar': 'ر.س',
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
    'k4nw3frq': {
      'en': 'SAR',
      'ar': 'ر.س',
    },
    '4x5ij9es': {
      'en': 'Agent Name',
      'ar': 'اسم الموظف',
    },
    'kct7wk1t': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // filterResults
  {
    'kmjdnh1c': {
      'en': 'Filter results ',
      'ar': 'نتائج التصفية',
    },
    'wpcx1tpl': {
      'en': 'properties found',
      'ar': 'نتائج',
    },
    '7egi5iad': {
      'en': 'All',
      'ar': 'الكل',
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
      'ar': 'تاون هاوس',
    },
    '30rthsk2': {
      'en': 'Mansion',
      'ar': 'بيت كبير',
    },
    'sn4q62fr': {
      'en': 'All',
      'ar': 'الكل',
    },
    'llrt5ozo': {
      'en': 'Coming soon',
      'ar': 'قريبا',
    },
    'plfdsrsb': {
      'en': 'Available',
      'ar': 'متوفرة',
    },
    'kevbc07d': {
      'en': 'Booked',
      'ar': 'حجز',
    },
    'y61ahqus': {
      'en': 'Approved Banks',
      'ar': 'البنوك المعتمدة',
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
      'ar': 'إجمالي سعر العقار',
    },
    'xk3izs5s': {
      'en': ' SAR/Monthly',
      'ar': 'ريال/ شهريا',
    },
    '66rkg6uk': {
      'en': ' SAR',
      'ar': 'ر.س',
    },
    'wcatvw4s': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // MyProperties
  {
    '21gpsvgr': {
      'en': 'My Properties',
      'ar': 'ممتلكاتي',
    },
    'w4bgagrv': {
      'en': 'You need to create an account or ',
      'ar': 'تحتاج إلى إنشاء حساب أو',
    },
    '9m2bglko': {
      'en': 'login to see this section',
      'ar': 'تسجيل الدخول لرؤية هذا القسم',
    },
    'yo5djc7x': {
      'en': 'Login/Signup',
      'ar': 'الدخول التسجيل فى الموقع',
    },
    'gl02050s': {
      'en': 'Booked',
      'ar': 'محجوز',
    },
    'sfs0xn10': {
      'en': 'Offer Accepted',
      'ar': 'العرض مقبول',
    },
    '55a9qb7p': {
      'en': 'Waiting for customer acceptance',
      'ar': 'في انتظار قبول العميل',
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
      'en': 'Cancelled',
      'ar': 'ألغيت',
    },
    'ksi1ofk3': {
      'en': 'Reserved',
      'ar': 'محجوز',
    },
    '9svos0f4': {
      'en': 'Disqualified',
      'ar': 'غير مؤهل',
    },
    '1ky73fb2': {
      'en': 'Expired',
      'ar': 'منتهي الصلاحية',
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
    '747xbn3l': {
      'en': 'sqm',
      'ar': 'متر مربع',
    },
    'lhqoha7d': {
      'en': 'My Properties',
      'ar': 'ممتلكاتي',
    },
  },
  // PropertyDetails
  {
    'ak0ss5un': {
      'en': 'Updated: ',
      'ar': 'محدث:',
    },
    'ccsmgbaf': {
      'en': 'Available',
      'ar': '',
    },
    'ie4ye37b': {
      'en': 'Booked',
      'ar': '',
    },
    '9d90para': {
      'en': 'Apt. Plan',
      'ar': 'ملائم. يخطط',
    },
    '73rcbvl6': {
      'en': ', ',
      'ar': '،',
    },
    'regy8zap': {
      'en': 'View on map',
      'ar': 'عرض على الخريطة',
    },
    'kqc4ney0': {
      'en': 'Property manage by ',
      'ar': 'إدارة الممتلكات عن طريق',
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
      'ar': 'مصدر رقم',
    },
    'ku7u4p9w': {
      'en': 'Floors',
      'ar': 'عدد الطوابق',
    },
    'bidhdd2g': {
      'en': 'Floor Number',
      'ar': 'الطابق',
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
      'ar': 'م',
    },
    'e52iigjz': {
      'en': 'Total Price',
      'ar': 'السعر الكلي',
    },
    've2ud2ws': {
      'en': ' SAR',
      'ar': 'ر.س',
    },
    'xiuyvuiq': {
      'en': 'Property type',
      'ar': 'نوع الملكية',
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
      'en': 'Photos',
      'ar': 'الصور',
    },
    'i17ddd6l': {
      'en': 'Installment starting from',
      'ar': 'القسط يبدأ من',
    },
    'mgi2d0o9': {
      'en': 'SAR/Monthly',
      'ar': 'ريال/ شهريا',
    },
    'dpmrt150': {
      'en': 'Reserve',
      'ar': 'حجز',
    },
    'wzirx8i7': {
      'en': 'Booked',
      'ar': 'محجوز',
    },
  },
  // propertyVideo
  {
    'gnkwrihl': {
      'en': 'Home',
      'ar': '',
    },
  },
  // FloorPlan
  {
    '316x1ckw': {
      'en': 'Floor Plan ',
      'ar': 'المخطط',
    },
    'qz7ded0d': {
      'en': 'Home',
      'ar': '',
    },
  },
  // ThreeSixtyView
  {
    'e6q07s67': {
      'en': '360° View',
      'ar': 'عرض 360 درجة',
    },
    '9e175bwt': {
      'en': 'Home',
      'ar': '',
    },
  },
  // imageGalleryView
  {
    '8yghlvmu': {
      'en': 'Home',
      'ar': '',
    },
  },
  // WhereAreYouLooking
  {
    'qlysszro': {
      'en': 'Where are you  looking ?',
      'ar': 'أين تبحث ؟',
    },
    'wptanz77': {
      'en': 'properties available ',
      'ar': 'الملكيات المتاحة',
    },
    'fce9ky0f': {
      'en': 'Home',
      'ar': ' الرئيسية',
    },
  },
  // SearchCityResult
  {
    '81d8z9gv': {
      'en': 'Coming soon',
      'ar': 'قريبا',
    },
    'z6vaof0z': {
      'en': 'Booked',
      'ar': 'حجز',
    },
    'rmxl8rt6': {
      'en': 'Available',
      'ar': 'متوفرة',
    },
    '5s0m6vc5': {
      'en': 'Approved Banks',
      'ar': 'البنوك المعتمدة',
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
      'ar': 'إجمالي سعر العقار',
    },
    'bm7ytrkl': {
      'en': ' SAR/Monthly',
      'ar': 'ريال/ شهريا',
    },
    's8nfdgfe': {
      'en': ' SAR',
      'ar': 'ر.س',
    },
    'cv6ymemd': {
      'en': 'Search results ',
      'ar': 'نتائج البحث',
    },
    'i7hby2rh': {
      'en': '\"',
      'ar': '\"',
    },
    '6gnj1yz7': {
      'en': '\"',
      'ar': '\"',
    },
    'nukctvmg': {
      'en': 'properties found',
      'ar': 'نتائج البحث',
    },
    'ntrpmj08': {
      'en': 'Home',
      'ar': 'الرئيسية ',
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
      'ar': 'ابل باي',
    },
    '8j5d0340': {
      'en': 'Pay',
      'ar': 'ادفع',
    },
    's7jia86m': {
      'en': 'Home',
      'ar': ' الرئيسية',
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
      'ar': 'مرجع الحجز :',
    },
    'qlfkupzn': {
      'en': 'Show booking details',
      'ar': 'إظهار تفاصيل الحجز',
    },
    'jdsnk395': {
      'en': 'Home',
      'ar': ' الرئيسية',
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
      'ar': ' الرئيسية',
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
      'ar': 'احصل على عروض من البنوك',
    },
    'oqjt6apm': {
      'en': 'Close Deal',
      'ar': 'انتهت الصفقة',
    },
    '07sk94co': {
      'en': 'Home',
      'ar': ' الرئيسية',
    },
  },
  // AddCardDetails
  {
    'f861qahz': {
      'en': 'Add your credit card',
      'ar': 'أضف بطاقتك الائتمانية',
    },
    'ijpogm7i': {
      'en': 'Please fill in the fields below to submit your booking',
      'ar': 'يرجى ملء الحقول أدناه لاعتماد حجزك',
    },
    '192j9655': {
      'en': 'Card Number',
      'ar': 'رقم البطاقة',
    },
    's7o0t1vo': {
      'en': '0000 0000 0000 0000',
      'ar': '0000 0000 0000 0000',
    },
    'i8uaihjd': {
      'en': 'Expiry Date',
      'ar': 'تاريخ انتهاء الصلاحية',
    },
    '6xvwrsr6': {
      'en': 'MM/YY',
      'ar': 'شهر / سنة',
    },
    'r8lh7z72': {
      'en': 'Expiry Date',
      'ar': 'تاريخ انتهاء الصلاحية',
    },
    'u48o2mqd': {
      'en': 'MM/YY',
      'ar': 'شهر / سنة',
    },
    'vcwtqv1r': {
      'en': 'Home',
      'ar': 'الرئيسية',
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
      'ar': 'دليل رسمي على الأفعى',
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
      'ar': 'متابعة',
    },
    'ty5u3tc8': {
      'en': 'Home',
      'ar': 'الرئيسية',
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
      'ar': ' الرئيسية',
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
      'ar': 'مصرف الاهلي',
    },
    'omiqb5pp': {
      'en': 'SAAB Bank',
      'ar': 'مصرف ساب',
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
      'ar': 'متابعة',
    },
    'r2cco6t4': {
      'en': 'Home',
      'ar': ' الرئيسية',
    },
  },
  // Chat
  {
    '9onf7xjs': {
      'en': 'Home',
      'ar': 'الرئيسية',
    },
  },
  // BookingDetails
  {
    'trw95gom': {
      'en': 'Booking Ref. :',
      'ar': 'مرجع الحجز :',
    },
    '8eahonhl': {
      'en': 'Order Process',
      'ar': 'مراحل الطلب',
    },
    'w2795v66': {
      'en': 'Property Reserved',
      'ar': 'تم حجز الملكية',
    },
    'm30m3lz9': {
      'en': 'Payment Confirmed',
      'ar': 'تم تأكيد عملية الدفع',
    },
    'zpv0x3sj': {
      'en': 'Collecting Offers',
      'ar': 'جمع العروض',
    },
    'hho1grz4': {
      'en': '/',
      'ar': '/',
    },
    'xa9e1t5y': {
      'en': 'Waiting for banks to submit offers ',
      'ar': 'في انتظار البنوك لتقديم العروض',
    },
    'pdhga106': {
      'en': '(',
      'ar': '(',
    },
    'awjba3l0': {
      'en': '/',
      'ar': '/',
    },
    'mehsn231': {
      'en': ')',
      'ar': ')',
    },
    '3a3j0qu5': {
      'en': 'Offer Accepted',
      'ar': 'في انتظار قبول العرض',
    },
    'ver0de4k': {
      'en': 'Waiting for you to accept one of the offers provided by banks',
      'ar': 'في انتظارك لقبول أحد العروض المقدمة من البنوك',
    },
    'oqathjmt': {
      'en': 'Transfer Ownership',
      'ar': 'تم نقل الملكية إليك',
    },
    'k64pcuyr': {
      'en': 'Transferring the ownership of the property to you ',
      'ar': 'نقل ملكية العقار لك',
    },
    'nhrc354h': {
      'en': 'Completed',
      'ar': 'نقل الملكية إليك',
    },
    'ubpscf43': {
      'en': 'Ownership transferred successfully ',
      'ar': 'تم نقل الملكية بنجاح',
    },
    'dd079ljk': {
      'en': 'Cancelled',
      'ar': 'ألغيت',
    },
    'mtbhr1iu': {
      'en': 'You have Cancelled the reservation of the property',
      'ar': 'لقد ألغيت حجز العقار',
    },
    '5lptumrw': {
      'en': 'Disqualified',
      'ar': 'غير مؤهل',
    },
    'zaua3lqi': {
      'en': 'You have been disqualified from all supported banks',
      'ar': 'لقد تم استبعادك من جميع البنوك المدعومة',
    },
    'zv5c32ls': {
      'en': 'Expired',
      'ar': 'منتهي الصلاحية',
    },
    'cgacbnp0': {
      'en': 'Your offer has been expired',
      'ar': 'لقد انتهت صلاحية عرضك',
    },
    'nxmc61bl': {
      'en': 'Property details',
      'ar': 'تفاصيل أكثر',
    },
    'sfe2y1t7': {
      'en': ', ',
      'ar': '،',
    },
    '6ry49rxz': {
      'en': ' sqm',
      'ar': 'متر مربع',
    },
    '6cg0ue0u': {
      'en': 'View More',
      'ar': 'عرض المزيد',
    },
    'qkoz8020': {
      'en': 'Transaction details',
      'ar': 'تفاصيل الصفقه',
    },
    '0ck5hck8': {
      'en': 'Payment Method',
      'ar': 'طريقة الدفع',
    },
    'qxs4ycvd': {
      'en': 'Transaction Ref.',
      'ar': 'مرجع المعاملة',
    },
    'zagvs0yx': {
      'en': 'Amount',
      'ar': 'المبلغ',
    },
    '17eaou67': {
      'en': 'SAR',
      'ar': 'ر.س',
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
      'ar': ' الرئيسية',
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
      'ar': 'تفاصيل البنك',
    },
    'ua6uqn3o': {
      'en': 'Close',
      'ar': 'إغلاق',
    },
  },
  // NoResultsFound
  {
    '1yep0j1q': {
      'en': 'Explore our properties',
      'ar': 'اكتشف ممتلكاتنا',
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
      'ar': 'الشروط والأحكام',
    },
    'iyjhj02m': {
      'en': 'Reservation cost',
      'ar': 'تكلفة الحجز',
    },
    'wqlgaavg': {
      'en': 'SAR',
      'ar': 'ريال سعودي',
    },
    'sohxgusa': {
      'en': 'Note: Reservation cost is non-refundable ',
      'ar': 'ملاحظة: تكلفة الحجز غير قابلة للاسترداد',
    },
    'p0n3wi8y': {
      'en': 'Select Payment Method',
      'ar': 'اختار طريقة الدفع',
    },
    '0pkqdf0l': {
      'en': 'Mada/Visa',
      'ar': 'مدى / فيزا',
    },
    'icwlzrr6': {
      'en': 'ApplePay',
      'ar': 'ابل باي',
    },
    'p50ponkb': {
      'en': 'Pay',
      'ar': 'ادفع',
    },
  },
  // cancelReserveBottomSheet
  {
    'wb43h3r4': {
      'en': 'Cancel Reserve',
      'ar': 'إلغاء الحجز',
    },
    't7s7qd09': {
      'en': 'Cancel',
      'ar': 'إلغاء',
    },
  },
  // helpAndSupportBottomSheet
  {
    'btyml6ed': {
      'en': 'Help & Support',
      'ar': 'ساعد لدعم',
    },
    'emjcotxb': {
      'en': 'Please write us at',
      'ar': 'الرجاء الكتابة إلينا على',
    },
    'hwo08yn2': {
      'en': 'Support@manzel.app',
      'ar': 'Support@manzel.app',
    },
    'pzfwn97d': {
      'en': 'for any query and concern',
      'ar': 'لأي استفسار وقلق',
    },
    'eaazmbdx': {
      'en': 'Delete Account',
      'ar': 'حذف الحساب',
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
