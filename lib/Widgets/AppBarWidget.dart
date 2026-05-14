import 'package:business_listing_app/Screens/MyHomePage.dart';
import 'package:business_listing_app/Screens/SettingsPage.dart';
import 'package:flutter/material.dart';

PreferredSizeWidget appBarWidget (String title, BuildContext context){
  return AppBar(
    leading: IconButton(
      icon: Image(
        image: AssetImage('assets/icon.jpg'),
        height: 40,
        width: 40,
      ),
      onPressed: () {
        final currentRouteName = ModalRoute.of(context)?.settings.name;
        if (currentRouteName == '/settings' || currentRouteName == '/details') {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: title), settings: RouteSettings(name: '/')));
        }
      },
    ),
    backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    title: Text(title),
    actions: [
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          final currentRouteName = ModalRoute.of(context)?.settings.name;
          if (currentRouteName == '/' || currentRouteName == '/details') {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage(title: title), settings: RouteSettings(name: '/settings')));
          }
        },
      ),
    ],
  );
}
