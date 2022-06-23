import 'package:flutter/material.dart';

class PhotoListScreen extends StatefulWidget {
  const PhotoListScreen({Key? key}) : super(key: key);

  @override
  State<PhotoListScreen> createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  late int _currentIndex;
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    // PageViewで表示されているWidgetの番号を持っていく
    _currentIndex = 0;
    // PageViewの表示を切り替えるのに使う
    _controller = PageController(initialPage: _currentIndex);
  }

  void _onPageChanged(int index) {
    //  PageViewで表示されているWidgetの番号を更新
    setState(() {
      _currentIndex = index;
    });
  }

  void _onTapBottomNavigationItem(int index) {
    //  PageViewで表示するWidgetを切り替える
    _controller.animateToPage(
      /*
      * 表示するWidgetの番号
      * 0: 全ての画像
      * 1: お気に入り登録した画像
      * */
      index,
      // 表示を切り替える時にかかる時間(300ミリ秒)
      duration: const Duration(milliseconds: 300),
      /*
      * アニメーションの動き方
      * この値を変えることで、アニメーションの動きを変えることができる。
      * https://api.flutter.dev/flutter/animation/Curves-class.html
      * */
      curve: Curves.easeIn,
    );
    // PageViewで表示されているWidgetの番号を更新
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo App'),
        actions: [
          //  ログアウトボタン
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: PageView(
        controller: _controller,
        //  表示が切り替わった時
        onPageChanged: (int index) => _onPageChanged(index),
        children: [
          // 「全ての画像」を表示する部分
          Container(
            child: const Center(
              child: Text('ページ:フォト'),
            ),
          ),
          // 「お気に入りした画像」を表示する部分
          Container(
            child: const Center(
              child: Text('ページ:お気に入り'),
            ),
          )
        ],
      ),
      // 画像追加ボタン
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
      //  画像下部のボタン部分
      bottomNavigationBar: BottomNavigationBar(
        /*
        * BottomNavigationBarItemがタップされた時の処理
        * 0: フォト
        * 1: お気に入り
        * */
        onTap: (int index) => _onTapBottomNavigationItem(index),
        /*
        *  現在表示されているBottomNavigationBarItemの番号
        * 0: フォト
        * 1: お気にいり
        * */
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.image),
            label: 'フォト',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'お気に入り',
          ),
        ],
      ),
    );
  }
}
