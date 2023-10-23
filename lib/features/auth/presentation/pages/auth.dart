import 'package:flutter/material.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Mobile Number',
              ),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              child: Text('Login/Signup'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Forgot Password?'),
              onPressed: () {},
            ),
            TextButton.icon(
              icon: Icon(Icons.account_circle),
              label: Text('Login with Google'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}