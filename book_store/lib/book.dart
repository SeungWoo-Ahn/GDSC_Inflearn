class Book {
  String title;
  String subtitle;
  String thumbnail;
  String previewLink;

  Book({
    required this.title,
    required this.subtitle,
    required this.thumbnail,
    required this.previewLink,
  });

  //Json 파일을 Map으로 받아 Book객체에 넣어줌
  factory Book.fromJson(Map<String, dynamic> info) {
    return Book(
      title: info["title"] ?? "",
      subtitle: info["subtitle"] ?? "",
      thumbnail: info["imageLinks"]?["thumbnail"] ??
          "https://i.ibb.co/2ypYwdr/no-photo.png",
      previewLink: info["previewLink"] ?? "",
    );
  }
}
