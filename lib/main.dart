import 'package:classapp/screens/google_signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

import './colors.dart';

import 'screens/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    final base = ThemeData.light();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Kprimary,
        accentColor: Ksecondary,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Kprimary,
          selectionColor: Ksecondary,
        ),
        iconTheme: const IconThemeData(
          color: Kprimary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Kprimary,
            shadowColor: Ksecondary,
            onSurface: Kdark,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        textTheme: _classTextTheme(base.textTheme),
      ),
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(child: Text("Something Went Wrong"));
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Home();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(child: CircularProgressIndicator());
        },
      ),
      routes: {
        '/googleSignIn': (context) => LoginWithGoogle(),
      },
    );
  }
}

TextTheme _classTextTheme(TextTheme base) {
  return GoogleFonts.ralewayTextTheme(
    base.copyWith(
      headline1: base.headline1.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: 96,
      ),
      headline2: base.headline2.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 60,
      ),
      headline3: base.headline3.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 48,
      ),
      headline4: base.headline4.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 34,
      ),
      headline5: base.headline5.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 24,
      ),
      headline6: base.headline6.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 20,
      ),
      subtitle1: base.subtitle1.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      subtitle2: base.subtitle2.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
      bodyText1: base.bodyText1.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      bodyText2: base.bodyText2.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14,
      ),
      button: base.button.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 13,
      ),
      caption: base.caption.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 12,
      ),
      overline: base.overline.copyWith(
        fontWeight: FontWeight.w600,
        fontSize: 12,
      ),
    ),
  );
}
