import 'package:flutter/material.dart';
import 'package:the_eventors/ui/home_screen.dart';

import 'package:the_eventors/ui/login_screen.dart';
import 'package:the_eventors/ui/widgets/top_profile_widget.dart';

import '../services/Auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  checkUser() async {
    Future.delayed(
        const Duration(seconds: 2),
        () async => await Auth().checkRefresh()
            ? Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()))
            : Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              ));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return SafeArea(
            child: Scaffold(
          body: Container(
            color: Color(0xFF203647),
            child: AnimatedOpacity(
              opacity: 1.0,
              duration: const Duration(milliseconds: 1200),
              child: Center(
                  child: Container(
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipOval(
                        child: Image.asset(
                      "assets/logo-trp.png",
                      height: 160,
                      width: 160,
                    )),
                    Container(
                        child: Text(
                      "The eventors",
                      style: TextStyle(
                        fontSize: 30,
                        color: Color(0xff4DA8DA),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    )),
                  ],
                )),
              )),
            ),
          ),
        ));
      },
    );
  }
}
