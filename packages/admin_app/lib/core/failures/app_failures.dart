import 'package:flutter/material.dart';

import 'package:proper_store_shared/failures/app_failures.dart';
import 'package:proper_store_shared/generated/l10n.dart';

export 'package:proper_store_shared/failures/app_failures.dart';

extension FirebaseFailureExt on FirebaseFailure {
  String fromException({required BuildContext context}) {
    final s = S.of(context);

    switch (code) {
      case 'aborted':
        return s.firebase_error_aborted;
      case 'already-exists':
        return s.firebase_error_already_exists;
      case 'cancelled':
        return s.firebase_error_cancelled;
      case 'data-loss':
        return s.firebase_error_data_loss;
      case 'deadline-exceeded':
        return s.firebase_error_deadline_exceeded;
      case 'failed-precondition':
        return s.firebase_error_failed_precondition;
      case 'internal':
        return s.firebase_error_internal;
      case 'invalid-argument':
        return s.firebase_error_invalid_argument;
      case 'not-found':
        return s.firebase_error_not_found;
      case 'permission-denied':
        return s.firebase_error_permission_denied;
      case 'resource-exhausted':
        return s.firebase_error_resource_exhausted;
      case 'unauthenticated':
        return s.firebase_error_unauthenticated;
      case 'unavailable':
        return s.firebase_error_unavailable;
      case 'unimplemented':
        return s.firebase_error_unimplemented;
      case 'user-not-found':
        return s.firebase_error_user_not_found;
      case 'wrong-password':
        return s.firebase_error_wrong_password;
      case 'invalid-email':
        return s.firebase_error_invalid_email;
      case 'user-disabled':
        return s.firebase_error_user_disabled;
      case 'too-many-requests':
        return s.firebase_error_too_many_requests;
      case 'network-request-failed':
        return s.firebase_error_network_request_failed;
      case 'access-denied':
        return s.firebase_error_access_denied;
      case 'unexpected-error':
        return s.firebase_error_unexpected;
      default:
        return s.firebase_error_unknown;
    }
  }
}
