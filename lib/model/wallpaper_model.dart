class WallpaperModel {
  String photographer;
  String photographerurl;
  int photographerid;
  SrcModel src;

  WallpaperModel(
      {this.photographer, this.photographerurl, this.photographerid, this.src});

  factory WallpaperModel.fromMap(Map<String, dynamic> jsonData) {
    return WallpaperModel(
      src: SrcModel.fromMap(jsonData["src"]),
      photographer: jsonData["photographer"],
      photographerid: jsonData["photographer_id"],
      photographerurl: jsonData["photographer_url"],
    );
  }
}

class SrcModel {
  String original;
  String small;
  String portrait;

  SrcModel({this.original, this.small, this.portrait});

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      original: jsonData["original"],
      small: jsonData["small"],
      portrait: jsonData["portrait"],
    );
  }
}
