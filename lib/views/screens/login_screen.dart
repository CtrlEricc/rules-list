import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rules/constants.dart';

import '../../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController _loginController = Get.put(LoginController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/login_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.35),
                BlendMode.dstATop,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo.png',
                    width: 60, fit: BoxFit.contain),
                const SizedBox(height: 30.0),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          style: const TextStyle(
                            color: orange_500,
                          ),
                          controller: _emailController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: orange_50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'email',
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          style: const TextStyle(
                            color: orange_500,
                          ),
                          controller: _passwordController,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: orange_50,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: BorderSide.none,
                            ),
                            hintText: 'password',
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                Obx(
                  () => ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: orange_700,
                        padding: const EdgeInsets.symmetric(horizontal: 50.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _loginController.loginWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);
                      }
                    },
                    child: _loginController.loading
                        ? const SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                                color: Colors.white, strokeWidth: 3))
                        : const Text('login'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
