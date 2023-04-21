import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/colors/hex_color.dart';
import '../../core/fade_animation.dart';

enum FormData { Name, Email, Password, ConfirmPassword }

class RegisterWidget extends StatefulWidget {
  final VoidCallback onClickedLogin;

  const RegisterWidget({super.key, required this.onClickedLogin});

  @override
  State<StatefulWidget> createState() => _RegisterWidgetState();
}

class _RegisterWidgetState extends State<RegisterWidget> {
  Color enabled = const Color.fromARGB(255, 63, 56, 89);
  Color enabledTxt = Colors.white;
  Color disable = Colors.grey;
  Color error = Colors.red;
  Color backgroundColor = const Color(0xFF1F1A30);
  bool isPasswordHidden = true;
  bool isRePasswordHidden = true;
  bool _loading = false;

  FormData? selected;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey,
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
                        FadeAnimation(
                          delay: 1,
                          child: Container(
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.9),
                                  letterSpacing: 0.5,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextFormField(
                            controller: nameController,
                            onTap: () {
                              setState(() {
                                selected = FormData.Name;
                              });
                            },
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13.0),
                                  borderSide: const BorderSide(width: 0)),
                              filled: true,
                              fillColor: selected == FormData.Name
                                  ? enabled
                                  : backgroundColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(13.0)),
                              prefixIcon: Icon(
                                Icons.email_outlined,
                                color: selected == FormData.Name
                                    ? enabledTxt
                                    : disable,
                                size: 20,
                              ),
                              hintText: 'Full name',
                              hintStyle: TextStyle(
                                  color: selected == FormData.Name
                                      ? enabledTxt
                                      : disable,
                                  fontSize: 12),
                            ),
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: selected == FormData.Name
                                    ? enabledTxt
                                    : disable,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (name) => name != null && name == ""
                                ? 'Please input a full name'
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextFormField(
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
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (email) =>
                                email != null && !EmailValidator.validate(email)
                                    ? 'Please input a valid email'
                                    : null,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextFormField(
                            controller: passwordController,
                            onTap: () {
                              setState(() {
                                selected = FormData.Password;
                              });
                            },
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13.0),
                                    borderSide: const BorderSide(width: 0)),
                                filled: true,
                                fillColor: selected == FormData.Password
                                    ? enabled
                                    : backgroundColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13.0)),
                                prefixIcon: Icon(
                                  Icons.lock_open_outlined,
                                  color: selected == FormData.Password
                                      ? enabledTxt
                                      : disable,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                  icon: isPasswordHidden
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: selected == FormData.Password
                                              ? enabledTxt
                                              : disable,
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: selected == FormData.Password
                                              ? enabledTxt
                                              : disable,
                                          size: 20,
                                        ),
                                  onPressed: () => setState(() =>
                                      isPasswordHidden = !isPasswordHidden),
                                ),
                                hintText: 'Password',
                                hintStyle: TextStyle(
                                    color: selected == FormData.Password
                                        ? enabledTxt
                                        : disable,
                                    fontSize: 12)),
                            obscureText: isPasswordHidden,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: selected == FormData.Password
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
                          child: TextFormField(
                            controller: confirmPasswordController,
                            onTap: () {
                              setState(() {
                                selected = FormData.ConfirmPassword;
                              });
                            },
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13.0),
                                    borderSide: const BorderSide(width: 0)),
                                filled: true,
                                fillColor: selected == FormData.ConfirmPassword
                                    ? enabled
                                    : backgroundColor,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(13.0)),
                                prefixIcon: Icon(
                                  Icons.lock_open_outlined,
                                  color: selected == FormData.ConfirmPassword
                                      ? enabledTxt
                                      : disable,
                                  size: 20,
                                ),
                                suffixIcon: IconButton(
                                  icon: isRePasswordHidden
                                      ? Icon(
                                          Icons.visibility_off,
                                          color: selected ==
                                                  FormData.ConfirmPassword
                                              ? enabledTxt
                                              : disable,
                                          size: 20,
                                        )
                                      : Icon(
                                          Icons.visibility,
                                          color: selected ==
                                                  FormData.ConfirmPassword
                                              ? enabledTxt
                                              : disable,
                                          size: 20,
                                        ),
                                  onPressed: () => setState(() =>
                                      isRePasswordHidden = !isRePasswordHidden),
                                ),
                                hintText: 'Confirm Password',
                                hintStyle: TextStyle(
                                    color: selected == FormData.ConfirmPassword
                                        ? enabledTxt
                                        : disable,
                                    fontSize: 12)),
                            obscureText: isRePasswordHidden,
                            textAlignVertical: TextAlignVertical.center,
                            style: TextStyle(
                                color: selected == FormData.ConfirmPassword
                                    ? enabledTxt
                                    : disable,
                                fontWeight: FontWeight.bold,
                                fontSize: 12),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (password) => password != null &&
                                    password != passwordController.text
                                ? "Confirm password not correct"
                                : null,
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        FadeAnimation(
                          delay: 1,
                          child: TextButton(
                              onPressed: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                try {
                                  setState(() {
                                    _loading = true;
                                  });
                                  UserCredential credential = await FirebaseAuth
                                      .instance
                                      .createUserWithEmailAndPassword(
                                          email: emailController.text.trim(),
                                          password:
                                              passwordController.text.trim());
                                  await credential.user
                                      ?.updateDisplayName(nameController.text);
                                } on FirebaseAuthException {
                                  AnimatedSnackBar.material(
                                    "Sign up failed",
                                    type: AnimatedSnackBarType.error,
                                  ).show(context);
                                }
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
                                      "Đăng ký",
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
                  height: 20,
                ),

                FadeAnimation(
                  delay: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text("Đã có tài khoản? ",
                          style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 0.5,
                          )),
                      GestureDetector(
                        onTap: widget.onClickedLogin,
                        child: Text("Đăng nhập",
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
    ));
  }
}
