import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fireabase_sample_app_practice/sign_in_screen.dart';

void main() async {
  // Flutterの初期化処理をまつ
  WidgetsFlutterBinding.ensureInitialized();

  /*
  * アプリ起動時にFirebase初期化処理を入れる
  * initializeApp()の返り値がFutureなので非同期処理
  * 非同期処理(Future)はawaitで処理が終わることを待つことができる
  * ただし、awaitを使うときは関数にasyncをつける必要がある
  * */
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInScreen(),
    );
  }
}
