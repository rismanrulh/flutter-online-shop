import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shamo/theme.dart';
import 'package:shamo/widget/loading_button.dart';

import '../providers/auth_provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController(text: '');

  TextEditingController passwordController = TextEditingController(text: '');

  bool isLoading = false;

  Widget header() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Login',
            style:
                primaryTextStyle.copyWith(fontSize: 24, fontWeight: semiBold),
          ),
          const SizedBox(
            height: 2,
          ),
          Text(
            'Sign In to Continue',
            style: subTitleTextStyle,
          ),
        ],
      ),
    );
  }

  Widget emailInput() {
    return Container(
      margin: const EdgeInsets.only(top: 70),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email Address',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_email.png',
                    width: 17,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  //expanded agar lebar text sesuai denga lebar yg tersisa
                  Expanded(
                    child: TextFormField(
                      controller: emailController,
                      style: primaryTextStyle,
                      decoration: InputDecoration.collapsed(
                          hintText: 'Your Email Address',
                          hintStyle: subTitleTextStyle),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget passwordInput() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: backgroundColor2,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Row(
                children: [
                  Image.asset(
                    'assets/icon_password.png',
                    width: 17,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  //expanded agar lebar text sesuai denga lebar yg tersisa
                  Expanded(
                    child: TextFormField(
                      controller: passwordController,
                      style: primaryTextStyle,
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                        hintText: 'Your Password',
                        hintStyle: subTitleTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget signInButton(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    handleSignIn() async {
      setState(() {
        isLoading = true;
      });

      if (await authProvider.login(
        email: emailController.text,
        password: passwordController.text,
      )) {
        // ignore: use_build_context_synchronously
        Navigator.pushNamed(context, '/home');
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: alertColor,
            content: const Text(
              'Login Gagal!',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
      setState(() {
        isLoading = false;
      });
    }

    return Container(
      height: 50,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      child: TextButton(
        onPressed: handleSignIn,
        style: TextButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          'Sign In',
          style: primaryTextStyle.copyWith(fontSize: 16, fontWeight: medium),
        ),
      ),
    );
  }

  Widget footer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 30),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Don\'t have an account? ',
          style: subTitleTextStyle.copyWith(
            fontSize: 12,
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/sign-up');
          },
          child: Text(
            'Sign Up',
            style: purpleTextStyle.copyWith(
              fontSize: 12,
              fontWeight: medium,
            ),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor1,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            header(),
            emailInput(),
            passwordInput(),
            isLoading ? const LoadingButton() : signInButton(context),
            const Spacer(),
            footer(context)
          ]),
        ),
      ),
    );
  }
}
