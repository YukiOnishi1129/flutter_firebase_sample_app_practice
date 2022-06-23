import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //   タイトル
              Text(
                'Photo App',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                height: 8,
              ),
              //  入力フォーム(メールアドレス)
              TextFormField(
                decoration: InputDecoration(labelText: 'メールアドレス'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 8,
              ),
              //  入力フォーム(パスワード)
              TextFormField(
                decoration: InputDecoration(labelText: 'パスワード'),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                //  ボタン
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text('ログイン'),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: double.infinity,
                //  ボタン(新規登録)
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text('新規登録'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
