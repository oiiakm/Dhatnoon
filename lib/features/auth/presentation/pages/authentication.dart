import 'package:dhatnoon/common/snackbar.dart';
import 'package:dhatnoon/features/auth/domain/auth.dart';
import 'package:dhatnoon/features/auth/presentation/pages/otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({
    super.key,
  });

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final TextEditingController phoneNumberController = TextEditingController();
  bool agreedToTerms = true;
  final AuthService _auth = AuthService();

  @override
  void dispose() {
    phoneNumberController.dispose();
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
      body: Stack(
        children: [
          SizedBox(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setWidth(100),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(ScreenUtil().setWidth(60)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x11000000),
                            blurRadius: ScreenUtil().setWidth(28),
                            offset: Offset(0, ScreenUtil().setWidth(4)),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                    ),
                    Icon(
                      Icons.person,
                      size: ScreenUtil().setWidth(59),
                      weight: ScreenUtil().setWidth(59),
                    ),
                  ],
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Container(
                  width: ScreenUtil().setWidth(320),
                  height: ScreenUtil().setHeight(50),
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
                  child: Center(
                    child: TextField(
                      controller: phoneNumberController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Enter your phone number',
                      ),
                      style: TextStyle(
                        color: const Color(0xFF444444),
                        fontSize: ScreenUtil().setSp(12),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: ScreenUtil().setSp(10),
                      height: ScreenUtil().setSp(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.help,
                          color: Colors.black,
                          size: ScreenUtil().setSp(8),
                        ),
                      ),
                    ),
                    SizedBox(width: ScreenUtil().setSp(4)),
                    GestureDetector(
                      onTap: () {
                        //terms and condition

                        print("Terms & Conditions tapped");
                      },
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'By registering, I agree to ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(10),
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms & Conditions',
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
                  onPressed: () async {
                    String phoneNumber = "+91${phoneNumberController.text}";
                    print("Agreed to Terms: $agreedToTerms");
                    _validateField(phoneNumber);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00ABAB),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(ScreenUtil().setWidth(10)),
                    ),
                  ),
                  child: Text(
                    'Sign In',
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

  void _validateField(String phoneNumber) {
    if (phoneNumber == '') {
     showSnackbar('','Please enter your name and mobile number');
    } else if (phoneNumber == '+91' ||
        phoneNumberController.text.length != 10) {
     showSnackbar('','Please enter your 10 digit mobile number');
    } else {
      _sendOTP(phoneNumber);
    }
  }

  void _sendOTP(String phoneNumber) {
    _auth.sendOTP(phoneNumber, (verificationId) {
      Get.offAll(
          () => OtpPage(verificationId: verificationId, mobile: phoneNumber));
    }, (e) {
      print('Verification failed: ${e.code} - ${e.message}');
    });
  }
}
