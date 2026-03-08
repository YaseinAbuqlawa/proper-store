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

  /// `الاكثر مبيعاً`
  String get mostSoldSectionTitle {
    return Intl.message(
      'الاكثر مبيعاً',
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

  /// `تفاصيل المنتج`
  String get productDetailsScreenTitle {
    return Intl.message(
      'تفاصيل المنتج',
      name: 'productDetailsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `هذا الحقل مطلوب`
  String get fieldRequired {
    return Intl.message(
      'هذا الحقل مطلوب',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `رقم الهاتف يجب أن يتكون من 10 أرقام`
  String get phoneNumberMustBe10Digits {
    return Intl.message(
      'رقم الهاتف يجب أن يتكون من 10 أرقام',
      name: 'phoneNumberMustBe10Digits',
      desc: '',
      args: [],
    );
  }

  /// `تغيير الرقم`
  String get changePhoneNumber {
    return Intl.message(
      'تغيير الرقم',
      name: 'changePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `رقم الهاتف`
  String get phoneNumberLabel {
    return Intl.message(
      'رقم الهاتف',
      name: 'phoneNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `رمز التحقق`
  String get otpCodeLabel {
    return Intl.message('رمز التحقق', name: 'otpCodeLabel', desc: '', args: []);
  }

  /// `رمز التحقق يجب ان يكون 6 ارقام على الاقل`
  String get otpMustBe6Digits {
    return Intl.message(
      'رمز التحقق يجب ان يكون 6 ارقام على الاقل',
      name: 'otpMustBe6Digits',
      desc: '',
      args: [],
    );
  }

  /// `مرحباً بكِ`
  String get welcomeMessage {
    return Intl.message(
      'مرحباً بكِ',
      name: 'welcomeMessage',
      desc: '',
      args: [],
    );
  }

  /// `سجلي الدخول لمتابعة أحدث صيحات الموضة`
  String get signInToFollowLatestFashion {
    return Intl.message(
      'سجلي الدخول لمتابعة أحدث صيحات الموضة',
      name: 'signInToFollowLatestFashion',
      desc: '',
      args: [],
    );
  }

  /// `الاسم الكامل`
  String get fullNameLabel {
    return Intl.message(
      'الاسم الكامل',
      name: 'fullNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `ادخلي اسمك الكامل`
  String get enterFullNameHint {
    return Intl.message(
      'ادخلي اسمك الكامل',
      name: 'enterFullNameHint',
      desc: '',
      args: [],
    );
  }

  /// `الاسم يجب أن يكون أكثر من حرفين`
  String get nameMustBeMoreThan2Chars {
    return Intl.message(
      'الاسم يجب أن يكون أكثر من حرفين',
      name: 'nameMustBeMoreThan2Chars',
      desc: '',
      args: [],
    );
  }

  /// `تم ارسال رمز التحقق`
  String get otpSentSuccessfully {
    return Intl.message(
      'تم ارسال رمز التحقق',
      name: 'otpSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `التحقق من الرمز`
  String get verifyCode {
    return Intl.message(
      'التحقق من الرمز',
      name: 'verifyCode',
      desc: '',
      args: [],
    );
  }

  /// `تاكيد الرقم`
  String get confirmPhoneNumber {
    return Intl.message(
      'تاكيد الرقم',
      name: 'confirmPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `خطأ`
  String get errorTitle {
    return Intl.message('خطأ', name: 'errorTitle', desc: '', args: []);
  }

  /// `نجاح`
  String get successTitle {
    return Intl.message('نجاح', name: 'successTitle', desc: '', args: []);
  }

  /// `إتمام الشراء`
  String get completeCheckout {
    return Intl.message(
      'إتمام الشراء',
      name: 'completeCheckout',
      desc: '',
      args: [],
    );
  }

  /// `شراء الان`
  String get buyNow {
    return Intl.message('شراء الان', name: 'buyNow', desc: '', args: []);
  }

  /// `إضافة للسلة`
  String get addToCartButton {
    return Intl.message(
      'إضافة للسلة',
      name: 'addToCartButton',
      desc: '',
      args: [],
    );
  }

  /// `خصم {percentage}%`
  String discountLabel(double percentage) {
    return Intl.message(
      'خصم $percentage%',
      name: 'discountLabel',
      desc: '',
      args: [percentage],
    );
  }

  /// `تم تسجيل الدخول بنجاح`
  String get loginSuccess {
    return Intl.message(
      'تم تسجيل الدخول بنجاح',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `سجلي دخولك لتحصلي على افضل خدمة ممكنة`
  String get signInForBestService {
    return Intl.message(
      'سجلي دخولك لتحصلي على افضل خدمة ممكنة',
      name: 'signInForBestService',
      desc: '',
      args: [],
    );
  }

  /// `سجلي بسهولة عبر`
  String get signInEasilyVia {
    return Intl.message(
      'سجلي بسهولة عبر',
      name: 'signInEasilyVia',
      desc: '',
      args: [],
    );
  }

  /// `عناويني`
  String get myAddresses {
    return Intl.message('عناويني', name: 'myAddresses', desc: '', args: []);
  }

  /// `تواصل معنا`
  String get contactUs {
    return Intl.message('تواصل معنا', name: 'contactUs', desc: '', args: []);
  }

  /// `سياسة الاسترجاع`
  String get returnPolicy {
    return Intl.message(
      'سياسة الاسترجاع',
      name: 'returnPolicy',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الخروج`
  String get signOut {
    return Intl.message('تسجيل الخروج', name: 'signOut', desc: '', args: []);
  }

  /// `اللون المختار:`
  String get selectedColor {
    return Intl.message(
      'اللون المختار:',
      name: 'selectedColor',
      desc: '',
      args: [],
    );
  }

  /// `الوصف والتفاصيل`
  String get descriptionAndDetails {
    return Intl.message(
      'الوصف والتفاصيل',
      name: 'descriptionAndDetails',
      desc: '',
      args: [],
    );
  }

  /// `منتجات مشابهة`
  String get similarProducts {
    return Intl.message(
      'منتجات مشابهة',
      name: 'similarProducts',
      desc: '',
      args: [],
    );
  }

  /// `جودة عالية`
  String get highQuality {
    return Intl.message('جودة عالية', name: 'highQuality', desc: '', args: []);
  }

  /// `بأسعار تناسبك`
  String get pricesSuitYou {
    return Intl.message(
      'بأسعار تناسبك',
      name: 'pricesSuitYou',
      desc: '',
      args: [],
    );
  }

  /// `اكتشفي أحدث صيحات الموضة من الأحذية والحقائب في مصر بجودة عالمية.`
  String get discoverLatestFashion {
    return Intl.message(
      'اكتشفي أحدث صيحات الموضة من الأحذية والحقائب في مصر بجودة عالمية.',
      name: 'discoverLatestFashion',
      desc: '',
      args: [],
    );
  }

  /// `التسوق كزائر`
  String get shopAsGuest {
    return Intl.message(
      'التسوق كزائر',
      name: 'shopAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `او سجلي الدخول بسهولة`
  String get orSignInEasily {
    return Intl.message(
      'او سجلي الدخول بسهولة',
      name: 'orSignInEasily',
      desc: '',
      args: [],
    );
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

  /// `إضافة عنوان`
  String get addAddressTitle {
    return Intl.message(
      'إضافة عنوان',
      name: 'addAddressTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد عناوين بعد`
  String get noAddressesYet {
    return Intl.message(
      'لا توجد عناوين بعد',
      name: 'noAddressesYet',
      desc: '',
      args: [],
    );
  }

  /// `أضف عنوانك الأول للبدء`
  String get addFirstAddress {
    return Intl.message(
      'أضف عنوانك الأول للبدء',
      name: 'addFirstAddress',
      desc: '',
      args: [],
    );
  }

  /// `نوع العنوان`
  String get addressLabelLabel {
    return Intl.message(
      'نوع العنوان',
      name: 'addressLabelLabel',
      desc: '',
      args: [],
    );
  }

  /// `مثال: المنزل، العمل`
  String get addressLabelHint {
    return Intl.message(
      'مثال: المنزل، العمل',
      name: 'addressLabelHint',
      desc: '',
      args: [],
    );
  }

  /// `المدينة`
  String get cityLabel {
    return Intl.message('المدينة', name: 'cityLabel', desc: '', args: []);
  }

  /// `المنطقة / الحي`
  String get areaLabel {
    return Intl.message(
      'المنطقة / الحي',
      name: 'areaLabel',
      desc: '',
      args: [],
    );
  }

  /// `الشارع`
  String get streetLabel {
    return Intl.message('الشارع', name: 'streetLabel', desc: '', args: []);
  }

  /// `رقم المبنى`
  String get buildingNumberLabel {
    return Intl.message(
      'رقم المبنى',
      name: 'buildingNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `الدور`
  String get floorLabel {
    return Intl.message('الدور', name: 'floorLabel', desc: '', args: []);
  }

  /// `رقم الشقة`
  String get apartmentLabel {
    return Intl.message(
      'رقم الشقة',
      name: 'apartmentLabel',
      desc: '',
      args: [],
    );
  }

  /// `تعيين كعنوان افتراضي`
  String get setAsDefault {
    return Intl.message(
      'تعيين كعنوان افتراضي',
      name: 'setAsDefault',
      desc: '',
      args: [],
    );
  }

  /// `حفظ العنوان`
  String get saveAddress {
    return Intl.message('حفظ العنوان', name: 'saveAddress', desc: '', args: []);
  }

  /// `تم حفظ العنوان بنجاح`
  String get addressSaved {
    return Intl.message(
      'تم حفظ العنوان بنجاح',
      name: 'addressSaved',
      desc: '',
      args: [],
    );
  }

  /// `تم حذف العنوان`
  String get addressDeleted {
    return Intl.message(
      'تم حذف العنوان',
      name: 'addressDeleted',
      desc: '',
      args: [],
    );
  }

  /// `افتراضي`
  String get defaultBadge {
    return Intl.message('افتراضي', name: 'defaultBadge', desc: '', args: []);
  }

  /// `هل أنت متأكد من حذف هذا العنوان؟`
  String get deleteAddressConfirm {
    return Intl.message(
      'هل أنت متأكد من حذف هذا العنوان؟',
      name: 'deleteAddressConfirm',
      desc: '',
      args: [],
    );
  }

  /// `إلغاء`
  String get cancel {
    return Intl.message('إلغاء', name: 'cancel', desc: '', args: []);
  }

  /// `حذف`
  String get delete {
    return Intl.message('حذف', name: 'delete', desc: '', args: []);
  }

  /// `رقم الهاتف يجب أن يتكون من 11 أرقام`
  String get phoneNumberMustBe11Digits {
    return Intl.message(
      'رقم الهاتف يجب أن يتكون من 11 أرقام',
      name: 'phoneNumberMustBe11Digits',
      desc: '',
      args: [],
    );
  }

  /// `إعادة المحاولة`
  String get retry {
    return Intl.message('إعادة المحاولة', name: 'retry', desc: '', args: []);
  }

  /// `لا توجد طلبات بعد`
  String get noOrdersYet {
    return Intl.message(
      'لا توجد طلبات بعد',
      name: 'noOrdersYet',
      desc: '',
      args: [],
    );
  }

  /// `طلباتك ستظهر هنا بعد أول عملية شراء`
  String get noOrdersYetMessage {
    return Intl.message(
      'طلباتك ستظهر هنا بعد أول عملية شراء',
      name: 'noOrdersYetMessage',
      desc: '',
      args: [],
    );
  }

  /// `قيد الانتظار`
  String get orderStatusPending {
    return Intl.message(
      'قيد الانتظار',
      name: 'orderStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `مؤكد`
  String get orderStatusConfirmed {
    return Intl.message(
      'مؤكد',
      name: 'orderStatusConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `تم الشحن`
  String get orderStatusShipped {
    return Intl.message(
      'تم الشحن',
      name: 'orderStatusShipped',
      desc: '',
      args: [],
    );
  }

  /// `تم التسليم`
  String get orderStatusDelivered {
    return Intl.message(
      'تم التسليم',
      name: 'orderStatusDelivered',
      desc: '',
      args: [],
    );
  }

  /// `ملغي`
  String get orderStatusCancelled {
    return Intl.message(
      'ملغي',
      name: 'orderStatusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `الإجمالي`
  String get orderTotalLabel {
    return Intl.message(
      'الإجمالي',
      name: 'orderTotalLabel',
      desc: '',
      args: [],
    );
  }

  /// `الدفع عند الاستلام`
  String get paymentCOD {
    return Intl.message(
      'الدفع عند الاستلام',
      name: 'paymentCOD',
      desc: '',
      args: [],
    );
  }

  /// `رقم الطلب`
  String get orderNumberLabel {
    return Intl.message(
      'رقم الطلب',
      name: 'orderNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `عرض التفاصيل`
  String get orderDetails {
    return Intl.message(
      'عرض التفاصيل',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل الطلب`
  String get orderDetailsTitle {
    return Intl.message(
      'تفاصيل الطلب',
      name: 'orderDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `حالة الطلب`
  String get orderStatusTitle {
    return Intl.message(
      'حالة الطلب',
      name: 'orderStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `تجهيز`
  String get orderStepPreparing {
    return Intl.message(
      'تجهيز',
      name: 'orderStepPreparing',
      desc: '',
      args: [],
    );
  }

  /// `شحن`
  String get orderStepShipping {
    return Intl.message('شحن', name: 'orderStepShipping', desc: '', args: []);
  }

  /// `توصيل`
  String get orderStepDelivery {
    return Intl.message('توصيل', name: 'orderStepDelivery', desc: '', args: []);
  }

  /// `تم الطلب:`
  String get orderedOnLabel {
    return Intl.message(
      'تم الطلب:',
      name: 'orderedOnLabel',
      desc: '',
      args: [],
    );
  }

  /// `إتمام الشراء`
  String get checkoutTitle {
    return Intl.message(
      'إتمام الشراء',
      name: 'checkoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `ملخص الطلب`
  String get orderSummaryTitle {
    return Intl.message(
      'ملخص الطلب',
      name: 'orderSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `عنوان الشحن`
  String get shippingAddressTitle {
    return Intl.message(
      'عنوان الشحن',
      name: 'shippingAddressTitle',
      desc: '',
      args: [],
    );
  }

  /// `طريقة الدفع`
  String get paymentMethodTitle {
    return Intl.message(
      'طريقة الدفع',
      name: 'paymentMethodTitle',
      desc: '',
      args: [],
    );
  }

  /// `تأكيد الطلب`
  String get placeOrderButton {
    return Intl.message(
      'تأكيد الطلب',
      name: 'placeOrderButton',
      desc: '',
      args: [],
    );
  }

  /// `يرجى اختيار عنوان للشحن`
  String get noAddressSelected {
    return Intl.message(
      'يرجى اختيار عنوان للشحن',
      name: 'noAddressSelected',
      desc: '',
      args: [],
    );
  }

  /// `إضافة عنوان جديد`
  String get addNewAddress {
    return Intl.message(
      'إضافة عنوان جديد',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `مجاني`
  String get shippingFree {
    return Intl.message('مجاني', name: 'shippingFree', desc: '', args: []);
  }

  /// `الشحن`
  String get shippingLabel {
    return Intl.message('الشحن', name: 'shippingLabel', desc: '', args: []);
  }

  /// `غير متاح لهذه المنطقة`
  String get shippingNotAvailable {
    return Intl.message(
      'غير متاح لهذه المنطقة',
      name: 'shippingNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `الإجمالي قبل الخصم`
  String get subtotalLabel {
    return Intl.message(
      'الإجمالي قبل الخصم',
      name: 'subtotalLabel',
      desc: '',
      args: [],
    );
  }

  /// `الخصم`
  String get discountAmountLabel {
    return Intl.message(
      'الخصم',
      name: 'discountAmountLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم تأكيد طلبك!`
  String get orderConfirmedTitle {
    return Intl.message(
      'تم تأكيد طلبك!',
      name: 'orderConfirmedTitle',
      desc: '',
      args: [],
    );
  }

  /// `سيتم التواصل معك قريباً لتأكيد موعد التوصيل`
  String get orderConfirmedMessage {
    return Intl.message(
      'سيتم التواصل معك قريباً لتأكيد موعد التوصيل',
      name: 'orderConfirmedMessage',
      desc: '',
      args: [],
    );
  }

  /// `متابعة التسوق`
  String get continueShopping {
    return Intl.message(
      'متابعة التسوق',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `سجلي دخولك`
  String get loginToCheckout {
    return Intl.message(
      'سجلي دخولك',
      name: 'loginToCheckout',
      desc: '',
      args: [],
    );
  }

  /// `سجلي دخولك لمتابعة طلباتك والاستمتاع بأفضل تجربة تسوق`
  String get loginToCheckoutMessage {
    return Intl.message(
      'سجلي دخولك لمتابعة طلباتك والاستمتاع بأفضل تجربة تسوق',
      name: 'loginToCheckoutMessage',
      desc: '',
      args: [],
    );
  }

  /// `تمت الإضافة للسلة بنجاح`
  String get addedToCart {
    return Intl.message(
      'تمت الإضافة للسلة بنجاح',
      name: 'addedToCart',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الدخول بجوجل`
  String get signInWithGoogle {
    return Intl.message(
      'تسجيل الدخول بجوجل',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الدخول بفيسبوك`
  String get signInWithFacebook {
    return Intl.message(
      'تسجيل الدخول بفيسبوك',
      name: 'signInWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `الإجمالي النهائي`
  String get grandTotalLabel {
    return Intl.message(
      'الإجمالي النهائي',
      name: 'grandTotalLabel',
      desc: '',
      args: [],
    );
  }

  /// `الكمية: {count}`
  String quantityLabel(int count) {
    return Intl.message(
      'الكمية: $count',
      name: 'quantityLabel',
      desc: '',
      args: [count],
    );
  }

  /// `+{count} منتجات أخرى`
  String moreProductsLabel(int count) {
    return Intl.message(
      '+$count منتجات أخرى',
      name: 'moreProductsLabel',
      desc: '',
      args: [count],
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
