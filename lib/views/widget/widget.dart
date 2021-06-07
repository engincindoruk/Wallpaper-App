import 'package:flutter/material.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/image_view.dart';

Widget BrandName() {
  return RichText(
    textAlign: TextAlign.end,
    text: TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(
            text: 'Wallpaper',
            style: TextStyle(
              color: Colors.black,
            )),
        TextSpan(text: 'App', style: TextStyle(color: Colors.yellow)),
      ],
    ),
  );
}

Widget wallpaperList({List<WallpaperModel> wallpapers, context}) {
  // var _controller = ScrollController();

  // _controller.addListener(() {
  //   if (_controller.position.atEdge) {
  //     if (_controller.position.pixels == 0) {
  //     } else {
  //       wallpaperList(wallpapers: wallpapers, context: context);
  //       print("bitti");
  //     }
  //   }
  // });

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      // controller: _controller,
      physics:
          ClampingScrollPhysics(), //bunu vermeyince fotoğrafllar üzerinde kaydırma aşağıya doğru kaydırma olmuyodu
      shrinkWrap: true,
      crossAxisCount: 2, //yanyana 2 tane fotoğraf olsun,
      childAspectRatio:
          0.6, //buda fotoğrafın ince uzun yada uzun ince olarak gözükmesini sağlıyor
      mainAxisSpacing: 6.0, //üsttekiyle alttaki arasında boşluk
      crossAxisSpacing: 6.0, //sağdaki soldaki arasındaki boşluk
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ImageViewScreen(
                            imageUrl: wallpaper.src.portrait,
                          )));
            },
            child: Hero(
              tag: wallpaper.src.portrait, //bu bu isim olmak zorunda değil
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    wallpaper.src.portrait,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
