// Copyright 2022 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInDemo(),
    );
  }
}

class SignInDemo extends StatefulWidget {
  @override
  State createState() {
    return _SignInDemoState();
  }
}

class _SignInDemoState extends State<SignInDemo> {
  late GoogleSignIn _googleSignIn;
  static const List<String> scopes = <String>[
    'email',
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _googleSignIn = GoogleSignIn(
      // release
      // clientId:
      //     '83999753583-e7nm6e70hdbn9hmnp65igqim9t6ffcfb.apps.googleusercontent.com',
      // debug
      // '83999753583-tiembdm9234asq20ofp5a9ivau4fhluk.apps.googleusercontent.com',
      // test
      // '83999753583-mbbihqd3pe46mse8jt2v0k4rc0gsrs83.apps.googleusercontent.com',
      scopes: scopes,
    );
  }

  void _handleSignIn() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        return;
      }
      GoogleSignInAuthentication googleAuth = await account.authentication;
      String idToken = "empty";
      idToken = googleAuth.idToken ?? "-";
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Hello, the id token is $idToken!'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  _googleSignIn.signOut();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error, is $error!'),
            actions: <Widget>[
              TextButton(
                child: Text('Close'),
                onPressed: () {
                  _googleSignIn.signOut();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text('Sign in with Google'),
          onPressed: _handleSignIn,
        ),
      ),
    );
  }
}
