import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'injection_container.config.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

@InjectableInit(initializerName: 'init')
void configureDependencies() => sl.init();

@module
abstract class ExternalModules {
  @lazySingleton
  FirebaseFirestore get firestore => FirebaseFirestore.instance;
}
