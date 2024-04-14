import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:m12calendar_flutter/pages/calendarPage.dart';
import 'package:m12calendar_flutter/pages/login.dart';
import 'package:m12calendar_flutter/pages/logout.dart';
import 'package:m12calendar_flutter/pages/signup.dart';

import '../main.dart';

class AppBars extends AppBar {
  final BuildContext context;

  AppBars(this.context)
      : super(
            title: Text('M12 Calendar'),
            leading: IconButton(
                onPressed: () => Navigator.push(
                    context, MaterialPageRoute(builder: (_) => StartPage())),
                icon: Icon(Icons.home_outlined)),
            actions: FirebaseAuth.instance.currentUser != null
                ? <Widget>[
                    Text(
                        "Welcome, ${FirebaseAuth.instance.currentUser!.email}"),
                    IconButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => TableCalendarPage())),
                        icon: Icon(Icons.calendar_month_outlined)),
                    IconButton(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LogoutPage())),
                        icon: Icon(Icons.logout_outlined))
                  ]
                : <Widget>[
                    IconButton(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => LoginPage())),
                        icon: Icon(Icons.login_outlined)),
                    IconButton(
                        onPressed: () => Navigator.push(context,
                            MaterialPageRoute(builder: (_) => SignUpPage())),
                        icon: Icon(Icons.person_add_outlined))
                  ]);
}
