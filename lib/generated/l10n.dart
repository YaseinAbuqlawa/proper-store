// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `PROPER`
  String get homeTitle {
    return Intl.message('PROPER', name: 'homeTitle', desc: '', args: []);
  }

  /// `الرئيسية`
  String get homeButtonName {
    return Intl.message('الرئيسية', name: 'homeButtonName', desc: '', args: []);
  }

  /// `الاقسام`
  String get categories {
    return Intl.message('الاقسام', name: 'categories', desc: '', args: []);
  }

  /// `المفضلة`
  String get favoritesTitle {
    return Intl.message('المفضلة', name: 'favoritesTitle', desc: '', args: []);
  }

  /// `السلة`
  String get cartTitle {
    return Intl.message('السلة', name: 'cartTitle', desc: '', args: []);
  }

  /// `طلباتي`
  String get ordersTitle {
    return Intl.message('طلباتي', name: 'ordersTitle', desc: '', args: []);
  }

  /// `حسابي`
  String get profileTitle {
    return Intl.message('حسابي', name: 'profileTitle', desc: '', args: []);
  }

  /// `وصل حديثاً`
  String get mostSoldSectionTitle {
    return Intl.message(
      'وصل حديثاً',
      name: 'mostSoldSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `عرض الكل`
  String get showAllText {
    return Intl.message('عرض الكل', name: 'showAllText', desc: '', args: []);
  }

  /// `تسوقي الان`
  String get mainCollectionBannerButtonText {
    return Intl.message(
      'تسوقي الان',
      name: 'mainCollectionBannerButtonText',
      desc: '',
      args: [],
    );
  }

  /// `أضف للسلة`
  String get addToCartText {
    return Intl.message('أضف للسلة', name: 'addToCartText', desc: '', args: []);
  }

  /// ` ج.م`
  String get currencySymbol {
    return Intl.message(' ج.م', name: 'currencySymbol', desc: '', args: []);
  }

  /// `حصلت مشكلة بسيطة والعملية اتوقفت، ممكن تحاول مرة تانية؟`
  String get firebase_error_aborted {
    return Intl.message(
      'حصلت مشكلة بسيطة والعملية اتوقفت، ممكن تحاول مرة تانية؟',
      name: 'firebase_error_aborted',
      desc: '',
      args: [],
    );
  }

  /// `البيانات دي موجودة عندنا بالفعل، يا ريت تتأكد منها.`
  String get firebase_error_already_exists {
    return Intl.message(
      'البيانات دي موجودة عندنا بالفعل، يا ريت تتأكد منها.',
      name: 'firebase_error_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `تم إلغاء العملية بناءً على طلبك.`
  String get firebase_error_cancelled {
    return Intl.message(
      'تم إلغاء العملية بناءً على طلبك.',
      name: 'firebase_error_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `عذراً، حصل فقد في البيانات، يا ريت تبلغ الدعم الفني لمساعدتك.`
  String get firebase_error_data_loss {
    return Intl.message(
      'عذراً، حصل فقد في البيانات، يا ريت تبلغ الدعم الفني لمساعدتك.',
      name: 'firebase_error_data_loss',
      desc: '',
      args: [],
    );
  }

  /// `الوقت خلص والنت شكله ضعيف شوية، تأكد من الاتصال وجرب تاني.`
  String get firebase_error_deadline_exceeded {
    return Intl.message(
      'الوقت خلص والنت شكله ضعيف شوية، تأكد من الاتصال وجرب تاني.',
      name: 'firebase_error_deadline_exceeded',
      desc: '',
      args: [],
    );
  }

  /// `العملية دي مقدرش أنفذها دلوقتي، حاول مرة تانية لاحقاً.`
  String get firebase_error_failed_precondition {
    return Intl.message(
      'العملية دي مقدرش أنفذها دلوقتي، حاول مرة تانية لاحقاً.',
      name: 'firebase_error_failed_precondition',
      desc: '',
      args: [],
    );
  }

  /// `فيه عطل فني بسيط في النظام، وإحنا شغالين على إصلاحه حالياً.`
  String get firebase_error_internal {
    return Intl.message(
      'فيه عطل فني بسيط في النظام، وإحنا شغالين على إصلاحه حالياً.',
      name: 'firebase_error_internal',
      desc: '',
      args: [],
    );
  }

  /// `فيه بيانات دخلت بشكل غير صحيح، يا ريت تراجع عليها.`
  String get firebase_error_invalid_argument {
    return Intl.message(
      'فيه بيانات دخلت بشكل غير صحيح، يا ريت تراجع عليها.',
      name: 'firebase_error_invalid_argument',
      desc: '',
      args: [],
    );
  }

  /// `للأسف ملقناش الحاجة اللي بتدور عليها، تأكد إنك كاتبها صح.`
  String get firebase_error_not_found {
    return Intl.message(
      'للأسف ملقناش الحاجة اللي بتدور عليها، تأكد إنك كاتبها صح.',
      name: 'firebase_error_not_found',
      desc: '',
      args: [],
    );
  }

  /// `تمت العملية بنجاح، شكراً ليك!`
  String get firebase_error_ok {
    return Intl.message(
      'تمت العملية بنجاح، شكراً ليك!',
      name: 'firebase_error_ok',
      desc: '',
      args: [],
    );
  }

  /// `القيمة اللي دخلتها مش في النطاق المسموح بيه.`
  String get firebase_error_out_of_range {
    return Intl.message(
      'القيمة اللي دخلتها مش في النطاق المسموح بيه.',
      name: 'firebase_error_out_of_range',
      desc: '',
      args: [],
    );
  }

  /// `عذراً، مفيش صلاحية كافية للقيام بالخطوة دي.`
  String get firebase_error_permission_denied {
    return Intl.message(
      'عذراً، مفيش صلاحية كافية للقيام بالخطوة دي.',
      name: 'firebase_error_permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `فيه ضغط كبير حالياً، استنى لحظة وجرب تاني.`
  String get firebase_error_resource_exhausted {
    return Intl.message(
      'فيه ضغط كبير حالياً، استنى لحظة وجرب تاني.',
      name: 'firebase_error_resource_exhausted',
      desc: '',
      args: [],
    );
  }

  /// `من فضلك سجل دخولك الأول عشان تقدر تكمل معانا.`
  String get firebase_error_unauthenticated {
    return Intl.message(
      'من فضلك سجل دخولك الأول عشان تقدر تكمل معانا.',
      name: 'firebase_error_unauthenticated',
      desc: '',
      args: [],
    );
  }

  /// `الخدمة غير متاحة مؤقتاً، بنحاول نرجعها في أسرع وقت.`
  String get firebase_error_unavailable {
    return Intl.message(
      'الخدمة غير متاحة مؤقتاً، بنحاول نرجعها في أسرع وقت.',
      name: 'firebase_error_unavailable',
      desc: '',
      args: [],
    );
  }

  /// `الميزة دي لسه مش متاحة حالياً، انتظرها في التحديثات الجاية.`
  String get firebase_error_unimplemented {
    return Intl.message(
      'الميزة دي لسه مش متاحة حالياً، انتظرها في التحديثات الجاية.',
      name: 'firebase_error_unimplemented',
      desc: '',
      args: [],
    );
  }

  /// `حصل خطأ غير متوقع، يا ريت تحاول مرة تانية.`
  String get firebase_error_unknown {
    return Intl.message(
      'حصل خطأ غير متوقع، يا ريت تحاول مرة تانية.',
      name: 'firebase_error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `حدث خطأ غير متوقع، يرجى المحاولة مرة ثانية أو التأكد من اتصال الإنترنت.`
  String get firebase_error_unexpected {
    return Intl.message(
      'حدث خطأ غير متوقع، يرجى المحاولة مرة ثانية أو التأكد من اتصال الإنترنت.',
      name: 'firebase_error_unexpected',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
