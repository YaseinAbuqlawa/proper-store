// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_form_data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProductFormData {

 String? get selectedCategory; String? get existingMainImageUrl; Uint8List? get newMainImageBytes; String? get removedMainImageUrl; List<ProductVariantEntry> get productVariants;/// URLs of images from fully-removed variants, to be deleted from Storage on save.
 List<String> get removedVariantImageUrls;/// Transient error surfaced by async cubit operations that can't show a
/// snackbar themselves. Listeners must clear it after displaying.
 String? get transientErrorKey;
/// Create a copy of ProductFormData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProductFormDataCopyWith<ProductFormData> get copyWith => _$ProductFormDataCopyWithImpl<ProductFormData>(this as ProductFormData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProductFormData&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.existingMainImageUrl, existingMainImageUrl) || other.existingMainImageUrl == existingMainImageUrl)&&const DeepCollectionEquality().equals(other.newMainImageBytes, newMainImageBytes)&&(identical(other.removedMainImageUrl, removedMainImageUrl) || other.removedMainImageUrl == removedMainImageUrl)&&const DeepCollectionEquality().equals(other.productVariants, productVariants)&&const DeepCollectionEquality().equals(other.removedVariantImageUrls, removedVariantImageUrls)&&(identical(other.transientErrorKey, transientErrorKey) || other.transientErrorKey == transientErrorKey));
}


@override
int get hashCode => Object.hash(runtimeType,selectedCategory,existingMainImageUrl,const DeepCollectionEquality().hash(newMainImageBytes),removedMainImageUrl,const DeepCollectionEquality().hash(productVariants),const DeepCollectionEquality().hash(removedVariantImageUrls),transientErrorKey);

@override
String toString() {
  return 'ProductFormData(selectedCategory: $selectedCategory, existingMainImageUrl: $existingMainImageUrl, newMainImageBytes: $newMainImageBytes, removedMainImageUrl: $removedMainImageUrl, productVariants: $productVariants, removedVariantImageUrls: $removedVariantImageUrls, transientErrorKey: $transientErrorKey)';
}


}

/// @nodoc
abstract mixin class $ProductFormDataCopyWith<$Res>  {
  factory $ProductFormDataCopyWith(ProductFormData value, $Res Function(ProductFormData) _then) = _$ProductFormDataCopyWithImpl;
@useResult
$Res call({
 String? selectedCategory, String? existingMainImageUrl, Uint8List? newMainImageBytes, String? removedMainImageUrl, List<ProductVariantEntry> productVariants, List<String> removedVariantImageUrls, String? transientErrorKey
});




}
/// @nodoc
class _$ProductFormDataCopyWithImpl<$Res>
    implements $ProductFormDataCopyWith<$Res> {
  _$ProductFormDataCopyWithImpl(this._self, this._then);

  final ProductFormData _self;
  final $Res Function(ProductFormData) _then;

/// Create a copy of ProductFormData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? selectedCategory = freezed,Object? existingMainImageUrl = freezed,Object? newMainImageBytes = freezed,Object? removedMainImageUrl = freezed,Object? productVariants = null,Object? removedVariantImageUrls = null,Object? transientErrorKey = freezed,}) {
  return _then(_self.copyWith(
selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String?,existingMainImageUrl: freezed == existingMainImageUrl ? _self.existingMainImageUrl : existingMainImageUrl // ignore: cast_nullable_to_non_nullable
as String?,newMainImageBytes: freezed == newMainImageBytes ? _self.newMainImageBytes : newMainImageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,removedMainImageUrl: freezed == removedMainImageUrl ? _self.removedMainImageUrl : removedMainImageUrl // ignore: cast_nullable_to_non_nullable
as String?,productVariants: null == productVariants ? _self.productVariants : productVariants // ignore: cast_nullable_to_non_nullable
as List<ProductVariantEntry>,removedVariantImageUrls: null == removedVariantImageUrls ? _self.removedVariantImageUrls : removedVariantImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,transientErrorKey: freezed == transientErrorKey ? _self.transientErrorKey : transientErrorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProductFormData].
extension ProductFormDataPatterns on ProductFormData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProductFormData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProductFormData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProductFormData value)  $default,){
final _that = this;
switch (_that) {
case _ProductFormData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProductFormData value)?  $default,){
final _that = this;
switch (_that) {
case _ProductFormData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? selectedCategory,  String? existingMainImageUrl,  Uint8List? newMainImageBytes,  String? removedMainImageUrl,  List<ProductVariantEntry> productVariants,  List<String> removedVariantImageUrls,  String? transientErrorKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProductFormData() when $default != null:
return $default(_that.selectedCategory,_that.existingMainImageUrl,_that.newMainImageBytes,_that.removedMainImageUrl,_that.productVariants,_that.removedVariantImageUrls,_that.transientErrorKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? selectedCategory,  String? existingMainImageUrl,  Uint8List? newMainImageBytes,  String? removedMainImageUrl,  List<ProductVariantEntry> productVariants,  List<String> removedVariantImageUrls,  String? transientErrorKey)  $default,) {final _that = this;
switch (_that) {
case _ProductFormData():
return $default(_that.selectedCategory,_that.existingMainImageUrl,_that.newMainImageBytes,_that.removedMainImageUrl,_that.productVariants,_that.removedVariantImageUrls,_that.transientErrorKey);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? selectedCategory,  String? existingMainImageUrl,  Uint8List? newMainImageBytes,  String? removedMainImageUrl,  List<ProductVariantEntry> productVariants,  List<String> removedVariantImageUrls,  String? transientErrorKey)?  $default,) {final _that = this;
switch (_that) {
case _ProductFormData() when $default != null:
return $default(_that.selectedCategory,_that.existingMainImageUrl,_that.newMainImageBytes,_that.removedMainImageUrl,_that.productVariants,_that.removedVariantImageUrls,_that.transientErrorKey);case _:
  return null;

}
}

}

