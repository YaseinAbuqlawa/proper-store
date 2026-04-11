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

  /// `Store Admin Dashboard`
  String get appTitle {
    return Intl.message(
      'Store Admin Dashboard',
      name: 'appTitle',
      desc: 'Admin dashboard app title',
      args: [],
    );
  }

  /// `Sign In`
  String get loginTitle {
    return Intl.message('Sign In', name: 'loginTitle', desc: '', args: []);
  }

  /// `Email`
  String get emailLabel {
    return Intl.message('Email', name: 'emailLabel', desc: '', args: []);
  }

  /// `Password`
  String get passwordLabel {
    return Intl.message('Password', name: 'passwordLabel', desc: '', args: []);
  }

  /// `Sign In`
  String get loginButton {
    return Intl.message('Sign In', name: 'loginButton', desc: '', args: []);
  }

  /// `Sign Out`
  String get logoutButton {
    return Intl.message('Sign Out', name: 'logoutButton', desc: '', args: []);
  }

  /// `Orders`
  String get navOrders {
    return Intl.message('Orders', name: 'navOrders', desc: '', args: []);
  }

  /// `Products`
  String get navProducts {
    return Intl.message('Products', name: 'navProducts', desc: '', args: []);
  }

  /// `Customers`
  String get navCustomers {
    return Intl.message('Customers', name: 'navCustomers', desc: '', args: []);
  }

  /// `Settings`
  String get navStoreConfig {
    return Intl.message('Settings', name: 'navStoreConfig', desc: '', args: []);
  }

  /// `This field is required`
  String get errorRequired {
    return Intl.message(
      'This field is required',
      name: 'errorRequired',
      desc: '',
      args: [],
    );
  }

  /// `You do not have access to this dashboard`
  String get errorAccessDenied {
    return Intl.message(
      'You do not have access to this dashboard',
      name: 'errorAccessDenied',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred, please try again`
  String get errorUnexpected {
    return Intl.message(
      'An unexpected error occurred, please try again',
      name: 'errorUnexpected',
      desc: '',
      args: [],
    );
  }

  /// `Coming soon`
  String get comingSoon {
    return Intl.message('Coming soon', name: 'comingSoon', desc: '', args: []);
  }

  /// `Dashboard`
  String get dashboardTitle {
    return Intl.message(
      'Dashboard',
      name: 'dashboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `Proper Store Admin`
  String get adminAppSubtitle {
    return Intl.message(
      'Proper Store Admin',
      name: 'adminAppSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get emailValidation {
    return Intl.message(
      'Enter your email',
      name: 'emailValidation',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get passwordValidation {
    return Intl.message(
      'Enter your password',
      name: 'passwordValidation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelBtn {
    return Intl.message('Cancel', name: 'cancelBtn', desc: '', args: []);
  }

  /// `Add`
  String get addBtn {
    return Intl.message('Add', name: 'addBtn', desc: '', args: []);
  }

  /// `Delete`
  String get deleteBtn {
    return Intl.message('Delete', name: 'deleteBtn', desc: '', args: []);
  }

  /// `Retry`
  String get retryBtn {
    return Intl.message('Retry', name: 'retryBtn', desc: '', args: []);
  }

  /// `Products`
  String get productsTitle {
    return Intl.message('Products', name: 'productsTitle', desc: '', args: []);
  }

  /// `Search products...`
  String get productsSearchHint {
    return Intl.message(
      'Search products...',
      name: 'productsSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Search applies to loaded products only`
  String get productsSearchScopeHint {
    return Intl.message(
      'Search applies to loaded products only',
      name: 'productsSearchScopeHint',
      desc: '',
      args: [],
    );
  }

  /// `No products found`
  String get productsEmpty {
    return Intl.message(
      'No products found',
      name: 'productsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Delete Product`
  String get productDeleteTitle {
    return Intl.message(
      'Delete Product',
      name: 'productDeleteTitle',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to permanently delete this product? This cannot be undone.`
  String get productDeleteMessage {
    return Intl.message(
      'Are you sure you want to permanently delete this product? This cannot be undone.',
      name: 'productDeleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Add New Product`
  String get productFormAddTitle {
    return Intl.message(
      'Add New Product',
      name: 'productFormAddTitle',
      desc: '',
      args: [],
    );
  }

  /// `Edit Product`
  String get productFormEditTitle {
    return Intl.message(
      'Edit Product',
      name: 'productFormEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get productFormSave {
    return Intl.message(
      'Save Changes',
      name: 'productFormSave',
      desc: '',
      args: [],
    );
  }

  /// `Add Product`
  String get productFormAddBtn {
    return Intl.message(
      'Add Product',
      name: 'productFormAddBtn',
      desc: '',
      args: [],
    );
  }

  /// `Basic Info`
  String get productFormSectionBasicInfo {
    return Intl.message(
      'Basic Info',
      name: 'productFormSectionBasicInfo',
      desc: '',
      args: [],
    );
  }

  /// `Pricing`
  String get productFormSectionPricing {
    return Intl.message(
      'Pricing',
      name: 'productFormSectionPricing',
      desc: '',
      args: [],
    );
  }

  /// `Color Variants`
  String get productFormSectionColors {
    return Intl.message(
      'Color Variants',
      name: 'productFormSectionColors',
      desc: '',
      args: [],
    );
  }

  /// `Main Image`
  String get productFormSectionMainImage {
    return Intl.message(
      'Main Image',
      name: 'productFormSectionMainImage',
      desc: '',
      args: [],
    );
  }

  /// `Analytics`
  String get productFormSectionReports {
    return Intl.message(
      'Analytics',
      name: 'productFormSectionReports',
      desc: '',
      args: [],
    );
  }

  /// `Product Name`
  String get productFormFieldName {
    return Intl.message(
      'Product Name',
      name: 'productFormFieldName',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get productFormFieldDesc {
    return Intl.message(
      'Description',
      name: 'productFormFieldDesc',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get productFormFieldCategory {
    return Intl.message(
      'Category',
      name: 'productFormFieldCategory',
      desc: '',
      args: [],
    );
  }

  /// `Collection (optional)`
  String get productFormFieldCollection {
    return Intl.message(
      'Collection (optional)',
      name: 'productFormFieldCollection',
      desc: '',
      args: [],
    );
  }

  /// `Selling Price`
  String get productFormFieldPrice {
    return Intl.message(
      'Selling Price',
      name: 'productFormFieldPrice',
      desc: '',
      args: [],
    );
  }

  /// `Discount %`
  String get productFormFieldDiscountPct {
    return Intl.message(
      'Discount %',
      name: 'productFormFieldDiscountPct',
      desc: '',
      args: [],
    );
  }

  /// `Discount Value`
  String get productFormFieldDiscountVal {
    return Intl.message(
      'Discount Value',
      name: 'productFormFieldDiscountVal',
      desc: '',
      args: [],
    );
  }

  /// `Units Sold`
  String get productFormFieldSoldQty {
    return Intl.message(
      'Units Sold',
      name: 'productFormFieldSoldQty',
      desc: '',
      args: [],
    );
  }

  /// `Units Refunded`
  String get productFormFieldRefundedQty {
    return Intl.message(
      'Units Refunded',
      name: 'productFormFieldRefundedQty',
      desc: '',
      args: [],
    );
  }

  /// `Add Color`
  String get productFormAddColor {
    return Intl.message(
      'Add Color',
      name: 'productFormAddColor',
      desc: '',
      args: [],
    );
  }

  /// `Color Name`
  String get productFormColorName {
    return Intl.message(
      'Color Name',
      name: 'productFormColorName',
      desc: '',
      args: [],
    );
  }

  /// `Stock`
  String get productFormColorStock {
    return Intl.message(
      'Stock',
      name: 'productFormColorStock',
      desc: '',
      args: [],
    );
  }

  /// `Add Image`
  String get productFormColorPickImage {
    return Intl.message(
      'Add Image',
      name: 'productFormColorPickImage',
      desc: '',
      args: [],
    );
  }

  /// `Change Image`
  String get productFormColorChangeImage {
    return Intl.message(
      'Change Image',
      name: 'productFormColorChangeImage',
      desc: '',
      args: [],
    );
  }

  /// `Pick a Color`
  String get productFormPickColor {
    return Intl.message(
      'Pick a Color',
      name: 'productFormPickColor',
      desc: '',
      args: [],
    );
  }

  /// `Pick Main Image`
  String get productFormPickImage {
    return Intl.message(
      'Pick Main Image',
      name: 'productFormPickImage',
      desc: '',
      args: [],
    );
  }

  /// `Change Image`
  String get productFormChangeImage {
    return Intl.message(
      'Change Image',
      name: 'productFormChangeImage',
      desc: '',
      args: [],
    );
  }

  /// `Please add at least one color variant`
  String get productFormErrorAtLeastOneColor {
    return Intl.message(
      'Please add at least one color variant',
      name: 'productFormErrorAtLeastOneColor',
      desc: '',
      args: [],
    );
  }

  /// `Product added successfully`
  String get productFormSuccessAdd {
    return Intl.message(
      'Product added successfully',
      name: 'productFormSuccessAdd',
      desc: '',
      args: [],
    );
  }

  /// `Product updated successfully`
  String get productFormSuccessEdit {
    return Intl.message(
      'Product updated successfully',
      name: 'productFormSuccessEdit',
      desc: '',
      args: [],
    );
  }

  /// `Add New Category`
  String get productFormAddCategory {
    return Intl.message(
      'Add New Category',
      name: 'productFormAddCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category name`
  String get productFormCategoryHint {
    return Intl.message(
      'Category name',
      name: 'productFormCategoryHint',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get editBtn {
    return Intl.message('Edit', name: 'editBtn', desc: '', args: []);
  }

  /// `Actions`
  String get actionsLabel {
    return Intl.message('Actions', name: 'actionsLabel', desc: '', args: []);
  }

  /// `PROPER`
  String get homeTitle {
    return Intl.message('PROPER', name: 'homeTitle', desc: '', args: []);
  }

  /// `Home`
  String get homeButtonName {
    return Intl.message('Home', name: 'homeButtonName', desc: '', args: []);
  }

  /// `Categories`
  String get categories {
    return Intl.message('Categories', name: 'categories', desc: '', args: []);
  }

  /// `Favorites`
  String get favoritesTitle {
    return Intl.message(
      'Favorites',
      name: 'favoritesTitle',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cartTitle {
    return Intl.message('Cart', name: 'cartTitle', desc: '', args: []);
  }

  /// `My Orders`
  String get ordersTitle {
    return Intl.message('My Orders', name: 'ordersTitle', desc: '', args: []);
  }

  /// `My Account`
  String get profileTitle {
    return Intl.message('My Account', name: 'profileTitle', desc: '', args: []);
  }

  /// `Best Sellers`
  String get mostSoldSectionTitle {
    return Intl.message(
      'Best Sellers',
      name: 'mostSoldSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Show all`
  String get showAllText {
    return Intl.message('Show all', name: 'showAllText', desc: '', args: []);
  }

  /// `Shop now`
  String get mainCollectionBannerButtonText {
    return Intl.message(
      'Shop now',
      name: 'mainCollectionBannerButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Add to cart`
  String get addToCartText {
    return Intl.message(
      'Add to cart',
      name: 'addToCartText',
      desc: '',
      args: [],
    );
  }

  /// ` EGP`
  String get currencySymbol {
    return Intl.message(' EGP', name: 'currencySymbol', desc: '', args: []);
  }

  /// `Product details`
  String get productDetailsScreenTitle {
    return Intl.message(
      'Product details',
      name: 'productDetailsScreenTitle',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get fieldRequired {
    return Intl.message(
      'This field is required',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Phone number must be 10 digits`
  String get phoneNumberMustBe10Digits {
    return Intl.message(
      'Phone number must be 10 digits',
      name: 'phoneNumberMustBe10Digits',
      desc: '',
      args: [],
    );
  }

  /// `Change number`
  String get changePhoneNumber {
    return Intl.message(
      'Change number',
      name: 'changePhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Phone number`
  String get phoneNumberLabel {
    return Intl.message(
      'Phone number',
      name: 'phoneNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Verification code`
  String get otpCodeLabel {
    return Intl.message(
      'Verification code',
      name: 'otpCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Verification code must be at least 6 digits`
  String get otpMustBe6Digits {
    return Intl.message(
      'Verification code must be at least 6 digits',
      name: 'otpMustBe6Digits',
      desc: '',
      args: [],
    );
  }

  /// `Welcome`
  String get welcomeMessage {
    return Intl.message('Welcome', name: 'welcomeMessage', desc: '', args: []);
  }

  /// `Sign in to follow the latest fashion trends`
  String get signInToFollowLatestFashion {
    return Intl.message(
      'Sign in to follow the latest fashion trends',
      name: 'signInToFollowLatestFashion',
      desc: '',
      args: [],
    );
  }

  /// `Full name`
  String get fullNameLabel {
    return Intl.message('Full name', name: 'fullNameLabel', desc: '', args: []);
  }

  /// `Enter your full name`
  String get enterFullNameHint {
    return Intl.message(
      'Enter your full name',
      name: 'enterFullNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Name must be more than 2 characters`
  String get nameMustBeMoreThan2Chars {
    return Intl.message(
      'Name must be more than 2 characters',
      name: 'nameMustBeMoreThan2Chars',
      desc: '',
      args: [],
    );
  }

  /// `Verification code sent`
  String get otpSentSuccessfully {
    return Intl.message(
      'Verification code sent',
      name: 'otpSentSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Verify code`
  String get verifyCode {
    return Intl.message('Verify code', name: 'verifyCode', desc: '', args: []);
  }

  /// `Confirm number`
  String get confirmPhoneNumber {
    return Intl.message(
      'Confirm number',
      name: 'confirmPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get errorTitle {
    return Intl.message('Error', name: 'errorTitle', desc: '', args: []);
  }

  /// `Success`
  String get successTitle {
    return Intl.message('Success', name: 'successTitle', desc: '', args: []);
  }

  /// `Complete checkout`
  String get completeCheckout {
    return Intl.message(
      'Complete checkout',
      name: 'completeCheckout',
      desc: '',
      args: [],
    );
  }

  /// `Buy now`
  String get buyNow {
    return Intl.message('Buy now', name: 'buyNow', desc: '', args: []);
  }

  /// `Add to cart`
  String get addToCartButton {
    return Intl.message(
      'Add to cart',
      name: 'addToCartButton',
      desc: '',
      args: [],
    );
  }

  /// `Discount {percentage}%`
  String discountLabel(double percentage) {
    return Intl.message(
      'Discount $percentage%',
      name: 'discountLabel',
      desc: '',
      args: [percentage],
    );
  }

  /// `Logged in successfully`
  String get loginSuccess {
    return Intl.message(
      'Logged in successfully',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Sign in for the best experience`
  String get signInForBestService {
    return Intl.message(
      'Sign in for the best experience',
      name: 'signInForBestService',
      desc: '',
      args: [],
    );
  }

  /// `Sign in easily via`
  String get signInEasilyVia {
    return Intl.message(
      'Sign in easily via',
      name: 'signInEasilyVia',
      desc: '',
      args: [],
    );
  }

  /// `My addresses`
  String get myAddresses {
    return Intl.message(
      'My addresses',
      name: 'myAddresses',
      desc: '',
      args: [],
    );
  }

  /// `Contact us`
  String get contactUs {
    return Intl.message('Contact us', name: 'contactUs', desc: '', args: []);
  }

  /// `Return policy`
  String get returnPolicy {
    return Intl.message(
      'Return policy',
      name: 'returnPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Sign out`
  String get signOut {
    return Intl.message('Sign out', name: 'signOut', desc: '', args: []);
  }

  /// `Selected color:`
  String get selectedColor {
    return Intl.message(
      'Selected color:',
      name: 'selectedColor',
      desc: '',
      args: [],
    );
  }

  /// `Description and details`
  String get descriptionAndDetails {
    return Intl.message(
      'Description and details',
      name: 'descriptionAndDetails',
      desc: '',
      args: [],
    );
  }

  /// `Similar Products`
  String get similarProducts {
    return Intl.message(
      'Similar Products',
      name: 'similarProducts',
      desc: '',
      args: [],
    );
  }

  /// `High quality`
  String get highQuality {
    return Intl.message(
      'High quality',
      name: 'highQuality',
      desc: '',
      args: [],
    );
  }

  /// `Prices that suit you`
  String get pricesSuitYou {
    return Intl.message(
      'Prices that suit you',
      name: 'pricesSuitYou',
      desc: '',
      args: [],
    );
  }

  /// `Discover the latest fashion trends in shoes and bags in Egypt with world-class quality.`
  String get discoverLatestFashion {
    return Intl.message(
      'Discover the latest fashion trends in shoes and bags in Egypt with world-class quality.',
      name: 'discoverLatestFashion',
      desc: '',
      args: [],
    );
  }

  /// `Shop as guest`
  String get shopAsGuest {
    return Intl.message(
      'Shop as guest',
      name: 'shopAsGuest',
      desc: '',
      args: [],
    );
  }

  /// `Or sign in easily`
  String get orSignInEasily {
    return Intl.message(
      'Or sign in easily',
      name: 'orSignInEasily',
      desc: '',
      args: [],
    );
  }

  /// `The process was interrupted. Please try again.`
  String get firebase_error_aborted {
    return Intl.message(
      'The process was interrupted. Please try again.',
      name: 'firebase_error_aborted',
      desc: '',
      args: [],
    );
  }

  /// `This information already exists. Please double-check.`
  String get firebase_error_already_exists {
    return Intl.message(
      'This information already exists. Please double-check.',
      name: 'firebase_error_already_exists',
      desc: '',
      args: [],
    );
  }

  /// `The operation was cancelled as requested.`
  String get firebase_error_cancelled {
    return Intl.message(
      'The operation was cancelled as requested.',
      name: 'firebase_error_cancelled',
      desc: '',
      args: [],
    );
  }

  /// `We're sorry, some data was lost. Please contact support for assistance.`
  String get firebase_error_data_loss {
    return Intl.message(
      'We\'re sorry, some data was lost. Please contact support for assistance.',
      name: 'firebase_error_data_loss',
      desc: '',
      args: [],
    );
  }

  /// `Request timed out. Please check your internet connection and try again.`
  String get firebase_error_deadline_exceeded {
    return Intl.message(
      'Request timed out. Please check your internet connection and try again.',
      name: 'firebase_error_deadline_exceeded',
      desc: '',
      args: [],
    );
  }

  /// `This action cannot be completed right now. Please try again later.`
  String get firebase_error_failed_precondition {
    return Intl.message(
      'This action cannot be completed right now. Please try again later.',
      name: 'firebase_error_failed_precondition',
      desc: '',
      args: [],
    );
  }

  /// `A technical error occurred on our end. We are working to fix it.`
  String get firebase_error_internal {
    return Intl.message(
      'A technical error occurred on our end. We are working to fix it.',
      name: 'firebase_error_internal',
      desc: '',
      args: [],
    );
  }

  /// `Some information was entered incorrectly. Please review and try again.`
  String get firebase_error_invalid_argument {
    return Intl.message(
      'Some information was entered incorrectly. Please review and try again.',
      name: 'firebase_error_invalid_argument',
      desc: '',
      args: [],
    );
  }

  /// `We couldn't find what you were looking for. Please make sure the details are correct.`
  String get firebase_error_not_found {
    return Intl.message(
      'We couldn\'t find what you were looking for. Please make sure the details are correct.',
      name: 'firebase_error_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Completed successfully. Thank you!`
  String get firebase_error_ok {
    return Intl.message(
      'Completed successfully. Thank you!',
      name: 'firebase_error_ok',
      desc: '',
      args: [],
    );
  }

  /// `The value entered is outside the allowed range.`
  String get firebase_error_out_of_range {
    return Intl.message(
      'The value entered is outside the allowed range.',
      name: 'firebase_error_out_of_range',
      desc: '',
      args: [],
    );
  }

  /// `Sorry, you don't have the necessary permission for this action.`
  String get firebase_error_permission_denied {
    return Intl.message(
      'Sorry, you don\'t have the necessary permission for this action.',
      name: 'firebase_error_permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `The server is busy right now. Please wait a moment and try again.`
  String get firebase_error_resource_exhausted {
    return Intl.message(
      'The server is busy right now. Please wait a moment and try again.',
      name: 'firebase_error_resource_exhausted',
      desc: '',
      args: [],
    );
  }

  /// `Please sign in first to continue.`
  String get firebase_error_unauthenticated {
    return Intl.message(
      'Please sign in first to continue.',
      name: 'firebase_error_unauthenticated',
      desc: '',
      args: [],
    );
  }

  /// `The service is temporarily unavailable. We'll be back shortly.`
  String get firebase_error_unavailable {
    return Intl.message(
      'The service is temporarily unavailable. We\'ll be back shortly.',
      name: 'firebase_error_unavailable',
      desc: '',
      args: [],
    );
  }

  /// `This feature is not available yet. Stay tuned for future updates.`
  String get firebase_error_unimplemented {
    return Intl.message(
      'This feature is not available yet. Stay tuned for future updates.',
      name: 'firebase_error_unimplemented',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again.`
  String get firebase_error_unknown {
    return Intl.message(
      'An unexpected error occurred. Please try again.',
      name: 'firebase_error_unknown',
      desc: '',
      args: [],
    );
  }

  /// `An unexpected error occurred. Please try again or check your internet connection.`
  String get firebase_error_unexpected {
    return Intl.message(
      'An unexpected error occurred. Please try again or check your internet connection.',
      name: 'firebase_error_unexpected',
      desc: '',
      args: [],
    );
  }

  /// `Add address`
  String get addAddressTitle {
    return Intl.message(
      'Add address',
      name: 'addAddressTitle',
      desc: '',
      args: [],
    );
  }

  /// `No addresses yet`
  String get noAddressesYet {
    return Intl.message(
      'No addresses yet',
      name: 'noAddressesYet',
      desc: '',
      args: [],
    );
  }

  /// `Add your first address to get started`
  String get addFirstAddress {
    return Intl.message(
      'Add your first address to get started',
      name: 'addFirstAddress',
      desc: '',
      args: [],
    );
  }

  /// `Address label`
  String get addressLabelLabel {
    return Intl.message(
      'Address label',
      name: 'addressLabelLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Home, Work`
  String get addressLabelHint {
    return Intl.message(
      'e.g. Home, Work',
      name: 'addressLabelHint',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get cityLabel {
    return Intl.message('City', name: 'cityLabel', desc: '', args: []);
  }

  /// `Area / Neighborhood`
  String get areaLabel {
    return Intl.message(
      'Area / Neighborhood',
      name: 'areaLabel',
      desc: '',
      args: [],
    );
  }

  /// `Street`
  String get streetLabel {
    return Intl.message('Street', name: 'streetLabel', desc: '', args: []);
  }

  /// `Building number`
  String get buildingNumberLabel {
    return Intl.message(
      'Building number',
      name: 'buildingNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `Floor`
  String get floorLabel {
    return Intl.message('Floor', name: 'floorLabel', desc: '', args: []);
  }

  /// `Apartment number`
  String get apartmentLabel {
    return Intl.message(
      'Apartment number',
      name: 'apartmentLabel',
      desc: '',
      args: [],
    );
  }

  /// `Set as default address`
  String get setAsDefault {
    return Intl.message(
      'Set as default address',
      name: 'setAsDefault',
      desc: '',
      args: [],
    );
  }

  /// `Save address`
  String get saveAddress {
    return Intl.message(
      'Save address',
      name: 'saveAddress',
      desc: '',
      args: [],
    );
  }

  /// `Address saved successfully`
  String get addressSaved {
    return Intl.message(
      'Address saved successfully',
      name: 'addressSaved',
      desc: '',
      args: [],
    );
  }

  /// `Address deleted`
  String get addressDeleted {
    return Intl.message(
      'Address deleted',
      name: 'addressDeleted',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get defaultBadge {
    return Intl.message('Default', name: 'defaultBadge', desc: '', args: []);
  }

  /// `Are you sure you want to delete this address?`
  String get deleteAddressConfirm {
    return Intl.message(
      'Are you sure you want to delete this address?',
      name: 'deleteAddressConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `Delete`
  String get delete {
    return Intl.message('Delete', name: 'delete', desc: '', args: []);
  }

  /// `Phone number must be 11 digits`
  String get phoneNumberMustBe11Digits {
    return Intl.message(
      'Phone number must be 11 digits',
      name: 'phoneNumberMustBe11Digits',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message('Retry', name: 'retry', desc: '', args: []);
  }

  /// `No products found`
  String get noProductsYet {
    return Intl.message(
      'No products found',
      name: 'noProductsYet',
      desc: '',
      args: [],
    );
  }

  /// `No orders yet`
  String get noOrdersYet {
    return Intl.message(
      'No orders yet',
      name: 'noOrdersYet',
      desc: '',
      args: [],
    );
  }

  /// `Your orders will appear here after your first purchase`
  String get noOrdersYetMessage {
    return Intl.message(
      'Your orders will appear here after your first purchase',
      name: 'noOrdersYetMessage',
      desc: '',
      args: [],
    );
  }

  /// `Pending`
  String get orderStatusPending {
    return Intl.message(
      'Pending',
      name: 'orderStatusPending',
      desc: '',
      args: [],
    );
  }

  /// `Confirmed`
  String get orderStatusConfirmed {
    return Intl.message(
      'Confirmed',
      name: 'orderStatusConfirmed',
      desc: '',
      args: [],
    );
  }

  /// `Shipped`
  String get orderStatusShipped {
    return Intl.message(
      'Shipped',
      name: 'orderStatusShipped',
      desc: '',
      args: [],
    );
  }

  /// `Delivered`
  String get orderStatusDelivered {
    return Intl.message(
      'Delivered',
      name: 'orderStatusDelivered',
      desc: '',
      args: [],
    );
  }

  /// `Cancelled`
  String get orderStatusCancelled {
    return Intl.message(
      'Cancelled',
      name: 'orderStatusCancelled',
      desc: '',
      args: [],
    );
  }

  /// `Refunded`
  String get orderStatusRefunded {
    return Intl.message(
      'Refunded',
      name: 'orderStatusRefunded',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get orderTotalLabel {
    return Intl.message('Total', name: 'orderTotalLabel', desc: '', args: []);
  }

  /// `Cash on delivery`
  String get paymentCOD {
    return Intl.message(
      'Cash on delivery',
      name: 'paymentCOD',
      desc: '',
      args: [],
    );
  }

  /// `Order number`
  String get orderNumberLabel {
    return Intl.message(
      'Order number',
      name: 'orderNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `View details`
  String get orderDetails {
    return Intl.message(
      'View details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `Order Details`
  String get orderDetailsTitle {
    return Intl.message(
      'Order Details',
      name: 'orderDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Order Status`
  String get orderStatusTitle {
    return Intl.message(
      'Order Status',
      name: 'orderStatusTitle',
      desc: '',
      args: [],
    );
  }

  /// `Preparing`
  String get orderStepPreparing {
    return Intl.message(
      'Preparing',
      name: 'orderStepPreparing',
      desc: '',
      args: [],
    );
  }

  /// `Shipping`
  String get orderStepShipping {
    return Intl.message(
      'Shipping',
      name: 'orderStepShipping',
      desc: '',
      args: [],
    );
  }

  /// `Delivery`
  String get orderStepDelivery {
    return Intl.message(
      'Delivery',
      name: 'orderStepDelivery',
      desc: '',
      args: [],
    );
  }

  /// `Ordered on:`
  String get orderedOnLabel {
    return Intl.message(
      'Ordered on:',
      name: 'orderedOnLabel',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkoutTitle {
    return Intl.message('Checkout', name: 'checkoutTitle', desc: '', args: []);
  }

  /// `Order summary`
  String get orderSummaryTitle {
    return Intl.message(
      'Order summary',
      name: 'orderSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `Shipping address`
  String get shippingAddressTitle {
    return Intl.message(
      'Shipping address',
      name: 'shippingAddressTitle',
      desc: '',
      args: [],
    );
  }

  /// `Payment method`
  String get paymentMethodTitle {
    return Intl.message(
      'Payment method',
      name: 'paymentMethodTitle',
      desc: '',
      args: [],
    );
  }

  /// `Place order`
  String get placeOrderButton {
    return Intl.message(
      'Place order',
      name: 'placeOrderButton',
      desc: '',
      args: [],
    );
  }

  /// `Please select a shipping address`
  String get noAddressSelected {
    return Intl.message(
      'Please select a shipping address',
      name: 'noAddressSelected',
      desc: '',
      args: [],
    );
  }

  /// `Add new address`
  String get addNewAddress {
    return Intl.message(
      'Add new address',
      name: 'addNewAddress',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get shippingFree {
    return Intl.message('Free', name: 'shippingFree', desc: '', args: []);
  }

  /// `Shipping`
  String get shippingLabel {
    return Intl.message('Shipping', name: 'shippingLabel', desc: '', args: []);
  }

  /// `Not available for this area`
  String get shippingNotAvailable {
    return Intl.message(
      'Not available for this area',
      name: 'shippingNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Subtotal`
  String get subtotalLabel {
    return Intl.message('Subtotal', name: 'subtotalLabel', desc: '', args: []);
  }

  /// `Discount`
  String get discountAmountLabel {
    return Intl.message(
      'Discount',
      name: 'discountAmountLabel',
      desc: '',
      args: [],
    );
  }

  /// `Order Confirmed!`
  String get orderConfirmedTitle {
    return Intl.message(
      'Order Confirmed!',
      name: 'orderConfirmedTitle',
      desc: '',
      args: [],
    );
  }

  /// `We'll contact you soon to confirm your delivery time`
  String get orderConfirmedMessage {
    return Intl.message(
      'We\'ll contact you soon to confirm your delivery time',
      name: 'orderConfirmedMessage',
      desc: '',
      args: [],
    );
  }

  /// `Continue Shopping`
  String get continueShopping {
    return Intl.message(
      'Continue Shopping',
      name: 'continueShopping',
      desc: '',
      args: [],
    );
  }

  /// `Sign in`
  String get loginToCheckout {
    return Intl.message('Sign in', name: 'loginToCheckout', desc: '', args: []);
  }

  /// `Sign in to track your orders and enjoy a better shopping experience`
  String get loginToCheckoutMessage {
    return Intl.message(
      'Sign in to track your orders and enjoy a better shopping experience',
      name: 'loginToCheckoutMessage',
      desc: '',
      args: [],
    );
  }

  /// `Added to cart successfully`
  String get addedToCart {
    return Intl.message(
      'Added to cart successfully',
      name: 'addedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get signInWithGoogle {
    return Intl.message(
      'Sign in with Google',
      name: 'signInWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Facebook`
  String get signInWithFacebook {
    return Intl.message(
      'Sign in with Facebook',
      name: 'signInWithFacebook',
      desc: '',
      args: [],
    );
  }

  /// `Grand Total`
  String get grandTotalLabel {
    return Intl.message(
      'Grand Total',
      name: 'grandTotalLabel',
      desc: '',
      args: [],
    );
  }

  /// `Qty: {count}`
  String quantityLabel(int count) {
    return Intl.message(
      'Qty: $count',
      name: 'quantityLabel',
      desc: '',
      args: [count],
    );
  }

  /// `Your cart is empty, add products you love!`
  String get emptyCartMessage {
    return Intl.message(
      'Your cart is empty, add products you love!',
      name: 'emptyCartMessage',
      desc: '',
      args: [],
    );
  }

  /// `Shop Now`
  String get emptyCartShopNow {
    return Intl.message(
      'Shop Now',
      name: 'emptyCartShopNow',
      desc: '',
      args: [],
    );
  }

  /// `Your favorites list is empty, save what you love!`
  String get emptyFavoritesMessage {
    return Intl.message(
      'Your favorites list is empty, save what you love!',
      name: 'emptyFavoritesMessage',
      desc: '',
      args: [],
    );
  }

  /// `Shop Now`
  String get emptyFavoritesShopNow {
    return Intl.message(
      'Shop Now',
      name: 'emptyFavoritesShopNow',
      desc: '',
      args: [],
    );
  }

  /// `+{count} more items`
  String moreProductsLabel(int count) {
    return Intl.message(
      '+$count more items',
      name: 'moreProductsLabel',
      desc: '',
      args: [count],
    );
  }

  /// `Dark Mode`
  String get darkModeLabel {
    return Intl.message('Dark Mode', name: 'darkModeLabel', desc: '', args: []);
  }

  /// `Loading`
  String get loadingTitle {
    return Intl.message('Loading', name: 'loadingTitle', desc: '', args: []);
  }

  /// `Color:`
  String get colorLabel {
    return Intl.message('Color:', name: 'colorLabel', desc: '', args: []);
  }

  /// `Page not found`
  String get notFoundTitle {
    return Intl.message(
      'Page not found',
      name: 'notFoundTitle',
      desc: '',
      args: [],
    );
  }

  /// `Back to home`
  String get backToHome {
    return Intl.message('Back to home', name: 'backToHome', desc: '', args: []);
  }

  /// `User not found`
  String get firebase_error_user_not_found {
    return Intl.message(
      'User not found',
      name: 'firebase_error_user_not_found',
      desc: '',
      args: [],
    );
  }

  /// `Wrong password`
  String get firebase_error_wrong_password {
    return Intl.message(
      'Wrong password',
      name: 'firebase_error_wrong_password',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email`
  String get firebase_error_invalid_email {
    return Intl.message(
      'Invalid email',
      name: 'firebase_error_invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `This account has been disabled`
  String get firebase_error_user_disabled {
    return Intl.message(
      'This account has been disabled',
      name: 'firebase_error_user_disabled',
      desc: '',
      args: [],
    );
  }

  /// `Too many attempts, try later`
  String get firebase_error_too_many_requests {
    return Intl.message(
      'Too many attempts, try later',
      name: 'firebase_error_too_many_requests',
      desc: '',
      args: [],
    );
  }

  /// `Check your internet connection`
  String get firebase_error_network_request_failed {
    return Intl.message(
      'Check your internet connection',
      name: 'firebase_error_network_request_failed',
      desc: '',
      args: [],
    );
  }

  /// `You don't have access to this panel`
  String get firebase_error_access_denied {
    return Intl.message(
      'You don\'t have access to this panel',
      name: 'firebase_error_access_denied',
      desc: '',
      args: [],
    );
  }

  /// `Each color must have at least one image`
  String get productFormErrorColorMustHaveImage {
    return Intl.message(
      'Each color must have at least one image',
      name: 'productFormErrorColorMustHaveImage',
      desc: '',
      args: [],
    );
  }

  /// `Please add an image for the category`
  String get categoryImageRequired {
    return Intl.message(
      'Please add an image for the category',
      name: 'categoryImageRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please add a main image for the product`
  String get productFormErrorMainImageRequired {
    return Intl.message(
      'Please add a main image for the product',
      name: 'productFormErrorMainImageRequired',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid number`
  String get productFormErrorInvalidNumber {
    return Intl.message(
      'Please enter a valid number',
      name: 'productFormErrorInvalidNumber',
      desc: '',
      args: [],
    );
  }

  /// `Search by order ID...`
  String get ordersSearchHint {
    return Intl.message(
      'Search by order ID...',
      name: 'ordersSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `Search applies to loaded orders only`
  String get ordersSearchScopeHint {
    return Intl.message(
      'Search applies to loaded orders only',
      name: 'ordersSearchScopeHint',
      desc: '',
      args: [],
    );
  }

  /// `No orders found`
  String get ordersEmpty {
    return Intl.message(
      'No orders found',
      name: 'ordersEmpty',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get allOrdersFilter {
    return Intl.message('All', name: 'allOrdersFilter', desc: '', args: []);
  }

  /// `Customer`
  String get orderCustomerLabel {
    return Intl.message(
      'Customer',
      name: 'orderCustomerLabel',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get orderDateLabel {
    return Intl.message('Date', name: 'orderDateLabel', desc: '', args: []);
  }

  /// `Order status updated`
  String get orderStatusUpdated {
    return Intl.message(
      'Order status updated',
      name: 'orderStatusUpdated',
      desc: '',
      args: [],
    );
  }

  /// `Failed to update status`
  String get orderStatusUpdateFailed {
    return Intl.message(
      'Failed to update status',
      name: 'orderStatusUpdateFailed',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Address`
  String get orderShippingAddressLabel {
    return Intl.message(
      'Shipping Address',
      name: 'orderShippingAddressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Payment Method`
  String get orderPaymentMethodLabel {
    return Intl.message(
      'Payment Method',
      name: 'orderPaymentMethodLabel',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get orderProductsLabel {
    return Intl.message(
      'Products',
      name: 'orderProductsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Price Breakdown`
  String get orderPriceBreakdownLabel {
    return Intl.message(
      'Price Breakdown',
      name: 'orderPriceBreakdownLabel',
      desc: '',
      args: [],
    );
  }

  /// `Update Status`
  String get updateStatusLabel {
    return Intl.message(
      'Update Status',
      name: 'updateStatusLabel',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get customerNameLabel {
    return Intl.message('Name', name: 'customerNameLabel', desc: '', args: []);
  }

  /// `Phone`
  String get customerPhoneLabel {
    return Intl.message(
      'Phone',
      name: 'customerPhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `Customer Details`
  String get customerDataLabel {
    return Intl.message(
      'Customer Details',
      name: 'customerDataLabel',
      desc: '',
      args: [],
    );
  }

  /// `Free`
  String get freeShippingLabel {
    return Intl.message('Free', name: 'freeShippingLabel', desc: '', args: []);
  }

  /// `Order Summary`
  String get orderAccountSummaryLabel {
    return Intl.message(
      'Order Summary',
      name: 'orderAccountSummaryLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select the new order status`
  String get selectNewStatusHint {
    return Intl.message(
      'Select the new order status',
      name: 'selectNewStatusHint',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelLabel {
    return Intl.message('Cancel', name: 'cancelLabel', desc: '', args: []);
  }

  /// `Show all remaining items`
  String get showRemainingItemsLabel {
    return Intl.message(
      'Show all remaining items',
      name: 'showRemainingItemsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total units`
  String get totalUnitsLabel {
    return Intl.message(
      'Total units',
      name: 'totalUnitsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Order Items`
  String get orderItemsLabel {
    return Intl.message(
      'Order Items',
      name: 'orderItemsLabel',
      desc: '',
      args: [],
    );
  }

  /// `Copy`
  String get copyLabel {
    return Intl.message('Copy', name: 'copyLabel', desc: '', args: []);
  }

  /// `Copy Address`
  String get copyAddressLabel {
    return Intl.message(
      'Copy Address',
      name: 'copyAddressLabel',
      desc: '',
      args: [],
    );
  }

  /// `Address copied`
  String get addressCopiedLabel {
    return Intl.message(
      'Address copied',
      name: 'addressCopiedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Name copied`
  String get nameCopiedLabel {
    return Intl.message(
      'Name copied',
      name: 'nameCopiedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Phone number copied`
  String get phoneCopiedLabel {
    return Intl.message(
      'Phone number copied',
      name: 'phoneCopiedLabel',
      desc: '',
      args: [],
    );
  }

  /// `Search by name or email...`
  String get customersSearchHint {
    return Intl.message(
      'Search by name or email...',
      name: 'customersSearchHint',
      desc: '',
      args: [],
    );
  }

  /// `No customers found`
  String get customersEmpty {
    return Intl.message(
      'No customers found',
      name: 'customersEmpty',
      desc: '',
      args: [],
    );
  }

  /// `View Orders`
  String get viewOrdersBtn {
    return Intl.message(
      'View Orders',
      name: 'viewOrdersBtn',
      desc: '',
      args: [],
    );
  }

  /// `Customer Orders`
  String get customerOrdersTitle {
    return Intl.message(
      'Customer Orders',
      name: 'customerOrdersTitle',
      desc: '',
      args: [],
    );
  }

  /// `Store Customization`
  String get storeConfigTitle {
    return Intl.message(
      'Store Customization',
      name: 'storeConfigTitle',
      desc: '',
      args: [],
    );
  }

  /// `Manage shipping costs, categories, and general appearance`
  String get storeConfigSubtitle {
    return Intl.message(
      'Manage shipping costs, categories, and general appearance',
      name: 'storeConfigSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Costs`
  String get shippingSectionTitle {
    return Intl.message(
      'Shipping Costs',
      name: 'shippingSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add Governorate`
  String get addGovernorate {
    return Intl.message(
      'Add Governorate',
      name: 'addGovernorate',
      desc: '',
      args: [],
    );
  }

  /// `Edit Shipping Cost`
  String get editShippingCostTitle {
    return Intl.message(
      'Edit Shipping Cost',
      name: 'editShippingCostTitle',
      desc: '',
      args: [],
    );
  }

  /// `Shipping Cost (EGP)`
  String get shippingCostFieldLabel {
    return Intl.message(
      'Shipping Cost (EGP)',
      name: 'shippingCostFieldLabel',
      desc: '',
      args: [],
    );
  }

  /// `Select Governorate`
  String get selectGovernorate {
    return Intl.message(
      'Select Governorate',
      name: 'selectGovernorate',
      desc: '',
      args: [],
    );
  }

  /// `Search governorate...`
  String get searchGovernorateHint {
    return Intl.message(
      'Search governorate...',
      name: 'searchGovernorateHint',
      desc: '',
      args: [],
    );
  }

  /// `This governorate is already added`
  String get governorateAlreadyAdded {
    return Intl.message(
      'This governorate is already added',
      name: 'governorateAlreadyAdded',
      desc: '',
      args: [],
    );
  }

  /// `All governorates are already added`
  String get noGovernoratesToAdd {
    return Intl.message(
      'All governorates are already added',
      name: 'noGovernoratesToAdd',
      desc: '',
      args: [],
    );
  }

  /// `No shipping costs defined yet`
  String get shippingCostsEmpty {
    return Intl.message(
      'No shipping costs defined yet',
      name: 'shippingCostsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Delete this governorate?`
  String get confirmDeleteGovernorate {
    return Intl.message(
      'Delete this governorate?',
      name: 'confirmDeleteGovernorate',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categoriesSectionTitle {
    return Intl.message(
      'Categories',
      name: 'categoriesSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add Category`
  String get addCategory {
    return Intl.message(
      'Add Category',
      name: 'addCategory',
      desc: '',
      args: [],
    );
  }

  /// `Category Name`
  String get categoryNameLabel {
    return Intl.message(
      'Category Name',
      name: 'categoryNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `e.g. Winter Clothes`
  String get categoryNameHint {
    return Intl.message(
      'e.g. Winter Clothes',
      name: 'categoryNameHint',
      desc: '',
      args: [],
    );
  }

  /// `Upload Photo`
  String get uploadPhoto {
    return Intl.message(
      'Upload Photo',
      name: 'uploadPhoto',
      desc: '',
      args: [],
    );
  }

  /// `Add New Category`
  String get addNewCategoryBtn {
    return Intl.message(
      'Add New Category',
      name: 'addNewCategoryBtn',
      desc: '',
      args: [],
    );
  }

  /// `No categories yet`
  String get categoriesEmpty {
    return Intl.message(
      'No categories yet',
      name: 'categoriesEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Delete this category?`
  String get confirmDeleteCategory {
    return Intl.message(
      'Delete this category?',
      name: 'confirmDeleteCategory',
      desc: '',
      args: [],
    );
  }

  /// `Delete this image?`
  String get confirmDeleteImage {
    return Intl.message(
      'Delete this image?',
      name: 'confirmDeleteImage',
      desc: '',
      args: [],
    );
  }

  /// `Collection Banner`
  String get bannerSectionTitle {
    return Intl.message(
      'Collection Banner',
      name: 'bannerSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `Banner Title`
  String get bannerTitleLabel {
    return Intl.message(
      'Banner Title',
      name: 'bannerTitleLabel',
      desc: '',
      args: [],
    );
  }

  /// `Badge Text`
  String get bannerBadgeLabel {
    return Intl.message(
      'Badge Text',
      name: 'bannerBadgeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Collection Name`
  String get bannerCollectionLabel {
    return Intl.message(
      'Collection Name',
      name: 'bannerCollectionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get bannerDescriptionLabel {
    return Intl.message(
      'Description',
      name: 'bannerDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `Save Changes`
  String get saveChanges {
    return Intl.message(
      'Save Changes',
      name: 'saveChanges',
      desc: '',
      args: [],
    );
  }

  /// `Changes saved successfully`
  String get storeConfigSaveSuccess {
    return Intl.message(
      'Changes saved successfully',
      name: 'storeConfigSaveSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save changes, please try again`
  String get storeConfigSaveFailed {
    return Intl.message(
      'Failed to save changes, please try again',
      name: 'storeConfigSaveFailed',
      desc: '',
      args: [],
    );
  }

  /// `Please add a banner image`
  String get bannerImageRequired {
    return Intl.message(
      'Please add a banner image',
      name: 'bannerImageRequired',
      desc: '',
      args: [],
    );
  }

  /// `Favourites`
  String get customerFavoritesTitle {
    return Intl.message(
      'Favourites',
      name: 'customerFavoritesTitle',
      desc: '',
      args: [],
    );
  }

  /// `No favourite products`
  String get customerFavoritesEmpty {
    return Intl.message(
      'No favourite products',
      name: 'customerFavoritesEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get customerCartTitle {
    return Intl.message('Cart', name: 'customerCartTitle', desc: '', args: []);
  }

  /// `No items in cart`
  String get customerCartEmpty {
    return Intl.message(
      'No items in cart',
      name: 'customerCartEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Username`
  String get usernameLabel {
    return Intl.message('Username', name: 'usernameLabel', desc: '', args: []);
  }

  /// `Staff Management`
  String get staffManagementTitle {
    return Intl.message(
      'Staff Management',
      name: 'staffManagementTitle',
      desc: '',
      args: [],
    );
  }

  /// `Add Staff`
  String get addStaffBtn {
    return Intl.message('Add Staff', name: 'addStaffBtn', desc: '', args: []);
  }

  /// `Username`
  String get staffUsernameLabel {
    return Intl.message(
      'Username',
      name: 'staffUsernameLabel',
      desc: '',
      args: [],
    );
  }

  /// `Role`
  String get staffRoleLabel {
    return Intl.message('Role', name: 'staffRoleLabel', desc: '', args: []);
  }

  /// `Created`
  String get staffCreatedAtLabel {
    return Intl.message(
      'Created',
      name: 'staffCreatedAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `Change Role`
  String get changeRoleBtn {
    return Intl.message(
      'Change Role',
      name: 'changeRoleBtn',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePasswordBtn {
    return Intl.message(
      'Change Password',
      name: 'changePasswordBtn',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get deleteStaffBtn {
    return Intl.message('Delete', name: 'deleteStaffBtn', desc: '', args: []);
  }

  /// `Are you sure you want to delete this staff member?`
  String get deleteStaffConfirm {
    return Intl.message(
      'Are you sure you want to delete this staff member?',
      name: 'deleteStaffConfirm',
      desc: '',
      args: [],
    );
  }

  /// `Staff account created successfully`
  String get staffCreatedSuccess {
    return Intl.message(
      'Staff account created successfully',
      name: 'staffCreatedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Staff account deleted`
  String get staffDeletedSuccess {
    return Intl.message(
      'Staff account deleted',
      name: 'staffDeletedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get staffPasswordChangedSuccess {
    return Intl.message(
      'Password changed successfully',
      name: 'staffPasswordChangedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Role updated successfully`
  String get staffRoleChangedSuccess {
    return Intl.message(
      'Role updated successfully',
      name: 'staffRoleChangedSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Cannot delete the last super admin. Assign another super admin first.`
  String get cannotDeleteLastSuperAdmin {
    return Intl.message(
      'Cannot delete the last super admin. Assign another super admin first.',
      name: 'cannotDeleteLastSuperAdmin',
      desc: '',
      args: [],
    );
  }

  /// `You cannot delete your own account.`
  String get cannotDeleteYourself {
    return Intl.message(
      'You cannot delete your own account.',
      name: 'cannotDeleteYourself',
      desc: '',
      args: [],
    );
  }

  /// `Out of Stock`
  String get outOfStockLabel {
    return Intl.message(
      'Out of Stock',
      name: 'outOfStockLabel',
      desc: '',
      args: [],
    );
  }

  /// `Some items are out of stock`
  String get someItemsUnavailableError {
    return Intl.message(
      'Some items are out of stock',
      name: 'someItemsUnavailableError',
      desc: '',
      args: [],
    );
  }

  /// `Product {productName} is currently out of stock`
  String outOfStockProduct(String productName) {
    return Intl.message(
      'Product $productName is currently out of stock',
      name: 'outOfStockProduct',
      desc: '',
      args: [productName],
    );
  }

  /// `Only {available} left for {productName}`
  String lowStockProduct(String productName, int available) {
    return Intl.message(
      'Only $available left for $productName',
      name: 'lowStockProduct',
      desc: '',
      args: [productName, available],
    );
  }

  /// `Reports`
  String get reportsTitle {
    return Intl.message('Reports', name: 'reportsTitle', desc: '', args: []);
  }

  /// `Total Revenue`
  String get totalRevenueLabel {
    return Intl.message(
      'Total Revenue',
      name: 'totalRevenueLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total Orders`
  String get totalOrdersLabel {
    return Intl.message(
      'Total Orders',
      name: 'totalOrdersLabel',
      desc: '',
      args: [],
    );
  }

  /// `Average Order Value`
  String get avgOrderValueLabel {
    return Intl.message(
      'Average Order Value',
      name: 'avgOrderValueLabel',
      desc: '',
      args: [],
    );
  }

  /// `Total Customers`
  String get totalCustomersLabel {
    return Intl.message(
      'Total Customers',
      name: 'totalCustomersLabel',
      desc: '',
      args: [],
    );
  }

  /// `Top Selling`
  String get topSellersLabel {
    return Intl.message(
      'Top Selling',
      name: 'topSellersLabel',
      desc: '',
      args: [],
    );
  }

  /// `Top Spenders`
  String get topSpendersLabel {
    return Intl.message(
      'Top Spenders',
      name: 'topSpendersLabel',
      desc: '',
      args: [],
    );
  }

  /// `Cancellation Rate`
  String get cancellationRateLabel {
    return Intl.message(
      'Cancellation Rate',
      name: 'cancellationRateLabel',
      desc: '',
      args: [],
    );
  }

  /// `Daily Revenue (Last 30 Days)`
  String get dailyRevenueChartTitle {
    return Intl.message(
      'Daily Revenue (Last 30 Days)',
      name: 'dailyRevenueChartTitle',
      desc: '',
      args: [],
    );
  }

  /// `Monthly Revenue`
  String get monthlyRevenueChartTitle {
    return Intl.message(
      'Monthly Revenue',
      name: 'monthlyRevenueChartTitle',
      desc: '',
      args: [],
    );
  }

  /// `Orders by Status`
  String get ordersStatusChartTitle {
    return Intl.message(
      'Orders by Status',
      name: 'ordersStatusChartTitle',
      desc: '',
      args: [],
    );
  }

  /// `Load Out-of-Stock Products`
  String get loadOutOfStockBtn {
    return Intl.message(
      'Load Out-of-Stock Products',
      name: 'loadOutOfStockBtn',
      desc: '',
      args: [],
    );
  }

  /// `Failed to load out-of-stock products`
  String get loadOutOfStockError {
    return Intl.message(
      'Failed to load out-of-stock products',
      name: 'loadOutOfStockError',
      desc: '',
      args: [],
    );
  }

  /// `No data available`
  String get noDataAvailable {
    return Intl.message(
      'No data available',
      name: 'noDataAvailable',
      desc: '',
      args: [],
    );
  }

  /// `{count} orders`
  String orderCountLabel(int count) {
    return Intl.message(
      '$count orders',
      name: 'orderCountLabel',
      desc: '',
      args: [count],
    );
  }

  /// `{count} sold`
  String totalSoldLabel(int count) {
    return Intl.message(
      '$count sold',
      name: 'totalSoldLabel',
      desc: '',
      args: [count],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
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
