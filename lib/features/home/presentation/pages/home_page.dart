import 'package:dhatnoon/common/header_widget.dart';
import 'package:dhatnoon/features/home/data/all_user_data.dart';
import 'package:dhatnoon/features/home/presentation/widgets/user_information_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final AllUserData _allUserData = AllUserData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const HeaderWidget(),


          
          ElevatedButton(
              onPressed: () {
                Get.toNamed('/back_camera_live_stream');
              },
              child: const Text("AGORA")),


          Expanded(
            child: FutureBuilder(
              future: _allUserData.getAllUsersExceptLoggedIn(),
              builder: (context,
                  AsyncSnapshot<List<Map<String, String?>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<Map<String, String?>> userData = snapshot.data!;
                  return ListView.builder(
                    itemCount: userData.length,
                    itemBuilder: (context, index) {
                      final user = userData[index];
                      return Column(
                        children: [
                          UserInformationWidget(
                            userName: user['userName'] ?? '',
                            imageUrl: user['imageUrl'] ?? '',
                            actionText: user['actionText'] ?? '',
                            user2: user['user2'] ?? '',
                            context: context,
                          ),
                          const SizedBox(height: 3),
                        ],
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
