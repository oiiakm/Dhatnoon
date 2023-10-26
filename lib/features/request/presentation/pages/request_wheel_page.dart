import 'package:dhatnoon/common/header_widget.dart';
import 'package:dhatnoon/features/request/domain/request_controller.dart';
import 'package:dhatnoon/features/request/presentation/widgets/request_widget.dart';
import 'package:flutter/material.dart';

class RequestWheelPage extends StatefulWidget {
  const RequestWheelPage({Key? key}) : super(key: key);

  @override
  State<RequestWheelPage> createState() => _RequestWheelPageState();
}

class _RequestWheelPageState extends State<RequestWheelPage> {
  RequestController controller1 = RequestController();
  RequestController controller2 = RequestController();
  RequestController controller3 = RequestController();
  RequestController controller4 = RequestController();
  RequestController controller5 = RequestController();
  RequestController controller6 = RequestController();
  RequestController controller7 = RequestController();
  RequestController controller8 = RequestController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          const HeaderWidget(),
          const SizedBox(
            height: 150,
          ),
          const Text(
            'Select your choice',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: ListWheelScrollView(
              itemExtent: 80,
              children: <Widget>[
                RequestWidget(
                  name: 'Live Location',
                  icon: const Icon(Icons.camera_alt),
                  controller: controller1,
                ),
                RequestWidget(
                  name: 'Front Camera Pic',
                  icon: const Icon(Icons.camera_front),
                  controller: controller2,
                ),
                RequestWidget(
                  name: 'Back Camera Pic',
                  icon: const Icon(Icons.photo_camera_back),
                  controller: controller3,
                ),
                RequestWidget(
                  name: 'Front Camera 10 sec Video Clip',
                  icon: const Icon(Icons.video_camera_front),
                  controller: controller4,
                ),
                RequestWidget(
                  name: 'Back Camera 10 sec Video Clip',
                  icon: const Icon(Icons.video_camera_back),
                  controller: controller5,
                ),
                RequestWidget(
                  name: 'Front Camera Live Streaming',
                  icon: const Icon(Icons.live_tv_sharp),
                  controller: controller6,
                ),
                RequestWidget(
                  name: 'Back Camera Live Streaming',
                  icon: const Icon(Icons.live_tv_sharp),
                  controller: controller7,
                ),
                RequestWidget(
                  name: 'Live Audio Streaming',
                  icon: const Icon(Icons.live_tv_sharp),
                  controller: controller8,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


