import 'package:flutter/material.dart';

import '../pages/pages.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '4Dev',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
