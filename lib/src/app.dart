import 'package:contacts_app/src/pages/contact_page.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.brown[400],
      ),
      home: ContactPage(),
    );

  }

}
