class WallpaperModel {
  int? page;
  int? perPage;
  List<Photos>? photos;
  String? nextPage;

  WallpaperModel({this.page, this.perPage, this.photos, this.nextPage});

  WallpaperModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(Photos.fromJson(v));
      });
    }
    nextPage = json['next_page'];
  }
}

class Photos {
  int? id;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  Src? src;

  Photos({
    this.id,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.src,
  });

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    src = json['src'] != null ? Src.fromJson(json['src']) : null;
  }
}

class Src {
  String? original;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  Src({
    this.original,
    this.large,
    this.medium,
    this.small,
    this.portrait,
  });

  Src.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
  }
}
