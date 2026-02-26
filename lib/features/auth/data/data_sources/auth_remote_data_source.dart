import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:proper_store/core/helpers/app_consts.dart';
import 'package:proper_store/features/profile/data/models/customer_model.dart';

@lazySingleton
class AuthRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseFunctions functions;
  final FirebaseAuth auth;
  AuthRemoteDataSource({
    required this.firestore,
    required this.auth,
    required this.functions,
  });
  ConfirmationResult? _confirmationResult;

  Future<void> signInAnonymously() async {
    await auth.signInAnonymously();
  }

  Future<void> signInWithPhoneNumber({required String phoneNumber}) async {
    final result = await functions.httpsCallable('checkSmsLimit').call({
      'phoneNumber': phoneNumber,
    });

    if (result.data['success'] == true) {
      _confirmationResult = await auth.signInWithPhoneNumber(phoneNumber);
    } else {
      throw Exception("لقد تجاوزت الحد المسموح لإرسال الرسائل، حاول لاحقاً.");
    }
  }

  Future<UserCredential> confirmPhoneNumber({required String code}) async {
    if (_confirmationResult == null) {
      throw Exception("يجب طلب الرمز أولاً");
    }
    try {
      return await _confirmationResult!.confirm(code);
    } catch (e) {
      throw Exception("الرمز المدخل غير صحيح أو منتهي الصلاحية");
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
    googleAuthProvider.setCustomParameters({'prompt': 'select_account'});
    return await auth.signInWithPopup(googleAuthProvider);
  }

  Future<UserCredential> signInWithFacebook() async {
    FacebookAuthProvider facebookAuthProvider = FacebookAuthProvider();

    facebookAuthProvider.addScope('public_profile');
    facebookAuthProvider.addScope('email');

    facebookAuthProvider.setCustomParameters({'prompt': 'select_account'});

    return await auth.signInWithPopup(facebookAuthProvider);
  }

  Future<void> addNewCustomer({required CustomerModel customer}) async {
    final customerDoc = firestore
        .collection(AppConsts.customersCollection)
        .doc(customer.id);

    await customerDoc.set(customer.toJson());
  }
}
