import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// [FirebaseOptions] for use with your Firebase apps.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // 🔍
  debugPrint('Firebase apps: ${Firebase.apps}');

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: Center(child: Text('FireBase with BLoC/CUBIT'))),
    );
  }
}
