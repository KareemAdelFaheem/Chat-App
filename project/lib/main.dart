import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:project/Screens/Loginpage.dart';
import 'package:project/Screens/loginorregister.dart';
import 'package:project/Services/auth/auth_gate.dart';
import 'package:project/Services/authservices.dart';
import 'package:project/firebase_options.dart';
import 'package:provider/provider.dart';
// import 'package:project/Screens/signuppage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthServices(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const AuthGate(),
      },
    );
  }
}
