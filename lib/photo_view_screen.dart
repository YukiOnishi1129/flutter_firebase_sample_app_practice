import 'package:flutter/material.dart';

class PhotoViewScreen extends StatefulWidget {
  const PhotoViewScreen({
    Key? key,
    //requiredをつけると、必須パラメータとうい意味になる
    required this.imageURL,
    required this.imageList,
  }) : super(key: key);

  final String imageURL;
  final List<String> imageList;

  @override
  State<PhotoViewScreen> createState() => _PhotoViewScreenState();
}

class _PhotoViewScreenState extends State<PhotoViewScreen> {
  late PageController _controller;

  // ダミー画像一覧
  // final List<String> imageList = [
  //   'https://placehold.jp/400x300.png?text=0',
  //   'https://placehold.jp/400x300.png?text=1',
  //   'https://placehold.jp/400x300.png?text=2',
  //   'https://placehold.jp/400x300.png?text=3',
  //   'https://placehold.jp/400x300.png?text=4',
  //   'https://placehold.jp/400x300.png?text=5',
  // ];

  @override
  void initState() {
    super.initState();

    //受け取った画像一覧から、ページ番号を特定
    final int initialPage = widget.imageList.indexOf(widget.imageURL);
    _controller = PageController(
      initialPage: initialPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // AppBarは裏のままで、bodyの表示エリアを広げる
        extendBodyBehindAppBar: true,
        // 透明なAppBarを作る
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Stack(
          children: [
            //  画像一覧
            PageView(
              controller: _controller,
              onPageChanged: (int index) => {},
              // 受け取った画像一覧を表示
              children: widget.imageList.map((String imageURL) {
                return Image.network(
                  imageURL,
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
            // アイコンボタンを画像の手前に重ねる
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                //フッター部分にグラデーションを入れてみる
                decoration: BoxDecoration(
                  // 線形グラデーション
                  gradient: LinearGradient(
                    //  下方向から上方向に向かってグラデーションさせる
                    begin: FractionalOffset.bottomCenter,
                    end: FractionalOffset.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.5),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 1.0],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    //  共有ボタン
                    IconButton(
                      onPressed: () => {},
                      color: Colors.white,
                      icon: const Icon(Icons.share),
                    ),
                    IconButton(
                      onPressed: () => {},
                      color: Colors.white,
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
