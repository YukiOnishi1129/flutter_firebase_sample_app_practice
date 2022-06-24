import 'package:flutter/material.dart';
import 'package:flutter_fireabase_sample_app_practice/photo_view_screen.dart';

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

  void _onTapPhoto(String imageURL) {
    //  最初に表示する画像のURLを指定して、画像詳細画面に切り替える
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PhotoViewScreen(imageURL: imageURL),
      ),
    );
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
          PhotoGridView(
            onTap: (imageURL) => _onTapPhoto(imageURL),
          ),
          // 「お気に入りした画像」を表示する部分
          PhotoGridView(
            onTap: (imageURL) => _onTapPhoto(imageURL),
          ),
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

class PhotoGridView extends StatelessWidget {
  const PhotoGridView({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  // コールバックからタップされた画像のURLを受け渡します。
  final void Function(String imageURL) onTap;

  @override
  Widget build(BuildContext context) {
    //ダミー画像一覧
    final List<String> imageList = [
      'https://placehold.jp/400x300.png?text=0',
      'https://placehold.jp/400x300.png?text=1',
      'https://placehold.jp/400x300.png?text=2',
      'https://placehold.jp/400x300.png?text=3',
      'https://placehold.jp/400x300.png?text=4',
      'https://placehold.jp/400x300.png?text=5',
    ];

    return GridView.count(
      // １行あたりに表示するWidget数
      crossAxisCount: 2,
      // Widget間のスペース(上下)
      mainAxisSpacing: 8,
      // Widget間のスペース(左右)
      crossAxisSpacing: 8,
      // 全体の余白
      padding: const EdgeInsets.all(8),
      // 画像一覧
      children: imageList.map((String imageURL) {
        //Stackを使い、Widgetを前後に重ねる
        return Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              // WidgetをTap可能にする
              child: InkWell(
                // タップしたらコールバックを実行する
                onTap: () => onTap(imageURL),
                // URLを指定して画像を表示
                child: Image.network(
                  imageURL,
                  /*
                  * 画像の表示の仕方を調整できる
                  * 比率は維持しつつ余白が出ないようにするのでcoverを指定
                  * https://docs-flutter-io.firebaseapp.com/flutter/painting/BoxFit-class.html
                  * */
                  fit: BoxFit.cover,
                ),
              ),
            ),
            /*
            * 　画像の上にお気に入りアイコンを重ねて表示
            * Alignment.toRightを指定し、右上部分にアイコンを表示
            * */
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => {},
                color: Colors.white,
                icon: const Icon(Icons.favorite_border),
              ),
            )
          ],
        );
      }).toList(),
    );
  }
}
