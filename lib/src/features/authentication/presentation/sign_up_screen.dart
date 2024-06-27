import 'package:flutter/material.dart';
import 'package:ts_6_1_1_firebase_setup_auth/src/data/database_repository.dart';
import 'package:ts_6_1_1_firebase_setup_auth/src/data/firebase_auth.dart';
import 'package:ts_6_1_1_firebase_setup_auth/src/features/authentication/application/validators.dart';
import 'package:ts_6_1_1_firebase_setup_auth/src/features/authentication/presentation/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  // Attribute
  final DatabaseRepository databaseRepository;
  final AuthRepository authRepository;

  // Konstruktor
  const SignUpScreen(
      {super.key,
      required this.databaseRepository,
      required this.authRepository});

  // Methoden
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // state
  bool showPassword = false;

  late TextEditingController _emailController;
  late TextEditingController _pwController;
  late TextEditingController _pwRepeatController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _pwController = TextEditingController();
    _pwRepeatController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    _pwRepeatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registrierung"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: _emailController,
                  validator: validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                    icon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _pwController,
                  validator: validatePw,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Passwort",
                    icon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: showPassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _pwRepeatController,
                  validator: (value) {
                    return validateRepeatPw(_pwController.text, value)
                        ? null
                        : "Passwörter müssen identisch sein";
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  obscureText: !showPassword,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: "Passwort wiederholen",
                    icon: const Icon(Icons.password),
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          showPassword = !showPassword;
                        });
                      },
                      icon: showPassword
                          ? const Icon(Icons.visibility_off)
                          : const Icon(Icons.visibility),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    await widget.authRepository.signUpWithEmailAndPassword(
                        _emailController.text, _pwController.text);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Registrieren"),
                  ),
                ),
                const SizedBox(height: 32),
                const Divider(),
                const SizedBox(height: 32),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(
                            databaseRepository: widget.databaseRepository,
                            authRepository: widget.authRepository,
                          ),
                        ));
                  },
                  child: const Text("Bereits einen Account? Zum Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
