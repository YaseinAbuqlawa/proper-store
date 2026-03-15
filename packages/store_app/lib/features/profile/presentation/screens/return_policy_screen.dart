import 'package:flutter/material.dart';
import 'package:proper_store/core/widgets/section_title.dart';
import 'package:proper_store_shared/design_system/spacing/app_spacing.dart';
import 'package:proper_store_shared/design_system/typography/app_text_styles.dart';
import 'package:proper_store_shared/generated/l10n.dart';

class ReturnPolicyScreen extends StatelessWidget {
  const ReturnPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(s.returnPolicy)),
      body: SafeArea(
        child: ListView(
          padding: AppSpacing.screenPadding,
          children: const [
            AppSpacing.verticalSpaceMedium,
            _PolicySection(
              title: '📦 مدة الإرجاع',
              body:
                  'يحق للعميل إرجاع المنتج خلال 7 أيام من تاريخ الاستلام، '
                  'شرط أن يكون المنتج في حالته الأصلية وغير مستخدم.',
            ),
            _PolicySection(
              title: '✅ شروط الإرجاع',
              body:
                  '• المنتج سليم وغير مستخدم وبعبوته الأصلية.\n'
                  '• يرفق الإيصال أو رقم الطلب عند الإرجاع.\n'
                  '• المنتج لم يتعرض للتلف أو سوء الاستخدام.',
            ),
            _PolicySection(
              title: '🚫 منتجات لا يُقبل إرجاعها',
              body:
                  '• المنتجات المخفّضة أو التي اشتُريت بعروض خاصة.\n'
                  '• المنتجات التالفة بسبب سوء الاستخدام.',
            ),
            _PolicySection(
              title: '🔄 إجراءات الإرجاع',
              body:
                  '1. تواصل معنا عبر واتساب أو هاتف خلال مدة الإرجاع.\n'
                  '2. أرسل صور واضحة للمنتج ورقم الطلب.\n'
                  '3. سيتم تحديد موعد استلام المنتج أو إرساله بالشحن.\n'
                  '4. يتحمل العميل تكلفة الشحن العكسي ما لم يكن الخطأ من جهتنا.',
            ),
            _PolicySection(
              title: '💰 استرداد المبلغ',
              body:
                  'يتم استرداد المبلغ كاملاً خلال 3 إلى 7 أيام عمل بعد استلام '
                  'المنتج والتحقق من حالته. يتم الاسترداد بنفس طريقة الدفع أو '
                  'كرصيد في حسابك لدينا.',
            ),
            _PolicySection(
              title: '📞 للتواصل',
              body:
                  'في حال وجود أي استفسار بخصوص سياسة الإرجاع، '
                  'لا تترددي في التواصل معنا عبر صفحة "تواصل معنا".',
            ),
            AppSpacing.verticalSpaceLarge,
          ],
        ),
      ),
    );
  }
}

class _PolicySection extends StatelessWidget {
  final String title;
  final String body;

  const _PolicySection({required this.title, required this.body});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.medium),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.medium),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(AppSpacing.borderRadiusMedium),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionTitle(title: title),
            const SizedBox(height: AppSpacing.small),
            Text(
              body,
              style: AppTextStyles.bodyDescription.copyWith(height: 1.8),
            ),
          ],
        ),
      ),
    );
  }
}
