import 'package:dhatnoon/common/snackbar.dart';
import 'package:dhatnoon/features/auth/data/firestore.dart';
import 'package:dhatnoon/features/auth/domain/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtpPage extends StatefulWidget {
  final String verificationId;

  final String mobile;

  const OtpPage({
    Key? key,
    required this.verificationId,
    required this.mobile,
  }) : super(key: key);

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final FirestoreService _users = FirestoreService();
  final AuthService _auth = AuthService();
  List<TextEditingController> otpControllers =
      List.generate(6, (index) => TextEditingController());

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter your OTP',
                  style: TextStyle(
                    color: const Color(0xFF5C5C5C),
                    fontSize: ScreenUtil().setSp(20),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Text(
                  'Please enter the 6 digits OTP sent \non your mobile number',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF00ABAB),
                    fontSize: ScreenUtil().setSp(16),
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Container(
                      width: ScreenUtil().setWidth(40),
                      height: ScreenUtil().setHeight(50),
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(6)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x19000000),
                            blurRadius: ScreenUtil().setWidth(30),
                            offset: Offset(0, ScreenUtil().setWidth(4)),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: TextField(
                        controller: otpControllers[index],
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        maxLength: 1,
                        style: TextStyle(
                          color: const Color(0xFF444444),
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: const InputDecoration(
                          counterText: "",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          } else if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: ScreenUtil().setSp(4)),
                    GestureDetector(
                      onTap: () {
                        _resendOTP();
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Didn’t receive code? ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Request again',
                              style: TextStyle(
                                color: const Color(0xFF00ABAB),
                                fontSize: ScreenUtil().setSp(10),
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                ElevatedButton(
                  onPressed: () {
                    String otp = otpControllers
                        .map((controller) => controller.text)
                        .join();

                    _verifyOTP(otp);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00ABAB),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(10)),
                    ),
                  ),
                  child: Text(
                    'Verify and Create',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(19),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _verifyOTP(String otp) async {
    try {
      _auth.verifyOTP(
        widget.verificationId,
        otp,
        () async {
          await _users.addUserDetail(widget.mobile);
        },
        (FirebaseAuthException e) {
          print("Error during OTP verification: $e");
          if (e.code == 'session-expired') {
            showSnackbar('','Resend OTP time exceed');
          } else {
            showSnackbar('','Please enter valid OTP');
          }
        },
      );
    } catch (e) {
      print("Error: $e");
    }
  }

  void _resendOTP() {
    Get.toNamed('/auth');
  }
}
