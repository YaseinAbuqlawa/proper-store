import 'package:flutter/material.dart';

import 'package:proper_store_shared/failures/app_failures.dart';
import 'package:proper_store_shared/generated/l10n.dart';

export 'package:proper_store_shared/failures/app_failures.dart';

extension ServerFailureExt on ServerFailure {
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
      // TODO(l10n): restore specific auth error cases after running Flutter Intl gen
      // (keys are in ARBs but not yet in generated l10n.dart)
      case 'unexpected-error':
        return s.firebase_error_unexpected;
      default:
        return s.firebase_error_unknown;
    }
  }
}
