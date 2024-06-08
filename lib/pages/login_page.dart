// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;

  Future<void> loginRequest(username, password, BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    final SharedPreferences localStorage =
        await SharedPreferences.getInstance();
    final String apiUrl =
        'https://accounts.steyp.com/api/v1/users/login/chief/'; // Replace with your API URL

    try {
      final response = await http.post(Uri.parse(apiUrl), body: {
        'username': username,
        'password': password,
        'service': 'learn'
      });

      if (response.statusCode == 200) {
        // Successful request
        final data = json.decode(response.body);
        if (data['StatusCode'] == 6000) {
          await localStorage.setString(
              'access_token', data['data']['access_token']);

          Navigator.pushReplacementNamed(context, '/home');
        } else {
          String message = data['data']['message'];
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${message}')));
          setState(() {
            _isLoading = false;
          });
        }
        // Process the data as needed
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('${response.statusCode}--${response.body}')));
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e}')));
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController usernamecontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    return Scaffold(
      body: Center(
          child: _isLoading
              ? CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: usernamecontroller,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: passwordcontroller,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        width: 300,
                        child: TextButton(
                          onPressed: () {
                            loginRequest(usernamecontroller.text.toString(),
                                passwordcontroller.text.toString(), context);
                          },
                          child: Text('Login'),
                        )),
                  ],
                )),
    );
  }
}
