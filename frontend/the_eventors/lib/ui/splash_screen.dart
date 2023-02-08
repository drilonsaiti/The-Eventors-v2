import 'package:flutter/material.dart';
import 'package:the_eventors/ui/categories_screen.dart';
import 'package:the_eventors/ui/home_screen.dart';
import 'package:the_eventors/ui/login_screen.dart';

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
    Future.delayed(
        const Duration(seconds: 1),
        () => Navigator.push(
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
