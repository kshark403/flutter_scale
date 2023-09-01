// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_scale/services/rest_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // สร้าง key สำหรับ form
  final formKey = GlobalKey<FormState>();

  // สร้างตัวแปรไว้เก็บค่า username และ password
  late String _username, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 180,
                  ),
                  Image.asset(
                    'assets/images/mylogo.png',
                    height: 150,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    // width: 250,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกชื่อผู้ใช้งาน';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _username = value!.toString().trim();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    // width: 250,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'กรุณากรอกรหัสผ่าน';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value!.toString().trim();
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        // ตรวจสอบค่าจาก form
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          // print('Username: $_username');
                          // print('Password: $_password');
                          // เรียกใช้งาน API login
                          var response = await CallAPI().loginAPI({
                            'username': _username,
                            'password': _password,
                          });

                          var body = jsonDecode(response.body);

                          // print(body);

                          if (body['status'] == 'success') {
                            // Create shared preference object
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();

                            // Save user data to shared preference
                            prefs.setString('userID', body['data']['id']);
                            prefs.setString(
                                'userName', body['data']['username']);
                            prefs.setString(
                                'fullName',
                                body['data']['name'] +
                                    ' ' +
                                    body['data']['surname']);
                            prefs.setString(
                                'imgProfile', body['data']['img_profile']);
                            prefs.setString('email', body['data']['email']);
                            prefs.setInt('step', 2);

                            Navigator.pushReplacementNamed(
                                context, '/dashboard');
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Center(child: Text(body['message'])),
                              backgroundColor: Colors.red,
                            ));
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5))),
                      child: Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
