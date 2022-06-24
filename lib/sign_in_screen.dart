import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fireabase_sample_app_practice/photo_list_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //メールアドレス用のTextEditingController
  final TextEditingController _emailController = TextEditingController();
  //パスワード用のTextEditingController
  final TextEditingController _passwordController = TextEditingController();

  void _onSignIn() {
    //  入力内容を確認する
    if (_formKey.currentState?.validate() != true) {
      //  エラーメッセージがあるため処理を中断する
      return;
    }

    //  画像一覧画面に切り替え
    // pushReplacement: 前の画面を削除して、新しく画面を追加する
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => const PhotoListScreen(),
      ),
    );
  }

  Future<void> _onSignUp() async {
    try {
      //  入力内容を確認する
      if (_formKey.currentState?.validate() != true) {
        return;
      }

      /*
      * メールアドレス・パスワードで新規登録
      * TextEditingControllerから入力内容を取得
      * Authenticationを使った複雑な処理はライブラリがやってくれる
      * */
      final String email = _emailController.text;
      final String password = _passwordController.text;
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      //  画像一覧画面に切り替え
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const PhotoListScreen(),
        ),
      );
    } catch (e) {
      //  失敗したらエラーメッセージを表示
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('エラー'),
            content: Text(
              e.toString(),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
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
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'メールアドレス'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? value) {
                    if (value?.isEmpty == true) {
                      //  問題があるときはメッセージを返す
                      return 'メールアドレスを入力してください';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                //  入力フォーム(パスワード)
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'パスワード'),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  validator: (String? value) {
                    //  パスワードが入力されていない時
                    if (value?.isEmpty == true) {
                      return 'パスワードを入力してください';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  //  ボタン
                  child: ElevatedButton(
                    onPressed: () => _onSignIn(),
                    child: const Text('ログイン'),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: double.infinity,
                  //  ボタン(新規登録)
                  child: ElevatedButton(
                    onPressed: () => _onSignUp(),
                    child: const Text('新規登録'),
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
