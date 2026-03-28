// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProductModel {

 String get category;@ProductVariantMapConverter() Map<String, ProductVariant> get variants;@JsonKey(includeToJson: false, includeFromJson: false) ProductVariant? get selectedColor; String get description; double get discountPercentage; double get discountValue; String get id;@JsonKey(includeToJson: false, includeFromJson: false) int get quantity; String get mainImageUrl;@TimestampConverter() DateTime get lastPurchaseDate; String get material; String get name; int get refundedQuantity; String? get collection; String get section; double get sellingPrice; List<double> get sizes; int get soldQuantity; int get stockQuantity; int get totalStock; List<String> get outOfStockVariants; bool get hasOutOfStockVariants;
/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductModelCopyWith<ProductModel> get copyWith => _$ProductModelCopyWithImpl<ProductModel>(this as ProductModel, _$identity);

  /// Serializes this ProductModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductModel&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.variants, variants)&&(identical(other.selectedColor, selectedColor) || other.selectedColor == selectedColor)&&(identical(other.description, description) || other.description == description)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.id, id) || other.id == id)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.mainImageUrl, mainImageUrl) || other.mainImageUrl == mainImageUrl)&&(identical(other.lastPurchaseDate, lastPurchaseDate) || other.lastPurchaseDate == lastPurchaseDate)&&(identical(other.material, material) || other.material == material)&&(identical(other.name, name) || other.name == name)&&(identical(other.refundedQuantity, refundedQuantity) || other.refundedQuantity == refundedQuantity)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.section, section) || other.section == section)&&(identical(other.sellingPrice, sellingPrice) || other.sellingPrice == sellingPrice)&&const DeepCollectionEquality().equals(other.sizes, sizes)&&(identical(other.soldQuantity, soldQuantity) || other.soldQuantity == soldQuantity)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.totalStock, totalStock) || other.totalStock == totalStock)&&const DeepCollectionEquality().equals(other.outOfStockVariants, outOfStockVariants)&&(identical(other.hasOutOfStockVariants, hasOutOfStockVariants) || other.hasOutOfStockVariants == hasOutOfStockVariants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,category,const DeepCollectionEquality().hash(variants),selectedColor,description,discountPercentage,discountValue,id,quantity,mainImageUrl,lastPurchaseDate,material,name,refundedQuantity,collection,section,sellingPrice,const DeepCollectionEquality().hash(sizes),soldQuantity,stockQuantity,totalStock,const DeepCollectionEquality().hash(outOfStockVariants),hasOutOfStockVariants]);

@override
String toString() {
  return 'ProductModel(category: $category, variants: $variants, selectedColor: $selectedColor, description: $description, discountPercentage: $discountPercentage, discountValue: $discountValue, id: $id, quantity: $quantity, mainImageUrl: $mainImageUrl, lastPurchaseDate: $lastPurchaseDate, material: $material, name: $name, refundedQuantity: $refundedQuantity, collection: $collection, section: $section, sellingPrice: $sellingPrice, sizes: $sizes, soldQuantity: $soldQuantity, stockQuantity: $stockQuantity, totalStock: $totalStock, outOfStockVariants: $outOfStockVariants, hasOutOfStockVariants: $hasOutOfStockVariants)';
}


}

