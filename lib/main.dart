import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:time_app/screens/home/home_screen.dart';
import 'package:time_app/screens/authorization/authorization_screen.dart';
import 'package:time_app/bloc/bloc_provider.dart';
import 'package:time_app/bloc/application_bloc.dart';
import 'package:time_app/bloc/authorization_bloc.dart';
import 'package:time_app/bloc/home_bloc.dart';
import 'package:time_app/screens/splash/splash_screen.dart';

void main() async {

  return runApp(
    BlocProvider<ApplicationBloc>(
      bloc: ApplicationBloc(),
      child: Splash(),
    )
  );
}

class TimeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimeApp Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0
        ),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.green,
        bottomAppBarColor: Colors.yellow,
      ),
      home: _buildHomePage(),
    );
  }

  Widget _buildHomePage() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        // if the user is logged in, there will be some data. This needs to be reviewed in future to understand what exact data do we need to check in order to understand, if the user is signed in
        if (snapshot.hasData) {
          return BlocProvider(
            bloc: HomeBloc(),
            child: HomeScreen(),
          );
        } else {
          return BlocProvider(
            bloc: AuthorizationBloc(),
            child: AuthorizationScreen(),
          );
        }
      },
    );
  }
}
