// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "firebase_error_aborted": MessageLookupByLibrary.simpleMessage(
      "The process was interrupted. Please try again.",
    ),
    "firebase_error_already_exists": MessageLookupByLibrary.simpleMessage(
      "This information already exists. Please double-check.",
    ),
    "firebase_error_cancelled": MessageLookupByLibrary.simpleMessage(
      "The operation was cancelled as requested.",
    ),
    "firebase_error_data_loss": MessageLookupByLibrary.simpleMessage(
      "We\'re sorry, some data was lost. Please contact support for assistance.",
    ),
    "firebase_error_deadline_exceeded": MessageLookupByLibrary.simpleMessage(
      "Request timed out. Please check your internet connection and try again.",
    ),
    "firebase_error_failed_precondition": MessageLookupByLibrary.simpleMessage(
      "This action cannot be completed right now. Please try again later.",
    ),
    "firebase_error_internal": MessageLookupByLibrary.simpleMessage(
      "A technical error occurred on our end. We are working to fix it.",
    ),
    "firebase_error_invalid_argument": MessageLookupByLibrary.simpleMessage(
      "Some information was entered incorrectly. Please review and try again.",
    ),
    "firebase_error_not_found": MessageLookupByLibrary.simpleMessage(
      "We couldn\'t find what you were looking for. Please make sure the details are correct.",
    ),
    "firebase_error_ok": MessageLookupByLibrary.simpleMessage(
      "Completed successfully. Thank you!",
    ),
    "firebase_error_out_of_range": MessageLookupByLibrary.simpleMessage(
      "The value entered is outside the allowed range.",
    ),
    "firebase_error_permission_denied": MessageLookupByLibrary.simpleMessage(
      "Sorry, you don\'t have the necessary permission for this action.",
    ),
    "firebase_error_resource_exhausted": MessageLookupByLibrary.simpleMessage(
      "The server is busy right now. Please wait a moment and try again.",
    ),
    "firebase_error_unauthenticated": MessageLookupByLibrary.simpleMessage(
      "Please sign in first to continue.",
    ),
    "firebase_error_unavailable": MessageLookupByLibrary.simpleMessage(
      "The service is temporarily unavailable. We\'ll be back shortly.",
    ),
    "firebase_error_unexpected": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred. Please try again or check your internet connection.",
    ),
    "firebase_error_unimplemented": MessageLookupByLibrary.simpleMessage(
      "This feature is not available yet. Stay tuned for future updates.",
    ),
    "firebase_error_unknown": MessageLookupByLibrary.simpleMessage(
      "An unexpected error occurred. Please try again.",
    ),
  };
}
