import 'package:dhatnoon/features/home/presentation/widgets/header_widget.dart';
import 'package:dhatnoon/features/home/presentation/widgets/user_information_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<Map<String, String?>> userData = [
    {
      'userName': 'Elon Musk',
      'imageUrl':
          'https://futureoflife.org/wp-content/uploads/2020/08/elon_musk_royal_society.jpg',
      'actionText': 'Send Request',
    },
    {
      'userName': 'SRK',
      'imageUrl':
          'https://i0.wp.com/www.smartprix.com/bytes/wp-content/uploads/2023/05/2-photoutils.com_.jpg?ssl=1&quality=80&w=f',
      'actionText': 'Hurray Fetch Now',
    },
    {
      'userName': 'Priyanka',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTH7yhoFvoYr1nE67Zigq5mMkAt6Pb0bImrL44qEgsRyZSUvFyoQv-ST4DNe0Tbz6Gc-dI&usqp=CAU',
      'actionText':
          'Requested Audio clip Duration 10 sec Time 1.22 PM to 1.55 PM',
    },
    {
      'userName': 'Deepika',
      'imageUrl':
          'https://media5.bollywoodhungama.in/wp-content/uploads/2021/09/a1c30f8d-2f66-4dca-8bf0-20d7412629a0.jpg',
      'actionText': 'Approved Just, 1:02 Min TO GO!',
    },
    {
      'userName': 'Zeb Besos',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_UrA4irBaYHfP34Alwxbwatn6caKfQJVG9uUaexDNKA&s',
      'actionText': 'Declined Request',
    },
    {
      'userName': 'Ashneer',
      'imageUrl':
          'https://assets.gqindia.com/photos/620e01e118140d747a9b0a1a/16:9/w_1920,c_limit/Ashneer-Grover%20(1).jpg',
      'actionText': 'Still Pending, Remind again?',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const HeaderWidget(),
        Expanded(
          child: ListView.builder(
            itemCount: userData.length,
            itemBuilder: (context, index) {
              final user = userData[index];
              return Column(
                children: [
                  UserInformationWidget(
                    userName: user['userName'] ?? '',
                    imageUrl: user['imageUrl'] ?? '',
                    actionText: user['actionText'] ?? '',
                  ),
                  const SizedBox(height: 3),
                ],
              );
            },
          ),
        ),
      ]),
    );
  }
}
