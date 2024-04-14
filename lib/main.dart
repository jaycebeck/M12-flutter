import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';

import 'widgets/myAppBar.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "../assets/.env");
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: dotenv.env['FIREBASE_CONFIG_API_KEY'] as String,
          authDomain: dotenv.env['FIREBASE_CONFIG_AUTH_DOMAIN'] as String,
          projectId: dotenv.env['FIREBASE_CONFIG_PROJECT_ID'] as String,
          storageBucket: dotenv.env['FIREBASE_CONFIG_STORAGE_BUCKET'] as String,
          messagingSenderId:
              dotenv.env['FIREBASE_CONFIG_MESSAGING_SENDER_ID'] as String,
          appId: dotenv.env['FIREBASE_CONFIG_APP_ID'] as String));
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M12 Calendar',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey),
          textTheme: GoogleFonts.ralewayTextTheme()),
      home: StartPage(),
    );
  }
}

class StartPage extends StatefulWidget {
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBars(context),
      body: Container(
          margin: const EdgeInsets.all(40),
          child: const Center(
              child: Column(
            children: [
              Text(
                'Welcome to M12 Calendar!',
                style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
              ),
              Text(
                  "Please sign in above to access the full calendar experience.",
                  style: TextStyle(fontSize: 18)),
              Text(
                  "A premade account is available for testing purposes. With a task made for 4/15/2024.",
                  style: TextStyle(fontSize: 18)),
              SelectableText(
                  "Email: cesaxig597@acname.com \n Password: password1 \n",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                  "Once you sign in, you'll be able to add, edit, and delete tasks. A single task will prepopulate for today to show functionality. Task data from previous visits will not be shown unless you click on the tasks' dates.",
                  style: TextStyle(fontSize: 18)),
              Image(
                image: AssetImage('assets/blue_pikmin.png'),
                height: 300,
                width: 300,
              ),
              Text(
                  "I have been playing Pikmin recently so it felt fitting to include a pikmin here. Especially the always worried blue pikmin so enjoy! \n",
                  style: TextStyle(fontSize: 18)),
            ],
          ))),
    );
  }
}
