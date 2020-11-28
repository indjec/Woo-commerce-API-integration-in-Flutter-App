class Category {
  int categoryId;
  String categoryName;
  String categoryDesc;
  int parent;
  Image1 image;

  Category(
      {this.categoryId,
      this.categoryDesc,
      this.categoryName,
      this.image,
      this.parent});

  Category.fromJson(Map<String, dynamic> json) {
    categoryId = json['id'];
    categoryName = json['name'];
    categoryDesc = json['description'];
    parent = json['parent'];
    image = json['image'] != null ? new Image1.fromJson(json['image']) : null;
  }
}

class Image1 {
  String url;

  Image1({this.url});

  Image1.fromJson(Map<String, dynamic> json) {
    url = json['src'];
  }
}
