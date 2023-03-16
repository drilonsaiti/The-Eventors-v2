import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:the_eventors/ui/signup_screen.dart';
import 'package:the_eventors/ui/widgets/signup_button.dart';
import '../providers/UserProvider.dart';
import '../services/CheckInternetAndLogin.dart';
import '../services/PermissionService.dart';
import '../ui/widgets/login.dart';
import 'forgot_pass.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;

  late StreamSubscription? subscription;
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String error = "";
  @override
  void initState() {
    super.initState();
    permissionAcessPhone();
    subscription =
        Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
  }

  @override
  void dispose() {
    subscription!.cancel();
    super.dispose();
  }

  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
        ? 'You have again ${result.toString()}'
        : 'No internet connection';

    if (!hasInternet) {
      CheckInternet.showTopSnackBar(context, message);
    }
  }

  Future<void> permissionAcessPhone() async {
    PermissionService().requestPermission(onPermissionDenied: () {
      print('Permission has been denied');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        return ScreenUtilInit(
            designSize: const Size(400, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return SafeArea(
                  child: GestureDetector(
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: Scaffold(
                          backgroundColor: const Color(0xff007CC7),
                          body: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                Container(
                                    height: 460.h,
                                    child: Column(children: [
                                      Container(
                                        child: CustomPaint(
                                          painter: CurvePainter(true),
                                          child: Container(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0),
                                              child: Center(
                                                child: SingleChildScrollView(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                      horizontal: 32.w,
                                                      vertical: 36.h,
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Welcome to",
                                                          style: TextStyle(
                                                            fontSize: 30.sp,
                                                            color: Color(
                                                                0xff4DA8DA),
                                                            height: 0.2.h,
                                                          ),
                                                          textScaleFactor: 1.0,
                                                        ),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        Container(
                                                          child: Text(
                                                            "The eventors",
                                                            style: TextStyle(
                                                                fontSize: 60.sp,
                                                                color: Color(
                                                                    0xff4DA8DA),
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                letterSpacing:
                                                                    2,
                                                                height: 0.5.h),
                                                            textScaleFactor:
                                                                1.0,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        Text(
                                                          "Please login to continue",
                                                          style: TextStyle(
                                                              fontSize: 20.sp,
                                                              color: Color(
                                                                  0xff4DA8DA),
                                                              height: 0.1.h),
                                                        ),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        Form(
                                                            key: _formKey,
                                                            child: Column(
                                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .stretch,
                                                                children: <
                                                                    Widget>[
                                                                  TextFormField(
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xFF12232E)),
                                                                    cursorColor:
                                                                        const Color(
                                                                            0xFF12232E),
                                                                    controller:
                                                                        usernameController,
                                                                    validator:
                                                                        (String?
                                                                            value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return "Please enter your username";
                                                                      }
                                                                    },
                                                                    decoration: InputDecoration(
                                                                        hintText: "@username",
                                                                        hintStyle: TextStyle(
                                                                          fontSize:
                                                                              16.sp,
                                                                          color:
                                                                              Color(0x4012232E),
                                                                          fontWeight:
                                                                              FontWeight.bold,
                                                                        ),
                                                                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                                                                        filled: true,
                                                                        fillColor: const Color(0xFFEEFBFB),
                                                                        errorStyle: TextStyle(fontSize: 16.sp),
                                                                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0)),
                                                                  ),
                                                                  if (error !=
                                                                      null)
                                                                    if (error
                                                                        .startsWith(
                                                                            "User"))
                                                                      Container(
                                                                          padding: EdgeInsets.only(
                                                                              top:
                                                                                  5,
                                                                              bottom:
                                                                                  5),
                                                                          margin:
                                                                              EdgeInsets.only(right: (MediaQuery.of(context).size.width * 0.3).w),
                                                                          child: Text(
                                                                            error,
                                                                            style:
                                                                                TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
                                                                          )),
                                                                  SizedBox(
                                                                    height:
                                                                        20.h,
                                                                  ),
                                                                  TextFormField(
                                                                    style: const TextStyle(
                                                                        color: Color(
                                                                            0xFF12232E)),
                                                                    cursorColor:
                                                                        const Color(
                                                                            0xFF12232E),
                                                                    controller:
                                                                        passwordController,
                                                                    validator:
                                                                        (String?
                                                                            value) {
                                                                      if (value!
                                                                          .isEmpty) {
                                                                        return "Please enter your password";
                                                                      }
                                                                    },
                                                                    obscureText:
                                                                        !_passwordVisible,
                                                                    decoration:
                                                                        InputDecoration(
                                                                      hintText:
                                                                          'Password',
                                                                      suffixIcon:
                                                                          IconButton(
                                                                        icon:
                                                                            Icon(
                                                                          // Based on passwordVisible state choose the icon
                                                                          _passwordVisible
                                                                              ? Icons.visibility
                                                                              : Icons.visibility_off,
                                                                          color:
                                                                              Color(0xFF12232E),
                                                                        ),
                                                                        onPressed:
                                                                            () {
                                                                          // Update the state i.e. toogle the state of passwordVisible variable
                                                                          setState(
                                                                              () {
                                                                            _passwordVisible =
                                                                                !_passwordVisible;
                                                                          });
                                                                        },
                                                                      ),
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            16.sp,
                                                                        color: Color(
                                                                            0x4012232E),
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(25),
                                                                        borderSide:
                                                                            const BorderSide(
                                                                          width:
                                                                              0,
                                                                          style:
                                                                              BorderStyle.none,
                                                                        ),
                                                                      ),
                                                                      filled:
                                                                          true,
                                                                      fillColor:
                                                                          const Color(
                                                                              0xFFEEFBFB),
                                                                      contentPadding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              16,
                                                                          vertical:
                                                                              0),
                                                                    ),
                                                                  ),
                                                                  if (error !=
                                                                      null)
                                                                    if (error
                                                                        .startsWith(
                                                                            "Pass"))
                                                                      Container(
                                                                          padding: EdgeInsets.only(
                                                                              top:
                                                                                  5,
                                                                              bottom:
                                                                                  5),
                                                                          margin:
                                                                              EdgeInsets.only(right: (MediaQuery.of(context).size.width * 0.3).w),
                                                                          child: Text(
                                                                            error,
                                                                            style:
                                                                                TextStyle(color: Colors.red, fontWeight: FontWeight.w400),
                                                                          )),
                                                                ])),
                                                        SizedBox(
                                                          height: 20.h,
                                                        ),
                                                        Container(
                                                            height: 40.h,
                                                            decoration:
                                                                BoxDecoration(
                                                                    gradient:
                                                                        const LinearGradient(
                                                                      begin: Alignment
                                                                          .topRight,
                                                                      end: Alignment
                                                                          .bottomLeft,
                                                                      colors: [
                                                                        Color(
                                                                            0xff4DA8DA),
                                                                        Color(
                                                                            0xff007CC7),
                                                                      ],
                                                                    ),
                                                                    borderRadius: const BorderRadius
                                                                            .all(
                                                                        Radius.circular(
                                                                            25)),
                                                                    boxShadow: [
                                                                  BoxShadow(
                                                                    color: const Color(
                                                                            0xFF1C1C1C)
                                                                        .withOpacity(
                                                                            0.2),
                                                                    spreadRadius:
                                                                        3,
                                                                    blurRadius:
                                                                        4,
                                                                    offset:
                                                                        const Offset(
                                                                            0,
                                                                            3),
                                                                  )
                                                                ]),
                                                            child:
                                                                MaterialButton(
                                                              onPressed: () {
                                                                FocusManager
                                                                    .instance
                                                                    .primaryFocus
                                                                    ?.unfocus();
                                                                if (_formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                                  Provider.of<UserProvider>(
                                                                          context,
                                                                          listen:
                                                                              false)
                                                                      .login(
                                                                          usernameController
                                                                              .text,
                                                                          passwordController
                                                                              .text);
                                                                  Future.delayed(
                                                                      Duration(
                                                                          milliseconds:
                                                                              1000),
                                                                      () {
                                                                    setState(
                                                                        () {
                                                                      error = context
                                                                          .read<
                                                                              UserProvider>()
                                                                          .error;
                                                                    });
                                                                    print(
                                                                        error);
                                                                    if (error ==
                                                                        null) {
                                                                      Navigator.of(
                                                                              context)
                                                                          .push(MaterialPageRoute(
                                                                              builder: (context) =>
                                                                                  const HomeScreen()))
                                                                          .then((value) =>
                                                                              {
                                                                                setState(
                                                                                  () {},
                                                                                )
                                                                              });
                                                                    }
                                                                  });
                                                                }
                                                              },
                                                              child: Center(
                                                                child: Text(
                                                                  "Login",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          24.sp,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Color(
                                                                          0xFFEEFBFB)),
                                                                ),
                                                              ),
                                                            )),
                                                        SizedBox(
                                                          height: 16.h,
                                                        ),
                                                        InkWell(
                                                            onTap: () => Navigator
                                                                    .of(context)
                                                                .push(MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            const ForgotPasswordScreen())),
                                                            child: Text(
                                                                "Forgot password?",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      18.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Color(
                                                                      0xff4DA8DA),
                                                                ),
                                                                textScaleFactor:
                                                                    1.0)),
                                                      ],
                                                    )),
                                              )),
                                        ),
                                      ),
                                    ])),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 32.w, vertical: 16.h),
                                    child: SignupButton()),
                              ])))));
            });
      },
    );
    /*return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SafeArea(
                  child: GestureDetector(
                      onTap: () =>
                          FocusManager.instance.primaryFocus?.unfocus(),
                      child: Scaffold(
                          backgroundColor: const Color(0xff007CC7),
                          body: SingleChildScrollView(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                height: 70.h,
                                child: CustomPaint(
                                  painter: CurvePainter(true),
                                  child: Container(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: const Center(
                                        child: SingleChildScrollView(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 32,
                                              vertical: 16,
                                            ),
                                            child: Login()),
                                      )),
                                ),
                              ),
                              /* Container(
                                height: 30.h,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                child: const SignupButton(),
                              ),*/
                            ],
                          ))))));
        });*/
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
