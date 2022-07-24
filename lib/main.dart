import 'package:flutter/material.dart';
import 'package:flutter_my_notes/constants/routes.dart';
import 'package:flutter_my_notes/services/auth/auth_service.dart';
import 'package:flutter_my_notes/views/login_view.dart';
import 'package:flutter_my_notes/views/notes_view.dart';
import 'package:flutter_my_notes/views/register_view.dart';
import 'package:flutter_my_notes/views/verify_email_view.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      notesRoute: (context) => const NoteView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {                                                                                                                                                                                                                                                                                                                                                                                                                  
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentuser;
            if (user != null) {
              if (user.isEmailVerified) {
                return const NoteView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
            return const NoteView();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
