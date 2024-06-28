import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPharmacist = false; // Added variable to track user type

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Login as: '),
                DropdownButton<bool>(
                  value: _isPharmacist,
                  items: [
                    DropdownMenuItem(
                      child: Text('User'),
                      value: false,
                    ),
                    DropdownMenuItem(
                      child: Text('Pharmacist'),
                      value: true,
                    ),
                  ],
                  onChanged: (bool? value) {
                    setState(() {
                      _isPharmacist = value!;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await authService.signInWithEmail(
                    _emailController.text, _passwordController.text);
                if (authService.currentUser != null) {
                  Navigator.pushReplacementNamed(
                    context,
                    _isPharmacist ? '/pharmacist_home' : '/user_home',
                  );
                }
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}
