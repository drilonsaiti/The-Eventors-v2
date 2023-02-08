import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/providers/CategoryProvider.dart';
import 'package:the_eventors/providers/EventProvider.dart';
import 'package:the_eventors/providers/UserProvider.dart';
import 'package:the_eventors/ui/categories_screen.dart';
import 'package:the_eventors/ui/login_screen.dart';
import 'package:the_eventors/ui/multi_step_form_screen.dart';

import 'package:the_eventors/ui/splash_screen.dart';
import 'package:flutter/src/widgets/framework.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(
          title: "Splash",
        ),
      ),
    );
  }
}
