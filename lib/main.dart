import 'package:business_listing_app/Screens/SettingsPage.dart';
import 'package:flutter/material.dart';

import 'Screens/MyHomePage.dart';
import 'Services/NotificationService.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Business Listing App',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.green),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: "Business Listing App"),
        '/settings': (context) => const SettingsPage(title: "Business Listing App")
      },
    );
  }
}

