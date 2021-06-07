import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/model/categories_model.dart';
import 'package:wallpaper_app/model/wallpaper_model.dart';
import 'package:wallpaper_app/views/categorie.dart';
import 'package:wallpaper_app/views/search.dart';
import 'package:wallpaper_app/views/widget/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchcontroller = TextEditingController();

  getTrendingWallpapers() async {
    var response = await http
        .get("https://api.pexels.com/v1/curated?per_page=45", headers: {
      "Authorization": apiKey,
    });

    // print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });

    setState(() {});
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories = getcategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: BrandName(),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24),
              padding: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Color(0xfff5f8fd)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: searchcontroller,
                      decoration: InputDecoration.collapsed(
                        hintText: "Search Wallpaper",
                      ),
                    ),
                  ),
                  GestureDetector(
                      //gesture detector terine ınkwell kullaranak basınca animasyon almamıız sağlar
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => Search(
                                      searchQuery: searchcontroller.text,
                                    )));
                      },
                      child: Container(child: Icon(Icons.search))),
                ],
              ),
            ),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 80,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 24),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return CategorieTile(
                    title: categories[index].categorieName,
                    imgUrl: categories[index].imgUrl,
                  );
                },
              ),
            ),
            Expanded(
                child: wallpaperList(wallpapers: wallpapers, context: context)),
          ],
        ),
      ),
    );
  }
}

class CategorieTile extends StatelessWidget {
  final String imgUrl, title;

  CategorieTile({this.imgUrl, this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => Categories(
                      categorieName: title.toLowerCase(),
                    )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 8),
        child: Stack(
          //üst üste olucak widgetlarda stack kllanıyoruz mesela arkada foto üstte yazı olcak ondan dolayı stack widgetını kullandık
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imgUrl,
                  height: 60,
                  width: 120,
                  fit: BoxFit.cover,
                )),
            //dışta kalan fazlalıkalrı almış olduk üst üste bindiği iiçin bunda fazlalık oluyodu bu şekilde halletmiş olduk.Bunun yerine CONTAİNER alıp decoration verip aynı şeyi yapmış olurudk
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors
                    .black26, //fotoğrafların biraz daha karamsar olmasını sağladı zaten fotoğrafın üstünde duruyo şuan bu yazı tam boyutlarda aynı arka planı karartınca fotoğraf karamış oldu
              ),
              height: 60,
              width: 120,
              alignment: Alignment.center,
              child: Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
