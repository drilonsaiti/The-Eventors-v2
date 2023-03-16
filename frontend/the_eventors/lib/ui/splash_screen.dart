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
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
        colors: [
          Theme.of(context).colorScheme.secondary,
          Theme.of(context).primaryColor
        ],
        begin: const FractionalOffset(0, 0),
        end: const FractionalOffset(1.0, 0.0),
        stops: const [0.0, 1.0],
        tileMode: TileMode.clamp,
      )),
      child: AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 1200),
        child: Center(
            child: Container(
          height: 140.0,
          width: 140.0,
          child: const Center(
              child: ClipOval(
            child: Icon(Icons.android_outlined),
          )),
        )),
      ),
    );
  }
}
