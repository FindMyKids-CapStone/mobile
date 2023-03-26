import 'package:app_parent/src/auth_page/widget/login_widget.dart';
import 'package:app_parent/src/auth_page/widget/register_widget.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? LoginWidget(onClickedRegister: toggle)
      : RegisterWidget(onClickedLogin: toggle);
  void toggle() => setState(() => isLogin = !isLogin);
}
