import 'package:dhatnoon/features/home/presentation/widgets/header_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitialHomePage extends StatelessWidget {
  const InitialHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = Get.height;
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),
          SizedBox(
            height: screenHeight - screenHeight / 8,
            child: Center(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: 256,
                    width: 256,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/home/initial_home_page.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: const Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Send ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: 'invite',
                              style: TextStyle(
                                color: Color(0xFF00B09C),
                                fontSize: 25,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            TextSpan(
                              text: ' to your contacts',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
