import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:proper_store_shared/generated/l10n.dart';
import 'package:proper_store_shared/helpers/app_consts.dart';
import 'package:proper_store_shared/models/cart_item_model.dart';
import 'package:proper_store_shared/models/order_model.dart';

import 'order_details_style.dart';

class ProductsCard extends StatefulWidget {
  final OrderModel order;

  const ProductsCard({super.key, required this.order});

  @override
  State<ProductsCard> createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  static const _initialCount = 2;
  bool _expanded = false;

  int get _totalUnits =>
      widget.order.products.fold(0, (sum, p) => sum + p.quantity);

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final products = widget.order.products;
    final displayed =
        _expanded ? products : products.take(_initialCount).toList();
    final remaining = products.length - _initialCount;

    return Container(
      decoration: orderDetailsCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    '${l.orderItemsLabel} (${products.length})',
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.8,
                      color: orderDetailsStone400,
                    ),
                  ),
                ),
                Text(
                  '${l.totalUnitsLabel}: $_totalUnits',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: orderDetailsStone400,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: orderDetailsStone100),
          ...displayed.map((item) => _ProductRow(item: item)),
          if (!_expanded && remaining > 0)
            InkWell(
              onTap: () => setState(() => _expanded = true),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: const BoxDecoration(
                  color: Color(0xFFFAFAF9),
                  border: Border(top: BorderSide(color: orderDetailsStone100)),
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(16)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${l.showRemainingItemsLabel} ($remaining)',
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: orderDetailsStone600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.expand_more,
                        size: 16, color: orderDetailsStone600),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProductRow extends StatelessWidget {
  final CartItemModel item;

  const _ProductRow({required this.item});

  @override
  Widget build(BuildContext context) {
    final totalPrice = item.offerPrice * item.quantity;

    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: orderDetailsStone100)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 52,
              height: 52,
              child: item.imageUrl.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: item.imageUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          Container(color: orderDetailsStone100),
                      errorWidget: (context, url, error) =>
                          Container(color: orderDetailsStone100),
                    )
                  : Container(color: orderDetailsStone100),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: orderDetailsStone900,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: item.selectedColor,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: orderDetailsStone100,
                          width: 1,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '#${item.selectedColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: orderDetailsStone400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${totalPrice.toStringAsFixed(0)} ${AppConsts.currencySymbol}',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: orderDetailsGold,
                ),
              ),
              Text(
                '${item.quantity}x',
                style: const TextStyle(
                    fontSize: 10, color: orderDetailsStone400),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
