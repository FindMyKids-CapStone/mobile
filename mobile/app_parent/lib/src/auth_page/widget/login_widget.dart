import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:app_parent/src/forgot_password_page/forgot_password_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller.dart';
import '../../core/colors/hex_color.dart';
import '../../core/fade_animation.dart';

enum FormData {
  Email,
  password,
}

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedRegister;

  const LoginWidget({super.key, required this.onClickedRegister});

  @override
  State<StatefulWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledTxt = Colors.white;
  Color disable = Colors.grey;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool isPasswordHidden = true;
  FormData? selected;
  bool _loading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthController _authController = Get.put(AuthController());

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.4, 0.7, 0.9],
            colors: [
              HexColor("#4b4293").withOpacity(0.8),
              HexColor("#4b4293"),
              HexColor("#08418e"),
              HexColor("#08418e")
            ],
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                HexColor("#fff").withOpacity(0.2), BlendMode.dstATop),
            image: const AssetImage("assets/img/image-maps.jpg"),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  color:
                      const Color.fromARGB(255, 171, 211, 250).withOpacity(0.4),
                  child: Container(
                    width: 400,
                    padding: const EdgeInsets.all(40.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeAnimation(
                          delay: 0.8,
                          child: Container(
                              width: 200,
                              height: 100,
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(90))),
                              child: Image.asset(
                                "assets/img/zenly.webp",
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const FadeAnimation(
                          delay: 1,
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 0.5,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextField(
                            controller: emailController,
                            onTap: () {
                              setState(() {
                                selected = FormData.Email;
                              });
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                  borderSide: const BorderSide(width: 0)),
                              filled: true,
                              fillColor: selected == FormData.Email
                                  ? enabled
                                  : backgroundColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13.0)),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: selected == FormData.Email
                                    ? enabledTxt
                                    : disable,
                                size: 20,
                              ),
                              hintText: 'Email',
                              hintStyle: TextStyle(
                                  color: selected == FormData.Email
                                      ? enabledTxt
                                      : disable,
                                  fontSize: 12),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: selected == FormData.Email
                                    ? enabledTxt
                                    : disable,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextField(
                            controller: passwordController,
                            onTap: () {
                              setState(() {
                                selected = FormData.password;
                              });
                            },
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13.0),
                                    borderSide: const BorderSide(width: 0)),
                                filled: true,
                                fillColor: selected == FormData.password
                                    ? enabled
                                    : backgroundColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13.0)),
                                prefixIcon: Icon(
                                  Icons.lock_open_outlined,
                                  color: selected == FormData.password
                                      ? enabledTxt
                                      : disable,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                  icon: isPasswordHidden
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: selected == FormData.password
                                              ? enabledTxt
                                              : disable,
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: selected == FormData.password
                                              ? enabledTxt
                                              : disable,
                                          size: 20,
                                        ),
                                  onPressed: () => setState(() =>
                                      isPasswordHidden = !isPasswordHidden),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: selected == FormData.password
                                        ? enabledTxt
                                        : disable,
                                    fontSize: 12)),
                            obscureText: isPasswordHidden,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: selected == FormData.password
                                    ? enabledTxt
                                    : disable,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                setState(() {
                                  _loading = true;
                                });
                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim());
                                } on FirebaseAuthException catch (e) {
                                  AnimatedSnackBar.material(
                                    e.message ?? "",
                                    type: AnimatedSnackBarType.error,
                                  ).show(context);
                                }
                                setState(() {
                                  _loading = false;
                                });
                              },
                              style: TextButton.styleFrom(
                                  backgroundColor: const Color(0xFF2697FF),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 14.0, horizontal: 80),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(12.0))),
                              child: _loading
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ))
                                  : const Text(
                                      "Login",
                                      style: TextStyle(
                                        color: Colors.white,
                                        letterSpacing: 0.5,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )),
                        ),
                      ],
                    ),
                  ),
                ),

                //End of Center Card
                //Start of outer card
                const SizedBox(
                  height: 10,
                ),
                FadeAnimation(
                  delay: 1,
                  child: GestureDetector(
                    onTap: (() {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return const ForgotPasswordPage();
                      }));
                    }),
                    child: Text("Forgot Password?",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          letterSpacing: 0.5,
                        )),
                  ),
                ),
                const SizedBox(height: 10),
                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Don't have a account? ",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: widget.onClickedRegister,
                        child: Text("Sign up",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