/// @nodoc
abstract mixin class $ProductModelCopyWith<$Res>  {
  factory $ProductModelCopyWith(ProductModel value, $Res Function(ProductModel) _then) = _$ProductModelCopyWithImpl;
@useResult
$Res call({
 String category,@ProductVariantMapConverter() Map<String, ProductVariant> variants,@JsonKey(includeToJson: false, includeFromJson: false) ProductVariant? selectedColor, String description, double discountPercentage, double discountValue, String id,@JsonKey(includeToJson: false, includeFromJson: false) int quantity, String mainImageUrl,@TimestampConverter() DateTime lastPurchaseDate, String material, String name, int refundedQuantity, String? collection, String section, double sellingPrice, List<double> sizes, int soldQuantity, int stockQuantity, int totalStock, List<String> outOfStockVariants, bool hasOutOfStockVariants
});




}
/// @nodoc
class _$ProductModelCopyWithImpl<$Res>
    implements $ProductModelCopyWith<$Res> {
  _$ProductModelCopyWithImpl(this._self, this._then);

  final ProductModel _self;
  final $Res Function(ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? variants = null,Object? selectedColor = freezed,Object? description = null,Object? discountPercentage = null,Object? discountValue = null,Object? id = null,Object? quantity = null,Object? mainImageUrl = null,Object? lastPurchaseDate = null,Object? material = null,Object? name = null,Object? refundedQuantity = null,Object? collection = freezed,Object? section = null,Object? sellingPrice = null,Object? sizes = null,Object? soldQuantity = null,Object? stockQuantity = null,Object? totalStock = null,Object? outOfStockVariants = null,Object? hasOutOfStockVariants = null,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,variants: null == variants ? _self.variants : variants // ignore: cast_nullable_to_non_nullable
as Map<String, ProductVariant>,selectedColor: freezed == selectedColor ? _self.selectedColor : selectedColor // ignore: cast_nullable_to_non_nullable
as ProductVariant?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,mainImageUrl: null == mainImageUrl ? _self.mainImageUrl : mainImageUrl // ignore: cast_nullable_to_non_nullable
as String,lastPurchaseDate: null == lastPurchaseDate ? _self.lastPurchaseDate : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,refundedQuantity: null == refundedQuantity ? _self.refundedQuantity : refundedQuantity // ignore: cast_nullable_to_non_nullable
as int,collection: freezed == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String?,section: null == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as String,sellingPrice: null == sellingPrice ? _self.sellingPrice : sellingPrice // ignore: cast_nullable_to_non_nullable
as double,sizes: null == sizes ? _self.sizes : sizes // ignore: cast_nullable_to_non_nullable
as List<double>,soldQuantity: null == soldQuantity ? _self.soldQuantity : soldQuantity // ignore: cast_nullable_to_non_nullable
as int,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,totalStock: null == totalStock ? _self.totalStock : totalStock // ignore: cast_nullable_to_non_nullable
as int,outOfStockVariants: null == outOfStockVariants ? _self.outOfStockVariants : outOfStockVariants // ignore: cast_nullable_to_non_nullable
as List<String>,hasOutOfStockVariants: null == hasOutOfStockVariants ? _self.hasOutOfStockVariants : hasOutOfStockVariants // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductModel].
extension ProductModelPatterns on ProductModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductModel value)  $default,){
final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductModel value)?  $default,){
final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category, @ProductVariantMapConverter()  Map<String, ProductVariant> variants, @JsonKey(includeToJson: false, includeFromJson: false)  ProductVariant? selectedColor,  String description,  double discountPercentage,  double discountValue,  String id, @JsonKey(includeToJson: false, includeFromJson: false)  int quantity,  String mainImageUrl, @TimestampConverter()  DateTime lastPurchaseDate,  String material,  String name,  int refundedQuantity,  String? collection,  String section,  double sellingPrice,  List<double> sizes,  int soldQuantity,  int stockQuantity,  int totalStock,  List<String> outOfStockVariants,  bool hasOutOfStockVariants)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.category,_that.variants,_that.selectedColor,_that.description,_that.discountPercentage,_that.discountValue,_that.id,_that.quantity,_that.mainImageUrl,_that.lastPurchaseDate,_that.material,_that.name,_that.refundedQuantity,_that.collection,_that.section,_that.sellingPrice,_that.sizes,_that.soldQuantity,_that.stockQuantity,_that.totalStock,_that.outOfStockVariants,_that.hasOutOfStockVariants);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category, @ProductVariantMapConverter()  Map<String, ProductVariant> variants, @JsonKey(includeToJson: false, includeFromJson: false)  ProductVariant? selectedColor,  String description,  double discountPercentage,  double discountValue,  String id, @JsonKey(includeToJson: false, includeFromJson: false)  int quantity,  String mainImageUrl, @TimestampConverter()  DateTime lastPurchaseDate,  String material,  String name,  int refundedQuantity,  String? collection,  String section,  double sellingPrice,  List<double> sizes,  int soldQuantity,  int stockQuantity,  int totalStock,  List<String> outOfStockVariants,  bool hasOutOfStockVariants)  $default,) {final _that = this;
switch (_that) {
case _ProductModel():
return $default(_that.category,_that.variants,_that.selectedColor,_that.description,_that.discountPercentage,_that.discountValue,_that.id,_that.quantity,_that.mainImageUrl,_that.lastPurchaseDate,_that.material,_that.name,_that.refundedQuantity,_that.collection,_that.section,_that.sellingPrice,_that.sizes,_that.soldQuantity,_that.stockQuantity,_that.totalStock,_that.outOfStockVariants,_that.hasOutOfStockVariants);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category, @ProductVariantMapConverter()  Map<String, ProductVariant> variants, @JsonKey(includeToJson: false, includeFromJson: false)  ProductVariant? selectedColor,  String description,  double discountPercentage,  double discountValue,  String id, @JsonKey(includeToJson: false, includeFromJson: false)  int quantity,  String mainImageUrl, @TimestampConverter()  DateTime lastPurchaseDate,  String material,  String name,  int refundedQuantity,  String? collection,  String section,  double sellingPrice,  List<double> sizes,  int soldQuantity,  int stockQuantity,  int totalStock,  List<String> outOfStockVariants,  bool hasOutOfStockVariants)?  $default,) {final _that = this;
switch (_that) {
case _ProductModel() when $default != null:
return $default(_that.category,_that.variants,_that.selectedColor,_that.description,_that.discountPercentage,_that.discountValue,_that.id,_that.quantity,_that.mainImageUrl,_that.lastPurchaseDate,_that.material,_that.name,_that.refundedQuantity,_that.collection,_that.section,_that.sellingPrice,_that.sizes,_that.soldQuantity,_that.stockQuantity,_that.totalStock,_that.outOfStockVariants,_that.hasOutOfStockVariants);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProductModel extends ProductModel {
  const _ProductModel({required this.category, @ProductVariantMapConverter() required final  Map<String, ProductVariant> variants, @JsonKey(includeToJson: false, includeFromJson: false) this.selectedColor = null, required this.description, required this.discountPercentage, required this.discountValue, required this.id, @JsonKey(includeToJson: false, includeFromJson: false) this.quantity = 0, required this.mainImageUrl, @TimestampConverter() required this.lastPurchaseDate, required this.material, required this.name, required this.refundedQuantity, this.collection = "", required this.section, required this.sellingPrice, required final  List<double> sizes, required this.soldQuantity, required this.stockQuantity, this.totalStock = 0, final  List<String> outOfStockVariants = const [], this.hasOutOfStockVariants = false}): _variants = variants,_sizes = sizes,_outOfStockVariants = outOfStockVariants,super._();
  factory _ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

@override final  String category;
 final  Map<String, ProductVariant> _variants;
@override@ProductVariantMapConverter() Map<String, ProductVariant> get variants {
  if (_variants is EqualUnmodifiableMapView) return _variants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_variants);
}

@override@JsonKey(includeToJson: false, includeFromJson: false) final  ProductVariant? selectedColor;
@override final  String description;
@override final  double discountPercentage;
@override final  double discountValue;
@override final  String id;
@override@JsonKey(includeToJson: false, includeFromJson: false) final  int quantity;
@override final  String mainImageUrl;
@override@TimestampConverter() final  DateTime lastPurchaseDate;
@override final  String material;
@override final  String name;
@override final  int refundedQuantity;
@override@JsonKey() final  String? collection;
@override final  String section;
@override final  double sellingPrice;
 final  List<double> _sizes;
@override List<double> get sizes {
  if (_sizes is EqualUnmodifiableListView) return _sizes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sizes);
}

@override final  int soldQuantity;
@override final  int stockQuantity;
@override@JsonKey() final  int totalStock;
 final  List<String> _outOfStockVariants;
@override@JsonKey() List<String> get outOfStockVariants {
  if (_outOfStockVariants is EqualUnmodifiableListView) return _outOfStockVariants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_outOfStockVariants);
}

