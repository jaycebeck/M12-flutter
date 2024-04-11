import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/basics_example.dart';
import 'pages/events_example.dart';
import 'tab.dart';
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20.0),
            ElevatedButton(
                child: Text('This is a button'),
                onPressed: () => Text("FIXME") //FIXME: Add onPressed,
                )
          ],
        ),
      ),
    );
  }
}
