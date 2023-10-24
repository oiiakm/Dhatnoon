import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Color(0xFF232D36),
      ),
    );

    return SizedBox(
      width: screenWidth,
      height: screenHeight / 8,
      child: Stack(
        children: [
          Container(
            width: screenWidth,
            decoration: const BoxDecoration(
              color: Color(0xFF232D36),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0x3F000000),
                  blurRadius: 20,
                  offset: Offset(0, 4),
                  spreadRadius: 4,
                ),
              ],
            ),
          ),
          const Positioned(
            left: 16,
            top: 75,
            child: Text(
              'Dhatnoon',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
              left: 360,
              top: 75,
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.camera_alt,
                  color: Colors.white,
                ),
              )),
          Positioned(
              left: 410,
              top: 75,
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              )),
          Positioned(
              left: 460,
              top: 75,
              child: GestureDetector(
                onDoubleTap: () {},
                child: const Icon(
                  Icons.more_vert_outlined,
                  color: Colors.white,
                ),
              )),
        ],
      ),
    );
  }
}