@override@JsonKey() final  bool hasOutOfStockVariants;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductModelCopyWith<_ProductModel> get copyWith => __$ProductModelCopyWithImpl<_ProductModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProductModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductModel&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._variants, _variants)&&(identical(other.selectedColor, selectedColor) || other.selectedColor == selectedColor)&&(identical(other.description, description) || other.description == description)&&(identical(other.discountPercentage, discountPercentage) || other.discountPercentage == discountPercentage)&&(identical(other.discountValue, discountValue) || other.discountValue == discountValue)&&(identical(other.id, id) || other.id == id)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.mainImageUrl, mainImageUrl) || other.mainImageUrl == mainImageUrl)&&(identical(other.lastPurchaseDate, lastPurchaseDate) || other.lastPurchaseDate == lastPurchaseDate)&&(identical(other.material, material) || other.material == material)&&(identical(other.name, name) || other.name == name)&&(identical(other.refundedQuantity, refundedQuantity) || other.refundedQuantity == refundedQuantity)&&(identical(other.collection, collection) || other.collection == collection)&&(identical(other.section, section) || other.section == section)&&(identical(other.sellingPrice, sellingPrice) || other.sellingPrice == sellingPrice)&&const DeepCollectionEquality().equals(other._sizes, _sizes)&&(identical(other.soldQuantity, soldQuantity) || other.soldQuantity == soldQuantity)&&(identical(other.stockQuantity, stockQuantity) || other.stockQuantity == stockQuantity)&&(identical(other.totalStock, totalStock) || other.totalStock == totalStock)&&const DeepCollectionEquality().equals(other._outOfStockVariants, _outOfStockVariants)&&(identical(other.hasOutOfStockVariants, hasOutOfStockVariants) || other.hasOutOfStockVariants == hasOutOfStockVariants));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,category,const DeepCollectionEquality().hash(_variants),selectedColor,description,discountPercentage,discountValue,id,quantity,mainImageUrl,lastPurchaseDate,material,name,refundedQuantity,collection,section,sellingPrice,const DeepCollectionEquality().hash(_sizes),soldQuantity,stockQuantity,totalStock,const DeepCollectionEquality().hash(_outOfStockVariants),hasOutOfStockVariants]);

