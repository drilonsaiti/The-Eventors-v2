import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScreenUtilInit(
            designSize: const Size(400, 590),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return SafeArea(
                  child: Scaffold(
                      backgroundColor: const Color(0xff007CC7),
                      body: Container(
                        height: 400.h,
                        child: Container(
                          child: CustomPaint(
                            painter: CurvePainter(true),
                            child: Container(
                                padding: const EdgeInsets.only(bottom: 0),
                                child: Center(
                                  child: SingleChildScrollView(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 32.h,
                                        vertical: 16.w,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [],
                                      )),
                                )),
                          ),
                        ),
                      )));
            });
      },
    );
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
        size.width * 0.5,
        outterCurve ? size.height + 200 : size.height - 50,
        size.width,
        size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
