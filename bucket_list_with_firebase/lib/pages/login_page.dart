import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../service/auth_service.dart';
import 'home_page.dart';

/// 로그인 페이지
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("로그인")),
      body: _LoginBody(),
    );
  }
}

final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();

class _LoginBody extends StatelessWidget {
  _LoginBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeaderText(),
          SizedBox(height: 32),
          _EmailField(),
          _PasswordField(),
          SizedBox(height: 32),
          _LoginButton(),
          SizedBox(height: 20),
          _SignUpButton(),
        ],
      ),
    );
  }
}

/// 상단 텍스트
class _HeaderText extends StatelessWidget {
  const _HeaderText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "로그인해 주세요 🙂",
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }
}

/// 이메일
class _PasswordField extends StatelessWidget {
  const _PasswordField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: passwordController,
      obscureText: false, // 비밀번호 안보이게
      decoration: InputDecoration(hintText: "비밀번호"),
    );
  }
}

/// 비밀번호
class _EmailField extends StatelessWidget {
  const _EmailField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: emailController,
      decoration: InputDecoration(hintText: "이메일"),
    );
  }
}

/// 로그인 버튼
class _LoginButton extends StatelessWidget {
  const _LoginButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    // 로그인
    void login() {
      authService.signIn(
        email: emailController.text,
        password: passwordController.text,
        onSuccess: () {
          // 로그인 성공
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("로그인 성공"),
          ));

          // HomePage로 이동
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        onError: (err) {
          // 에러 발생
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(err),
          ));
        },
      );
    }

    return ElevatedButton(
      child: Text("로그인", style: TextStyle(fontSize: 21)),
      onPressed: () {
        login();
      },
    );
  }
}

/// 회원가입 버튼
class _SignUpButton extends StatelessWidget {
  const _SignUpButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = context.watch<AuthService>();

    // 회원가입
    void singUp() {
      authService.signUp(
        email: emailController.text,
        password: passwordController.text,
        onSuccess: () {
          // 회원가입 성공
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("회원가입 성공"),
          ));
        },
        onError: (err) {
          // 에러 발생
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(err),
          ));
        },
      );
    }

    return ElevatedButton(
      child: Text("회원가입", style: TextStyle(fontSize: 21)),
      onPressed: () {
        singUp();
      },
    );
  }
}
