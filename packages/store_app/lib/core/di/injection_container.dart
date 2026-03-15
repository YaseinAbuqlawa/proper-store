import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection_container.config.dart';

final GetIt sl = GetIt.instance;

@InjectableInit(initializerName: 'init')
void configureDependencies() => sl.init();

@module
abstract class ExternalModules {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
  @lazySingleton
  FirebaseAuth get auth => FirebaseAuth.instance;
  @lazySingleton
  FirebaseFunctions get functions => FirebaseFunctions.instance;
}
