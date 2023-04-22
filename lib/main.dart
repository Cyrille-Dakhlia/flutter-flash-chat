import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    // Use custom script ./run_firebase_emulators_data
    try {
      // Disable persistence to avoid discrepancies between emulated database and local caches since offline cache of Firestore SDK is not automatically cleared, while Firestore emulator clears database contents when shut down
      final settings = FirebaseFirestore.instance.settings
          .copyWith(persistenceEnabled: false);
      FirebaseFirestore.instance.settings = settings;
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);

      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    } catch (e) {
      print(e);
    }
  }

  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen.routeId,
      routes: {
        WelcomeScreen.routeId: (context) => WelcomeScreen(),
        LoginScreen.routeId: (context) => LoginScreen(),
        RegistrationScreen.routeId: (context) => RegistrationScreen(),
        ChatScreen.routeId: (context) => ChatScreen(),
      },
    );
  }
}