@override
String toString() {
  return 'ProductModel(category: $category, variants: $variants, selectedColor: $selectedColor, description: $description, discountPercentage: $discountPercentage, discountValue: $discountValue, id: $id, quantity: $quantity, mainImageUrl: $mainImageUrl, lastPurchaseDate: $lastPurchaseDate, material: $material, name: $name, refundedQuantity: $refundedQuantity, collection: $collection, section: $section, sellingPrice: $sellingPrice, sizes: $sizes, soldQuantity: $soldQuantity, stockQuantity: $stockQuantity, totalStock: $totalStock, outOfStockVariants: $outOfStockVariants, hasOutOfStockVariants: $hasOutOfStockVariants)';
}


}

/// @nodoc
abstract mixin class _$ProductModelCopyWith<$Res> implements $ProductModelCopyWith<$Res> {
  factory _$ProductModelCopyWith(_ProductModel value, $Res Function(_ProductModel) _then) = __$ProductModelCopyWithImpl;
@override @useResult
$Res call({
 String category,@ProductVariantMapConverter() Map<String, ProductVariant> variants,@JsonKey(includeToJson: false, includeFromJson: false) ProductVariant? selectedColor, String description, double discountPercentage, double discountValue, String id,@JsonKey(includeToJson: false, includeFromJson: false) int quantity, String mainImageUrl,@TimestampConverter() DateTime lastPurchaseDate, String material, String name, int refundedQuantity, String? collection, String section, double sellingPrice, List<double> sizes, int soldQuantity, int stockQuantity, int totalStock, List<String> outOfStockVariants, bool hasOutOfStockVariants
});




}
/// @nodoc
class __$ProductModelCopyWithImpl<$Res>
    implements _$ProductModelCopyWith<$Res> {
  __$ProductModelCopyWithImpl(this._self, this._then);

  final _ProductModel _self;
  final $Res Function(_ProductModel) _then;

/// Create a copy of ProductModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? variants = null,Object? selectedColor = freezed,Object? description = null,Object? discountPercentage = null,Object? discountValue = null,Object? id = null,Object? quantity = null,Object? mainImageUrl = null,Object? lastPurchaseDate = null,Object? material = null,Object? name = null,Object? refundedQuantity = null,Object? collection = freezed,Object? section = null,Object? sellingPrice = null,Object? sizes = null,Object? soldQuantity = null,Object? stockQuantity = null,Object? totalStock = null,Object? outOfStockVariants = null,Object? hasOutOfStockVariants = null,}) {
  return _then(_ProductModel(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,variants: null == variants ? _self._variants : variants // ignore: cast_nullable_to_non_nullable
as Map<String, ProductVariant>,selectedColor: freezed == selectedColor ? _self.selectedColor : selectedColor // ignore: cast_nullable_to_non_nullable
as ProductVariant?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,discountPercentage: null == discountPercentage ? _self.discountPercentage : discountPercentage // ignore: cast_nullable_to_non_nullable
as double,discountValue: null == discountValue ? _self.discountValue : discountValue // ignore: cast_nullable_to_non_nullable
as double,id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,mainImageUrl: null == mainImageUrl ? _self.mainImageUrl : mainImageUrl // ignore: cast_nullable_to_non_nullable
as String,lastPurchaseDate: null == lastPurchaseDate ? _self.lastPurchaseDate : lastPurchaseDate // ignore: cast_nullable_to_non_nullable
as DateTime,material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,refundedQuantity: null == refundedQuantity ? _self.refundedQuantity : refundedQuantity // ignore: cast_nullable_to_non_nullable
as int,collection: freezed == collection ? _self.collection : collection // ignore: cast_nullable_to_non_nullable
as String?,section: null == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as String,sellingPrice: null == sellingPrice ? _self.sellingPrice : sellingPrice // ignore: cast_nullable_to_non_nullable
as double,sizes: null == sizes ? _self._sizes : sizes // ignore: cast_nullable_to_non_nullable
as List<double>,soldQuantity: null == soldQuantity ? _self.soldQuantity : soldQuantity // ignore: cast_nullable_to_non_nullable
as int,stockQuantity: null == stockQuantity ? _self.stockQuantity : stockQuantity // ignore: cast_nullable_to_non_nullable
as int,totalStock: null == totalStock ? _self.totalStock : totalStock // ignore: cast_nullable_to_non_nullable
as int,outOfStockVariants: null == outOfStockVariants ? _self._outOfStockVariants : outOfStockVariants // ignore: cast_nullable_to_non_nullable
as List<String>,hasOutOfStockVariants: null == hasOutOfStockVariants ? _self.hasOutOfStockVariants : hasOutOfStockVariants // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
