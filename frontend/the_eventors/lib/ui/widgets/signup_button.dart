import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../signup_screen.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: 35.h,
        ),
        Text(
          "OR",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 35.sp,
            fontWeight: FontWeight.bold,
            height: 1,
            color: Color(0xFF12232E),
          ),
          textScaleFactor: 1.0,
        ),
        SizedBox(
          height: 25.h,
        ),
        Container(
            height: 40.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(255, 26, 48, 63),
                  Color(0xFF12232E),
                ],
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color:
                      const Color.fromARGB(255, 87, 155, 243).withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SignupScreen()));
              },
              child: Center(
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFEEFBFB),
                  ),
                  textScaleFactor: 1.0,
                ),
              ),
            )),
      ],
    );
  }
}
