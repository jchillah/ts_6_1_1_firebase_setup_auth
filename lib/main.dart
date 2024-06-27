import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ts_6_1_1_firebase_setup_auth/firebase_options.dart';
import 'package:ts_6_1_1_firebase_setup_auth/src/app.dart';
import 'package:ts_6_1_1_firebase_setup_auth/src/data/database_repository.dart';
import 'package:ts_6_1_1_firebase_setup_auth/src/data/firebase_auth.dart';
import 'package:ts_6_1_1_firebase_setup_auth/src/data/mock_database.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Database einmal an der Wurzel erzeugt
  DatabaseRepository databaseRepository = MockDatabase();
  AuthRepository authRepository = AuthRepository(FirebaseAuth.instance);

  runApp(App(
    databaseRepository: databaseRepository,
    authRepository: authRepository,
  ));
}
