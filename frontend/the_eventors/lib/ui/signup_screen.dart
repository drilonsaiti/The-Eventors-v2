import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:the_eventors/ui/widgets/login_button.dart';
import 'package:the_eventors/ui/widgets/signup.dart';

import '../models/User.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => SignupScreenState();
}

class SignupScreenState extends State<SignupScreen> {
  final minimumPadding = 5.0;

  TextEditingController firstController = TextEditingController();
  TextEditingController lastController = TextEditingController();

  late User employee;

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return Scaffold(
        backgroundColor: const Color(0xff007CC7),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 70.h,
              child: CustomPaint(
                painter: CurvePainter(false),
                child: Container(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: const Center(
                      child: SingleChildScrollView(
                          padding: EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          child: SignUp()),
                    )),
              ),
            ),
            Container(
              height: 30.h,
              padding:
                  EdgeInsets.symmetric(horizontal: 32.0.sp, vertical: 16.0.sp),
              child: const LoginButton(),
            )
          ],
        )),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = const Color(0xFF12232E);
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width * 0.5, size.height + 120, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
