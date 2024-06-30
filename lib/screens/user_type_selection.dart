import 'package:flutter/material.dart';

class UserTypeSelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose User Type'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/user_home');
              },
              child: Text('User'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/pharmacist_home');
              },
              child: Text('Pharmacist'),
            ),
          ],
        ),
      ),
    );
  }
}
