import 'package:flutter/material.dart';
import 'package:ts_6_1_1_firebase_setup_auth/src/data/database_repository.dart';
import 'package:ts_6_1_1_firebase_setup_auth/src/data/firebase_auth.dart';
import 'package:ts_6_1_1_firebase_setup_auth/src/features/authentication/presentation/login_screen.dart';

class MainScreen extends StatelessWidget {
  final DatabaseRepository databaseRepository;
  final AuthRepository authRepository;

  const MainScreen(
      {super.key,
      required this.databaseRepository,
      required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main Screen'),
      ),
      body: Column(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () {
                authRepository.logout();
              },
              child: const Text('Logout'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return LoginScreen(
                      databaseRepository: databaseRepository,
                      authRepository: authRepository,
                    );
                  }),
                );
              },
              child: const Icon(Icons.scoreboard),
            ),
          ),
        ],
      ),
    );
  }
}
