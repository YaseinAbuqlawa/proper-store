import 'package:intl/intl.dart';
import 'package:proper_store/core/failures/app_failures.dart';
import 'package:proper_store/core/products/data/models/product_model.dart';

extension ProductListExt on List<ProductModel> {
  double get totalPriceBeforeDiscount => fold(
    0,
    (pervious, current) => pervious + (current.sellingPrice * current.quantity),
  );
  double get totalDiscount => fold(
    0,
    (pervious, current) =>
        pervious + (current.discountValue * current.quantity),
  );
  double get totalPriceAfterDiscount => fold(
    0,
    (pervious, current) => pervious + (current.offerPrice() * current.quantity),
  );
}

extension DoubleExt on double {
  String toCurrency() {
    var format = NumberFormat.currency(decimalDigits: 2, symbol: "ج٫م");
    return format.format(this);
  }
}

extension ServerFailureCodeExt on ServerFailure {
  String get errorMessage {
    return switch (code) {
      'invalid-phone-number' => 'رقم الموبايل غير صحيح، تأكد منه وحاول تاني.',
      'invalid-email' =>
        'صيغة البريد الإلكتروني غير صحيحة، تأكد من كتابته بشكل سليم.',
      'user-not-found' =>
        'لم نجد حساباً بهذا الرقم أو البريد. تأكد من البيانات أو أنشئ حساباً جديداً.',
      'wrong-password' =>
        'كلمة المرور غير صحيحة. حاول مرة أخرى أو قم باستعادتها.',
      'invalid-credential' =>
        'بيانات الدخول غير صحيحة، يرجى التأكد والمحاولة مرة أخرى.',
      'email-already-in-use' =>
        'هذا البريد الإلكتروني مسجل لدينا بالفعل. قم بتسجيل الدخول مباشرة.',
      'phone-number-already-exists' =>
        'رقم الموبايل ده مستخدم في حساب تاني. جرب تسجل بيه الدخول.',
      'user-disabled' =>
        'عفواً، تم إيقاف هذا الحساب. يرجى التواصل مع إدارة المتجر.',
      'too-many-requests' =>
        'قمت بمحاولات كثيرة في وقت قصير. استرح قليلاً وجرب كمان شوية.',
      'session-expired' =>
        'وقت الجلسة انتهى للأمان. يرجى تسجيل الدخول مرة أخرى.',
      'weak-password' =>
        'كلمة المرور ضعيفة. يرجى اختيار كلمة مرور قوية لحماية حسابك.',
      'operation-not-allowed' =>
        'طريقة تسجيل الدخول هذه غير مفعلة حالياً. تواصل مع الدعم الفني.',
      'requires-recent-login' =>
        'لأسباب أمنية، يرجى تسجيل الخروج ثم الدخول مرة أخرى لتنفيذ هذا التعديل.',
      'invalid-action-code' =>
        'رابط التحقق غير صالح أو تم استخدامه من قبل. اطلب رابطاً جديداً.',
      'expired-action-code' => 'انتهت صلاحية رابط التحقق. يرجى طلب رابط جديد.',

      'account-exists-with-different-credential' =>
        'لديك حساب بالفعل. يرجى تسجيل الدخول بالطريقة التي استخدمتها أول مرة (جوجل أو فيسبوك أو الإيميل).',
      'credential-already-in-use' =>
        'هذا الحساب (جوجل/فيسبوك) مرتبط بمستخدم آخر لدينا بالفعل.',
      'popup-closed-by-user' =>
        'تم إغلاق نافذة تسجيل الدخول قبل إتمام العملية.',
      'popup-blocked' =>
        'المتصفح يمنع فتح نافذة تسجيل الدخول. يرجى السماح بالنوافذ المنبثقة (Pop-ups) للمتجر.',
      'cancelled-popup-request' =>
        'تم إلغاء طلب تسجيل الدخول بسبب طلبات متتالية سريعة.',
      'unauthorized-domain' =>
        'هذا النطاق غير مصرح له بتسجيل الدخول. (رسالة للمطور: راجع إعدادات Firebase).',

      'permission-denied' =>
        'عفواً، ليس لديك صلاحية للوصول لهذه الصفحة أو إتمام هذه العملية.',
      'not-found' => 'المنتج أو الصفحة التي تبحث عنها غير موجودة أو تم حذفها.',
      'already-exists' => 'هذا العنصر موجود بالفعل (مثل منتج مكرر في المفضلة).',
      'out-of-range' => 'البيانات المطلوبة غير متاحة أو خارج النطاق المسموح.',
      'failed-precondition' =>
        'لا يمكن تنفيذ العملية حالياً. قد يكون هناك تحديث في سلة المشتريات. حدث الصفحة وحاول ثانية.',
      'resource-exhausted' =>
        'هناك ضغط كبير على الخوادم حالياً. يرجى الانتظار دقيقة والمحاولة مرة أخرى.',
      'aborted' =>
        'تم إلغاء العملية بسبب تعارض في البيانات. يرجى المحاولة مرة أخرى.',

      'unauthenticated' =>
        'جلسة غير صالحة. يرجى تسجيل الدخول أولاً لإتمام عملية الدفع أو الطلب.',
      'invalid-argument' =>
        'هناك خطأ في البيانات المدخلة، يرجى مراجعة حقول العنوان أو الدفع وإعادة المحاولة.',
      'internal' =>
        'حدث عطل فني مؤقت من طرفنا. فريقنا يعمل على حله، يرجى المحاولة لاحقاً.',
      'deadline-exceeded' =>
        'استغرق الطلب وقتاً أطول من اللازم. تأكد من جودة الإنترنت وحاول ثانية.',

      'unavailable' =>
        'الخدمة غير متاحة حالياً. تأكد من اتصالك بالإنترنت أو حاول لاحقاً.',
      'network-request-failed' =>
        'لا يوجد اتصال بالإنترنت. تأكد من الشبكة وارجع لنا.',

      _ =>
        'عذراً، حدث خطأ غير متوقع. يرجى المحاولة مرة أخرى لاحقاً أو التواصل مع الدعم.',
    };
  }
}
