import 'package:flutter/material.dart';
import 'package:seller_app/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 10,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset("images/seller.png", height: 270,),
            ),
          ),
          Form(key: _formKey, child: Column(
            children: [
              CustomTextField(
                data: Icons.email,
                controller: emailController,
                hintText: 'Email',
                isObscure: false,
              ),
              CustomTextField(
                data: Icons.lock,
                controller: passwordController,
                hintText: 'Password',
                isObscure: true,
              ),
            ],
          )),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20)
            ),
            child: const Text(
              'Login',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
