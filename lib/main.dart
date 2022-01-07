import 'package:contacts/models/contacts.dart';
import 'package:contacts/screens/contacts_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'models/contact_manager.dart';
import 'models/user_manager.dart';
import 'screens/contact_details.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
        ),
        ChangeNotifierProvider(
          create: (_) => ContactManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => Contact(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Contactos',
        initialRoute: '/splash_screen',
        routes: {
          "/login_screen": (_) => const LoginScreen(),
          "/signup_screen": (_) => SignupScreen(),
          "/contacts_screen": (_) => ContactsScreen(),
          "/contact_detail": (_) => ContactDetails(),
          "/splash_screen": (_) => SplashScreen()
        },
      ),
    );
  }
}