/// @nodoc


class _ProductFormData extends ProductFormData {
  const _ProductFormData({this.selectedCategory, this.existingMainImageUrl, this.newMainImageBytes, this.removedMainImageUrl, final  List<ProductVariantEntry> productVariants = const [], final  List<String> removedVariantImageUrls = const [], this.transientErrorKey}): _productVariants = productVariants,_removedVariantImageUrls = removedVariantImageUrls,super._();
  

@override final  String? selectedCategory;
@override final  String? existingMainImageUrl;
@override final  Uint8List? newMainImageBytes;
@override final  String? removedMainImageUrl;
 final  List<ProductVariantEntry> _productVariants;
@override@JsonKey() List<ProductVariantEntry> get productVariants {
  if (_productVariants is EqualUnmodifiableListView) return _productVariants;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_productVariants);
}

/// URLs of images from fully-removed variants, to be deleted from Storage on save.
 final  List<String> _removedVariantImageUrls;
/// URLs of images from fully-removed variants, to be deleted from Storage on save.
@override@JsonKey() List<String> get removedVariantImageUrls {
  if (_removedVariantImageUrls is EqualUnmodifiableListView) return _removedVariantImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_removedVariantImageUrls);
}

/// Transient error surfaced by async cubit operations that can't show a
/// snackbar themselves. Listeners must clear it after displaying.
@override final  String? transientErrorKey;

/// Create a copy of ProductFormData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProductFormDataCopyWith<_ProductFormData> get copyWith => __$ProductFormDataCopyWithImpl<_ProductFormData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProductFormData&&(identical(other.selectedCategory, selectedCategory) || other.selectedCategory == selectedCategory)&&(identical(other.existingMainImageUrl, existingMainImageUrl) || other.existingMainImageUrl == existingMainImageUrl)&&const DeepCollectionEquality().equals(other.newMainImageBytes, newMainImageBytes)&&(identical(other.removedMainImageUrl, removedMainImageUrl) || other.removedMainImageUrl == removedMainImageUrl)&&const DeepCollectionEquality().equals(other._productVariants, _productVariants)&&const DeepCollectionEquality().equals(other._removedVariantImageUrls, _removedVariantImageUrls)&&(identical(other.transientErrorKey, transientErrorKey) || other.transientErrorKey == transientErrorKey));
}


@override
int get hashCode => Object.hash(runtimeType,selectedCategory,existingMainImageUrl,const DeepCollectionEquality().hash(newMainImageBytes),removedMainImageUrl,const DeepCollectionEquality().hash(_productVariants),const DeepCollectionEquality().hash(_removedVariantImageUrls),transientErrorKey);

@override
String toString() {
  return 'ProductFormData(selectedCategory: $selectedCategory, existingMainImageUrl: $existingMainImageUrl, newMainImageBytes: $newMainImageBytes, removedMainImageUrl: $removedMainImageUrl, productVariants: $productVariants, removedVariantImageUrls: $removedVariantImageUrls, transientErrorKey: $transientErrorKey)';
}


}

/// @nodoc
abstract mixin class _$ProductFormDataCopyWith<$Res> implements $ProductFormDataCopyWith<$Res> {
  factory _$ProductFormDataCopyWith(_ProductFormData value, $Res Function(_ProductFormData) _then) = __$ProductFormDataCopyWithImpl;
@override @useResult
$Res call({
 String? selectedCategory, String? existingMainImageUrl, Uint8List? newMainImageBytes, String? removedMainImageUrl, List<ProductVariantEntry> productVariants, List<String> removedVariantImageUrls, String? transientErrorKey
});




}
/// @nodoc
class __$ProductFormDataCopyWithImpl<$Res>
    implements _$ProductFormDataCopyWith<$Res> {
  __$ProductFormDataCopyWithImpl(this._self, this._then);

  final _ProductFormData _self;
  final $Res Function(_ProductFormData) _then;

/// Create a copy of ProductFormData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? selectedCategory = freezed,Object? existingMainImageUrl = freezed,Object? newMainImageBytes = freezed,Object? removedMainImageUrl = freezed,Object? productVariants = null,Object? removedVariantImageUrls = null,Object? transientErrorKey = freezed,}) {
  return _then(_ProductFormData(
selectedCategory: freezed == selectedCategory ? _self.selectedCategory : selectedCategory // ignore: cast_nullable_to_non_nullable
as String?,existingMainImageUrl: freezed == existingMainImageUrl ? _self.existingMainImageUrl : existingMainImageUrl // ignore: cast_nullable_to_non_nullable
as String?,newMainImageBytes: freezed == newMainImageBytes ? _self.newMainImageBytes : newMainImageBytes // ignore: cast_nullable_to_non_nullable
as Uint8List?,removedMainImageUrl: freezed == removedMainImageUrl ? _self.removedMainImageUrl : removedMainImageUrl // ignore: cast_nullable_to_non_nullable
as String?,productVariants: null == productVariants ? _self._productVariants : productVariants // ignore: cast_nullable_to_non_nullable
as List<ProductVariantEntry>,removedVariantImageUrls: null == removedVariantImageUrls ? _self._removedVariantImageUrls : removedVariantImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,transientErrorKey: freezed == transientErrorKey ? _self.transientErrorKey : transientErrorKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
