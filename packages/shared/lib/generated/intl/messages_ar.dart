// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(percentage) => "خصم ${percentage}%";

  static String m1(count) => "تم تخطي ${count} صورة — حجمها أكبر من 5 ميجابايت";

  static String m2(productName, available) =>
      "المنتج ${productName} متوفر ${available} قطعة فقط";

  static String m3(count) => "+${count} منتجات أخرى";

  static String m4(count) => "${count} طلبات";

  static String m5(productName) => "المنتج ${productName} غير متوفر حالياً";

  static String m6(count) => "الكمية: ${count}";

  static String m7(count) => "${count} مبيعة";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "actionsLabel": MessageLookupByLibrary.simpleMessage("الإجراءات"),
    "actualSoldLabel": MessageLookupByLibrary.simpleMessage("الفعلي"),
    "addAddressTitle": MessageLookupByLibrary.simpleMessage("إضافة عنوان"),
    "addBtn": MessageLookupByLibrary.simpleMessage("إضافة"),
    "addCategory": MessageLookupByLibrary.simpleMessage("إضافة قسم"),
    "addFirstAddress": MessageLookupByLibrary.simpleMessage(
      "أضف عنوانك الأول للبدء",
    ),
    "addGovernorate": MessageLookupByLibrary.simpleMessage("إضافة محافظة"),
    "addNewAddress": MessageLookupByLibrary.simpleMessage("إضافة عنوان جديد"),
    "addNewCategoryBtn": MessageLookupByLibrary.simpleMessage("إضافة قسم جديد"),
    "addStaffBtn": MessageLookupByLibrary.simpleMessage("إضافة موظف"),
    "addToCartButton": MessageLookupByLibrary.simpleMessage("إضافة للسلة"),
    "addToCartText": MessageLookupByLibrary.simpleMessage("أضف للسلة"),
    "addedToCart": MessageLookupByLibrary.simpleMessage(
      "تمت الإضافة للسلة بنجاح",
    ),
    "addressCopiedLabel": MessageLookupByLibrary.simpleMessage(
      "تم نسخ العنوان",
    ),
    "addressDeleted": MessageLookupByLibrary.simpleMessage("تم حذف العنوان"),
    "addressLabelHint": MessageLookupByLibrary.simpleMessage(
      "مثال: المنزل، العمل",
    ),
    "addressLabelLabel": MessageLookupByLibrary.simpleMessage("نوع العنوان"),
    "addressSaved": MessageLookupByLibrary.simpleMessage(
      "تم حفظ العنوان بنجاح",
    ),
    "adminAppSubtitle": MessageLookupByLibrary.simpleMessage(
      "Proper Store Admin",
    ),
    "allOrdersFilter": MessageLookupByLibrary.simpleMessage("الكل"),
    "apartmentLabel": MessageLookupByLibrary.simpleMessage("رقم الشقة"),
    "appTitle": MessageLookupByLibrary.simpleMessage("لوحة تحكم المتجر"),
    "areaLabel": MessageLookupByLibrary.simpleMessage("المنطقة / الحي"),
    "avgOrderValueLabel": MessageLookupByLibrary.simpleMessage(
      "متوسط قيمة الطلب",
    ),
    "backToHome": MessageLookupByLibrary.simpleMessage("العودة للرئيسية"),
    "bannerBadgeLabel": MessageLookupByLibrary.simpleMessage("نص الشارة"),
    "bannerCollectionLabel": MessageLookupByLibrary.simpleMessage(
      "اسم المجموعة",
    ),
    "bannerDescriptionLabel": MessageLookupByLibrary.simpleMessage("الوصف"),
    "bannerImageRequired": MessageLookupByLibrary.simpleMessage(
      "يرجى إضافة صورة للبنر",
    ),
    "bannerSectionTitle": MessageLookupByLibrary.simpleMessage("بنر المجموعة"),
    "bannerTitleLabel": MessageLookupByLibrary.simpleMessage("عنوان البنر"),
    "buildingNumberLabel": MessageLookupByLibrary.simpleMessage("رقم المبنى"),
    "buyNow": MessageLookupByLibrary.simpleMessage("شراء الان"),
    "cancel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cancelBtn": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "cancellationRateLabel": MessageLookupByLibrary.simpleMessage(
      "نسبة الإلغاء",
    ),
    "cannotDeleteLastSuperAdmin": MessageLookupByLibrary.simpleMessage(
      "لا يمكن حذف آخر مدير عام. قم بتعيين مدير عام آخر أولاً.",
    ),
    "cannotDeleteYourself": MessageLookupByLibrary.simpleMessage(
      "لا يمكنك حذف حسابك الخاص.",
    ),
    "cartTitle": MessageLookupByLibrary.simpleMessage("السلة"),
    "categories": MessageLookupByLibrary.simpleMessage("الاقسام"),
    "categoriesEmpty": MessageLookupByLibrary.simpleMessage(
      "لا توجد أقسام بعد",
    ),
    "categoriesSectionTitle": MessageLookupByLibrary.simpleMessage("الأقسام"),
    "categoryImageRequired": MessageLookupByLibrary.simpleMessage(
      "يرجى إضافة صورة للتصنيف",
    ),
    "categoryNameHint": MessageLookupByLibrary.simpleMessage(
      "مثلاً: ملابس شتوية",
    ),
    "categoryNameInvalid": MessageLookupByLibrary.simpleMessage(
      "اسم التصنيف يجب أن يحتوي فقط على أحرف أو أرقام أو مسافات أو _ أو - (بحد أقصى 40 حرفًا)",
    ),
    "categoryNameLabel": MessageLookupByLibrary.simpleMessage("اسم القسم"),
    "changePasswordBtn": MessageLookupByLibrary.simpleMessage(
      "تغيير كلمة المرور",
    ),
    "changePhoneNumber": MessageLookupByLibrary.simpleMessage("تغيير الرقم"),
    "changeRoleBtn": MessageLookupByLibrary.simpleMessage("تغيير الصلاحية"),
    "checkoutTitle": MessageLookupByLibrary.simpleMessage("إتمام الشراء"),
    "cityLabel": MessageLookupByLibrary.simpleMessage("المدينة"),
    "colorLabel": MessageLookupByLibrary.simpleMessage("اللون:"),
    "comingSoon": MessageLookupByLibrary.simpleMessage("قريباً"),
    "completeCheckout": MessageLookupByLibrary.simpleMessage("إتمام الشراء"),
    "confirmDeleteCategory": MessageLookupByLibrary.simpleMessage(
      "هل تريد حذف هذا القسم؟",
    ),
    "confirmDeleteGovernorate": MessageLookupByLibrary.simpleMessage(
      "هل تريد حذف هذه المحافظة؟",
    ),
    "confirmDeleteImage": MessageLookupByLibrary.simpleMessage(
      "هل تريد حذف هذه الصورة؟",
    ),
    "confirmLabel": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "confirmPhoneNumber": MessageLookupByLibrary.simpleMessage("تاكيد الرقم"),
    "confirmStatusUpdateMessage": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد من تغيير حالة الطلب؟",
    ),
    "confirmStatusUpdateTitle": MessageLookupByLibrary.simpleMessage(
      "تأكيد تحديث الحالة",
    ),
    "contactUs": MessageLookupByLibrary.simpleMessage("تواصل معنا"),
    "continueAsGuest": MessageLookupByLibrary.simpleMessage("المتابعة كزائرة"),
    "continueShopping": MessageLookupByLibrary.simpleMessage("متابعة التسوق"),
    "copyAddressLabel": MessageLookupByLibrary.simpleMessage("نسخ العنوان"),
    "copyLabel": MessageLookupByLibrary.simpleMessage("نسخ"),
    "currencySymbol": MessageLookupByLibrary.simpleMessage(" ج.م"),
    "customerCartEmpty": MessageLookupByLibrary.simpleMessage(
      "لا توجد منتجات في السلة",
    ),
    "customerCartTitle": MessageLookupByLibrary.simpleMessage("سلة التسوق"),
    "customerDataLabel": MessageLookupByLibrary.simpleMessage("بيانات العميل"),
    "customerFavoritesEmpty": MessageLookupByLibrary.simpleMessage(
      "لا توجد منتجات مفضلة",
    ),
    "customerFavoritesTitle": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "customerNameLabel": MessageLookupByLibrary.simpleMessage("الاسم"),
    "customerOrdersTitle": MessageLookupByLibrary.simpleMessage("طلبات العميل"),
    "customerPhoneLabel": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "customersEmpty": MessageLookupByLibrary.simpleMessage("لا يوجد عملاء"),
    "customersSearchHint": MessageLookupByLibrary.simpleMessage(
      "ابحث بالاسم أو البريد الإلكتروني...",
    ),
    "dailyRevenueChartTitle": MessageLookupByLibrary.simpleMessage(
      "الإيرادات اليومية (آخر 30 يوم)",
    ),
    "darkModeLabel": MessageLookupByLibrary.simpleMessage("الوضع الداكن"),
    "dashboardTitle": MessageLookupByLibrary.simpleMessage("لوحة التحكم"),
    "defaultBadge": MessageLookupByLibrary.simpleMessage("افتراضي"),
    "delete": MessageLookupByLibrary.simpleMessage("حذف"),
    "deleteAddressConfirm": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد من حذف هذا العنوان؟",
    ),
    "deleteBtn": MessageLookupByLibrary.simpleMessage("حذف"),
    "deleteStaffBtn": MessageLookupByLibrary.simpleMessage("حذف"),
    "deleteStaffConfirm": MessageLookupByLibrary.simpleMessage(
      "هل أنت متأكد من حذف هذا الموظف؟",
    ),
    "descriptionAndDetails": MessageLookupByLibrary.simpleMessage(
      "الوصف والتفاصيل",
    ),
    "discountAmountLabel": MessageLookupByLibrary.simpleMessage("الخصم"),
    "discountLabel": m0,
    "discoverLatestFashion": MessageLookupByLibrary.simpleMessage(
      "اكتشفي أحدث صيحات الموضة من الأحذية والحقائب في مصر بجودة عالمية.",
    ),
    "editBtn": MessageLookupByLibrary.simpleMessage("تعديل"),
    "editShippingCostTitle": MessageLookupByLibrary.simpleMessage(
      "تعديل تكلفة الشحن",
    ),
    "emailLabel": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "emailValidation": MessageLookupByLibrary.simpleMessage(
      "أدخل البريد الإلكتروني",
    ),
    "emptyCartMessage": MessageLookupByLibrary.simpleMessage(
      "سلة التسوق فارغة، أضف منتجات تعجبك!",
    ),
    "emptyCartShopNow": MessageLookupByLibrary.simpleMessage("تسوقي الآن"),
    "emptyFavoritesMessage": MessageLookupByLibrary.simpleMessage(
      "قائمة المفضلة فارغة، احفظي ما يعجبك!",
    ),
    "emptyFavoritesShopNow": MessageLookupByLibrary.simpleMessage("تسوقي الآن"),
    "enterFullNameHint": MessageLookupByLibrary.simpleMessage(
      "ادخلي اسمك الكامل",
    ),
    "errorAccessDenied": MessageLookupByLibrary.simpleMessage(
      "ليس لديك صلاحية الوصول لهذه اللوحة",
    ),
    "errorRequired": MessageLookupByLibrary.simpleMessage("هذا الحقل مطلوب"),
    "errorTitle": MessageLookupByLibrary.simpleMessage("خطأ"),
    "errorUnexpected": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ غير متوقع، حاول مجدداً",
    ),
    "favoritesTitle": MessageLookupByLibrary.simpleMessage("المفضلة"),
    "fieldRequired": MessageLookupByLibrary.simpleMessage("هذا الحقل مطلوب"),
    "firebase_error_aborted": MessageLookupByLibrary.simpleMessage(
      "حصلت مشكلة بسيطة والعملية اتوقفت، ممكن تحاول مرة تانية؟",
    ),
    "firebase_error_access_denied": MessageLookupByLibrary.simpleMessage(
      "ليس لديك صلاحية الوصول لهذه اللوحة",
    ),
    "firebase_error_already_exists": MessageLookupByLibrary.simpleMessage(
      "البيانات دي موجودة عندنا بالفعل، يا ريت تتأكد منها.",
    ),
    "firebase_error_cancelled": MessageLookupByLibrary.simpleMessage(
      "تم إلغاء العملية بناءً على طلبك.",
    ),
    "firebase_error_data_loss": MessageLookupByLibrary.simpleMessage(
      "عذراً، حصل فقد في البيانات، يا ريت تبلغ الدعم الفني لمساعدتك.",
    ),
    "firebase_error_deadline_exceeded": MessageLookupByLibrary.simpleMessage(
      "الوقت خلص والنت شكله ضعيف شوية، تأكد من الاتصال وجرب تاني.",
    ),
    "firebase_error_failed_precondition": MessageLookupByLibrary.simpleMessage(
      "العملية دي مقدرش أنفذها دلوقتي، حاول مرة تانية لاحقاً.",
    ),
    "firebase_error_internal": MessageLookupByLibrary.simpleMessage(
      "فيه عطل فني بسيط في النظام، وإحنا شغالين على إصلاحه حالياً.",
    ),
    "firebase_error_invalid_argument": MessageLookupByLibrary.simpleMessage(
      "فيه بيانات دخلت بشكل غير صحيح، يا ريت تراجع عليها.",
    ),
    "firebase_error_invalid_email": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني غير صالح",
    ),
    "firebase_error_network_request_failed":
        MessageLookupByLibrary.simpleMessage("تحقق من الاتصال بالإنترنت"),
    "firebase_error_not_found": MessageLookupByLibrary.simpleMessage(
      "للأسف ملقناش الحاجة اللي بتدور عليها، تأكد إنك كاتبها صح.",
    ),
    "firebase_error_ok": MessageLookupByLibrary.simpleMessage(
      "تمت العملية بنجاح، شكراً ليك!",
    ),
    "firebase_error_out_of_range": MessageLookupByLibrary.simpleMessage(
      "القيمة اللي دخلتها مش في النطاق المسموح بيه.",
    ),
    "firebase_error_permission_denied": MessageLookupByLibrary.simpleMessage(
      "عذراً، مفيش صلاحية كافية للقيام بالخطوة دي.",
    ),
    "firebase_error_resource_exhausted": MessageLookupByLibrary.simpleMessage(
      "فيه ضغط كبير حالياً، استنى لحظة وجرب تاني.",
    ),
    "firebase_error_too_many_requests": MessageLookupByLibrary.simpleMessage(
      "محاولات كثيرة، حاول لاحقاً",
    ),
    "firebase_error_unauthenticated": MessageLookupByLibrary.simpleMessage(
      "من فضلك سجل دخولك الأول عشان تقدر تكمل معانا.",
    ),
    "firebase_error_unavailable": MessageLookupByLibrary.simpleMessage(
      "الخدمة غير متاحة مؤقتاً، بنحاول نرجعها في أسرع وقت.",
    ),
    "firebase_error_unexpected": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ غير متوقع، يرجى المحاولة مرة ثانية أو التأكد من اتصال الإنترنت.",
    ),
    "firebase_error_unimplemented": MessageLookupByLibrary.simpleMessage(
      "الميزة دي لسه مش متاحة حالياً، انتظرها في التحديثات الجاية.",
    ),
    "firebase_error_unknown": MessageLookupByLibrary.simpleMessage(
      "حصل خطأ غير متوقع، يا ريت تحاول مرة تانية.",
    ),
    "firebase_error_user_disabled": MessageLookupByLibrary.simpleMessage(
      "تم تعطيل هذا الحساب",
    ),
    "firebase_error_user_not_found": MessageLookupByLibrary.simpleMessage(
      "المستخدم غير موجود",
    ),
    "firebase_error_wrong_password": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور غير صحيحة",
    ),
    "floorLabel": MessageLookupByLibrary.simpleMessage("الدور"),
    "freeShippingLabel": MessageLookupByLibrary.simpleMessage("مجاني"),
    "fullNameLabel": MessageLookupByLibrary.simpleMessage("الاسم الكامل"),
    "governorateAlreadyAdded": MessageLookupByLibrary.simpleMessage(
      "هذه المحافظة مضافة بالفعل",
    ),
    "grandTotalLabel": MessageLookupByLibrary.simpleMessage("الإجمالي النهائي"),
    "highQuality": MessageLookupByLibrary.simpleMessage("جودة عالية"),
    "homeButtonName": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "homeTitle": MessageLookupByLibrary.simpleMessage("PROPER"),
    "imageProcessingFailed": MessageLookupByLibrary.simpleMessage(
      "تعذّر معالجة الصورة المحددة. حاول باستخدام ملف آخر.",
    ),
    "imageTooLarge": MessageLookupByLibrary.simpleMessage(
      "حجم الصورة كبير جدًا. الحد الأقصى 5 ميجابايت",
    ),
    "imagesSkippedTooLarge": m1,
    "loadOutOfStockBtn": MessageLookupByLibrary.simpleMessage(
      "تحميل المنتجات النافذة",
    ),
    "loadOutOfStockError": MessageLookupByLibrary.simpleMessage(
      "فشل تحميل المنتجات النافذة",
    ),
    "loadingTitle": MessageLookupByLibrary.simpleMessage("جاري التحميل"),
    "loginButton": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "loginSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الدخول بنجاح",
    ),
    "loginTitle": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "loginToCheckout": MessageLookupByLibrary.simpleMessage("سجلي دخولك"),
    "loginToCheckoutMessage": MessageLookupByLibrary.simpleMessage(
      "سجلي دخولك لمتابعة طلباتك والاستمتاع بأفضل تجربة تسوق",
    ),
    "logoutButton": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "lowStockProduct": m2,
    "mainCollectionBannerButtonText": MessageLookupByLibrary.simpleMessage(
      "تسوقي الان",
    ),
    "monthlyRevenueChartTitle": MessageLookupByLibrary.simpleMessage(
      "الإيرادات الشهرية",
    ),
    "moreProductsLabel": m3,
    "mostSoldSectionTitle": MessageLookupByLibrary.simpleMessage(
      "الاكثر مبيعاً",
    ),
    "myAddresses": MessageLookupByLibrary.simpleMessage("عناويني"),
    "nameCopiedLabel": MessageLookupByLibrary.simpleMessage("تم نسخ الاسم"),
    "nameMustBeMoreThan2Chars": MessageLookupByLibrary.simpleMessage(
      "الاسم يجب أن يكون أكثر من حرفين",
    ),
    "navCustomers": MessageLookupByLibrary.simpleMessage("العملاء"),
    "navOrders": MessageLookupByLibrary.simpleMessage("الطلبات"),
    "navProducts": MessageLookupByLibrary.simpleMessage("المنتجات"),
    "navStoreConfig": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "netRevenueLabel": MessageLookupByLibrary.simpleMessage("صافي الإيرادات"),
    "noAddressSelected": MessageLookupByLibrary.simpleMessage(
      "يرجى اختيار عنوان للشحن",
    ),
    "noAddressesYet": MessageLookupByLibrary.simpleMessage(
      "لا توجد عناوين بعد",
    ),
    "noDataAvailable": MessageLookupByLibrary.simpleMessage("لا توجد بيانات"),
    "noGovernoratesToAdd": MessageLookupByLibrary.simpleMessage(
      "جميع المحافظات مضافة",
    ),
    "noOrdersYet": MessageLookupByLibrary.simpleMessage("لا توجد طلبات بعد"),
    "noOrdersYetMessage": MessageLookupByLibrary.simpleMessage(
      "طلباتك ستظهر هنا بعد أول عملية شراء",
    ),
    "noProductsYet": MessageLookupByLibrary.simpleMessage("لا توجد منتجات"),
    "notFoundTitle": MessageLookupByLibrary.simpleMessage("الصفحة غير موجودة"),
    "orDivider": MessageLookupByLibrary.simpleMessage("أو"),
    "orSignInEasily": MessageLookupByLibrary.simpleMessage(
      "او سجلي الدخول بسهولة",
    ),
    "orderAccountSummaryLabel": MessageLookupByLibrary.simpleMessage(
      "ملخص الحساب",
    ),
    "orderConfirmedMessage": MessageLookupByLibrary.simpleMessage(
      "سيتم التواصل معك قريباً لتأكيد موعد التوصيل",
    ),
    "orderConfirmedTitle": MessageLookupByLibrary.simpleMessage(
      "تم تأكيد طلبك!",
    ),
    "orderCountLabel": m4,
    "orderCustomerLabel": MessageLookupByLibrary.simpleMessage("العميل"),
    "orderDateLabel": MessageLookupByLibrary.simpleMessage("التاريخ"),
    "orderDetails": MessageLookupByLibrary.simpleMessage("عرض التفاصيل"),
    "orderDetailsTitle": MessageLookupByLibrary.simpleMessage("تفاصيل الطلب"),
    "orderItemsLabel": MessageLookupByLibrary.simpleMessage("عناصر الطلب"),
    "orderNumberLabel": MessageLookupByLibrary.simpleMessage("رقم الطلب"),
    "orderPaymentMethodLabel": MessageLookupByLibrary.simpleMessage(
      "طريقة الدفع",
    ),
    "orderPriceBreakdownLabel": MessageLookupByLibrary.simpleMessage(
      "تفاصيل السعر",
    ),
    "orderProductsLabel": MessageLookupByLibrary.simpleMessage("المنتجات"),
    "orderShippingAddressLabel": MessageLookupByLibrary.simpleMessage(
      "عنوان الشحن",
    ),
    "orderStatusCancelled": MessageLookupByLibrary.simpleMessage("ملغي"),
    "orderStatusConfirmed": MessageLookupByLibrary.simpleMessage("مؤكد"),
    "orderStatusDelivered": MessageLookupByLibrary.simpleMessage("تم التسليم"),
    "orderStatusPending": MessageLookupByLibrary.simpleMessage("قيد الانتظار"),
    "orderStatusRefunded": MessageLookupByLibrary.simpleMessage("تم الاسترداد"),
    "orderStatusShipped": MessageLookupByLibrary.simpleMessage("تم الشحن"),
    "orderStatusTitle": MessageLookupByLibrary.simpleMessage("حالة الطلب"),
    "orderStatusUpdateFailed": MessageLookupByLibrary.simpleMessage(
      "فشل تحديث حالة الطلب",
    ),
    "orderStatusUpdated": MessageLookupByLibrary.simpleMessage(
      "تم تحديث حالة الطلب",
    ),
    "orderStepDelivery": MessageLookupByLibrary.simpleMessage("توصيل"),
    "orderStepPreparing": MessageLookupByLibrary.simpleMessage("تجهيز"),
    "orderStepShipping": MessageLookupByLibrary.simpleMessage("شحن"),
    "orderSummaryTitle": MessageLookupByLibrary.simpleMessage("ملخص الطلب"),
    "orderTotalLabel": MessageLookupByLibrary.simpleMessage("الإجمالي"),
    "orderedOnLabel": MessageLookupByLibrary.simpleMessage("تم الطلب:"),
    "ordersEmpty": MessageLookupByLibrary.simpleMessage("لا توجد طلبات"),
    "ordersSearchHint": MessageLookupByLibrary.simpleMessage(
      "بحث برقم الطلب...",
    ),
    "ordersSearchScopeHint": MessageLookupByLibrary.simpleMessage(
      "البحث في الطلبات المحملة فقط",
    ),
    "ordersStatusChartTitle": MessageLookupByLibrary.simpleMessage(
      "الطلبات حسب الحالة",
    ),
    "ordersTitle": MessageLookupByLibrary.simpleMessage("طلباتي"),
    "otpCodeLabel": MessageLookupByLibrary.simpleMessage("رمز التحقق"),
    "otpMustBe6Digits": MessageLookupByLibrary.simpleMessage(
      "رمز التحقق يجب ان يكون 6 ارقام على الاقل",
    ),
    "otpSentSuccessfully": MessageLookupByLibrary.simpleMessage(
      "تم ارسال رمز التحقق",
    ),
    "outOfStockLabel": MessageLookupByLibrary.simpleMessage("نفذ المخزون"),
    "outOfStockProduct": m5,
    "passwordLabel": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "passwordValidation": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة المرور",
    ),
    "paymentCOD": MessageLookupByLibrary.simpleMessage("الدفع عند الاستلام"),
    "paymentMethodTitle": MessageLookupByLibrary.simpleMessage("طريقة الدفع"),
    "phoneCopiedLabel": MessageLookupByLibrary.simpleMessage(
      "تم نسخ رقم الهاتف",
    ),
    "phoneNumberLabel": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "phoneNumberMustBe10Digits": MessageLookupByLibrary.simpleMessage(
      "رقم الهاتف يجب أن يتكون من 10 أرقام",
    ),
    "phoneNumberMustBe11Digits": MessageLookupByLibrary.simpleMessage(
      "رقم الهاتف يجب أن يتكون من 11 أرقام",
    ),
    "placeOrderButton": MessageLookupByLibrary.simpleMessage("تأكيد الطلب"),
    "pricesSuitYou": MessageLookupByLibrary.simpleMessage("بأسعار تناسبك"),
    "productDeleteMessage": MessageLookupByLibrary.simpleMessage(
      "هل تريد حذف هذا المنتج نهائياً؟ لا يمكن التراجع.",
    ),
    "productDeleteTitle": MessageLookupByLibrary.simpleMessage("حذف المنتج"),
    "productDetailsScreenTitle": MessageLookupByLibrary.simpleMessage(
      "تفاصيل المنتج",
    ),
    "productFormAddBtn": MessageLookupByLibrary.simpleMessage("إضافة المنتج"),
    "productFormAddCategory": MessageLookupByLibrary.simpleMessage(
      "إضافة تصنيف جديد",
    ),
    "productFormAddColor": MessageLookupByLibrary.simpleMessage("إضافة لون"),
    "productFormAddTitle": MessageLookupByLibrary.simpleMessage(
      "إضافة منتج جديد",
    ),
    "productFormCategoryHint": MessageLookupByLibrary.simpleMessage(
      "اسم التصنيف",
    ),
    "productFormChangeImage": MessageLookupByLibrary.simpleMessage(
      "تغيير الصورة",
    ),
    "productFormColorChangeImage": MessageLookupByLibrary.simpleMessage(
      "تغيير الصورة",
    ),
    "productFormColorName": MessageLookupByLibrary.simpleMessage("اسم اللون"),
    "productFormColorPickImage": MessageLookupByLibrary.simpleMessage(
      "إضافة صورة",
    ),
    "productFormColorStock": MessageLookupByLibrary.simpleMessage("المخزون"),
    "productFormEditTitle": MessageLookupByLibrary.simpleMessage(
      "تعديل المنتج",
    ),
    "productFormErrorAtLeastOneColor": MessageLookupByLibrary.simpleMessage(
      "يرجى إضافة لون واحد على الأقل",
    ),
    "productFormErrorColorMustHaveImage": MessageLookupByLibrary.simpleMessage(
      "كل لون يجب أن يحتوي على صورة واحدة على الأقل",
    ),
    "productFormErrorInvalidNumber": MessageLookupByLibrary.simpleMessage(
      "يرجى إدخال رقم صحيح",
    ),
    "productFormErrorMainImageRequired": MessageLookupByLibrary.simpleMessage(
      "يرجى إضافة صورة رئيسية للمنتج",
    ),
    "productFormFieldCategory": MessageLookupByLibrary.simpleMessage("التصنيف"),
    "productFormFieldCollection": MessageLookupByLibrary.simpleMessage(
      "الكولكشن (اختياري)",
    ),
    "productFormFieldDesc": MessageLookupByLibrary.simpleMessage("الوصف"),
    "productFormFieldDiscountPct": MessageLookupByLibrary.simpleMessage(
      "نسبة الخصم %",
    ),
    "productFormFieldDiscountVal": MessageLookupByLibrary.simpleMessage(
      "قيمة الخصم",
    ),
    "productFormFieldName": MessageLookupByLibrary.simpleMessage("اسم المنتج"),
    "productFormFieldPrice": MessageLookupByLibrary.simpleMessage("سعر البيع"),
    "productFormFieldRefundedQty": MessageLookupByLibrary.simpleMessage(
      "الكميات المستردة",
    ),
    "productFormFieldShippedQty": MessageLookupByLibrary.simpleMessage(
      "الكميات المشحونة",
    ),
    "productFormPickColor": MessageLookupByLibrary.simpleMessage("اختر لوناً"),
    "productFormPickImage": MessageLookupByLibrary.simpleMessage(
      "اختر صورة رئيسية",
    ),
    "productFormSave": MessageLookupByLibrary.simpleMessage("حفظ التغييرات"),
    "productFormSectionBasicInfo": MessageLookupByLibrary.simpleMessage(
      "المعلومات الأساسية",
    ),
    "productFormSectionColors": MessageLookupByLibrary.simpleMessage(
      "ألوان المنتج",
    ),
    "productFormSectionMainImage": MessageLookupByLibrary.simpleMessage(
      "الصورة الرئيسية",
    ),
    "productFormSectionPricing": MessageLookupByLibrary.simpleMessage(
      "التسعير",
    ),
    "productFormSectionReports": MessageLookupByLibrary.simpleMessage(
      "الإحصائيات",
    ),
    "productFormSuccessAdd": MessageLookupByLibrary.simpleMessage(
      "تم إضافة المنتج بنجاح",
    ),
    "productFormSuccessEdit": MessageLookupByLibrary.simpleMessage(
      "تم تحديث المنتج بنجاح",
    ),
    "productsEmpty": MessageLookupByLibrary.simpleMessage("لا توجد منتجات"),
    "productsSearchHint": MessageLookupByLibrary.simpleMessage(
      "بحث عن منتج...",
    ),
    "productsSearchScopeHint": MessageLookupByLibrary.simpleMessage(
      "البحث يشمل المنتجات المحملة فقط",
    ),
    "productsTitle": MessageLookupByLibrary.simpleMessage("المنتجات"),
    "profileTitle": MessageLookupByLibrary.simpleMessage("حسابي"),
    "quantityLabel": m6,
    "refundChartLabel": MessageLookupByLibrary.simpleMessage("مسترد"),
    "refundRateLabel": MessageLookupByLibrary.simpleMessage("نسبة الاسترداد"),
    "reportsTitle": MessageLookupByLibrary.simpleMessage("التقارير"),
    "retry": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "retryBtn": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "returnPolicy": MessageLookupByLibrary.simpleMessage("سياسة الاسترجاع"),
    "revenueChartLabel": MessageLookupByLibrary.simpleMessage("مبيعات"),
    "saveAddress": MessageLookupByLibrary.simpleMessage("حفظ العنوان"),
    "saveChanges": MessageLookupByLibrary.simpleMessage("حفظ التغييرات"),
    "searchGovernorateHint": MessageLookupByLibrary.simpleMessage(
      "ابحث عن محافظة...",
    ),
    "selectGovernorate": MessageLookupByLibrary.simpleMessage("اختر محافظة"),
    "selectNewStatusHint": MessageLookupByLibrary.simpleMessage(
      "اختر الحالة الجديدة للطلب",
    ),
    "selectedColor": MessageLookupByLibrary.simpleMessage("اللون المختار:"),
    "setAsDefault": MessageLookupByLibrary.simpleMessage(
      "تعيين كعنوان افتراضي",
    ),
    "shippingAddressTitle": MessageLookupByLibrary.simpleMessage("عنوان الشحن"),
    "shippingCostFieldLabel": MessageLookupByLibrary.simpleMessage(
      "تكلفة الشحن (ج.م)",
    ),
    "shippingCostsEmpty": MessageLookupByLibrary.simpleMessage(
      "لا توجد تكاليف شحن محددة بعد",
    ),
    "shippingFree": MessageLookupByLibrary.simpleMessage("مجاني"),
    "shippingLabel": MessageLookupByLibrary.simpleMessage("الشحن"),
    "shippingNotAvailable": MessageLookupByLibrary.simpleMessage(
      "غير متاح لهذه المنطقة",
    ),
    "shippingSectionTitle": MessageLookupByLibrary.simpleMessage(
      "تكاليف الشحن",
    ),
    "shopAsGuest": MessageLookupByLibrary.simpleMessage("التسوق كزائر"),
    "showAllText": MessageLookupByLibrary.simpleMessage("عرض الكل"),
    "showRemainingItemsLabel": MessageLookupByLibrary.simpleMessage(
      "عرض جميع العناصر المتبقية",
    ),
    "signInEasilyVia": MessageLookupByLibrary.simpleMessage("سجلي بسهولة عبر"),
    "signInForBestService": MessageLookupByLibrary.simpleMessage(
      "سجلي دخولك لتحصلي على افضل خدمة ممكنة",
    ),
    "signInToFollowLatestFashion": MessageLookupByLibrary.simpleMessage(
      "سجلي الدخول لمتابعة أحدث صيحات الموضة",
    ),
    "signInWithFacebook": MessageLookupByLibrary.simpleMessage(
      "تسجيل الدخول بفيسبوك",
    ),
    "signInWithGoogle": MessageLookupByLibrary.simpleMessage(
      "تسجيل الدخول بجوجل",
    ),
    "signOut": MessageLookupByLibrary.simpleMessage("تسجيل الخروج"),
    "similarProducts": MessageLookupByLibrary.simpleMessage("منتجات مشابهة"),
    "someItemsUnavailableError": MessageLookupByLibrary.simpleMessage(
      "بعض المنتجات نفذت من المخزون",
    ),
    "staffCreatedAtLabel": MessageLookupByLibrary.simpleMessage(
      "تاريخ الإنشاء",
    ),
    "staffCreatedSuccess": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء الحساب بنجاح",
    ),
    "staffDeletedSuccess": MessageLookupByLibrary.simpleMessage(
      "تم حذف الحساب",
    ),
    "staffManagementTitle": MessageLookupByLibrary.simpleMessage(
      "إدارة الموظفين",
    ),
    "staffPasswordChangedSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تغيير كلمة المرور بنجاح",
    ),
    "staffRoleChangedSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تحديث الصلاحية بنجاح",
    ),
    "staffRoleLabel": MessageLookupByLibrary.simpleMessage("الصلاحية"),
    "staffUsernameLabel": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
    "storeConfigSaveFailed": MessageLookupByLibrary.simpleMessage(
      "حدث خطأ أثناء الحفظ، حاول مجدداً",
    ),
    "storeConfigSaveSuccess": MessageLookupByLibrary.simpleMessage(
      "تم حفظ التغييرات بنجاح",
    ),
    "storeConfigSubtitle": MessageLookupByLibrary.simpleMessage(
      "إدارة تكاليف الشحن، الأقسام، والمظهر العام",
    ),
    "storeConfigTitle": MessageLookupByLibrary.simpleMessage("تخصيص المتجر"),
    "streetLabel": MessageLookupByLibrary.simpleMessage("الشارع"),
    "subtotalLabel": MessageLookupByLibrary.simpleMessage("الإجمالي قبل الخصم"),
    "successTitle": MessageLookupByLibrary.simpleMessage("نجاح"),
    "topSellersLabel": MessageLookupByLibrary.simpleMessage("الأكثر مبيعاً"),
    "topSpendersLabel": MessageLookupByLibrary.simpleMessage(
      "أعلى المشترين إنفاقاً",
    ),
    "totalCustomersLabel": MessageLookupByLibrary.simpleMessage(
      "إجمالي العملاء",
    ),
    "totalOrdersLabel": MessageLookupByLibrary.simpleMessage("إجمالي الطلبات"),
    "totalRefundedLabel": MessageLookupByLibrary.simpleMessage(
      "إجمالي المسترد",
    ),
    "totalRevenueLabel": MessageLookupByLibrary.simpleMessage(
      "إجمالي الإيرادات",
    ),
    "totalSoldLabel": m7,
    "totalUnitsLabel": MessageLookupByLibrary.simpleMessage("إجمالي الوحدات"),
    "updateStatusLabel": MessageLookupByLibrary.simpleMessage("تحديث الحالة"),
    "uploadPhoto": MessageLookupByLibrary.simpleMessage("رفع صورة"),
    "usernameLabel": MessageLookupByLibrary.simpleMessage("اسم المستخدم"),
    "verifyCode": MessageLookupByLibrary.simpleMessage("التحقق من الرمز"),
    "viewOrdersBtn": MessageLookupByLibrary.simpleMessage("عرض الطلبات"),
    "welcomeMessage": MessageLookupByLibrary.simpleMessage("مرحباً بكِ"),
  };
}
