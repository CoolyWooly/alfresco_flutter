class CategoriesResponse {
  ContentModel? content;

  CategoriesResponse({this.content});

  CategoriesResponse.fromJson(Map<String, dynamic> json) {
    content = json['content'] != null
        ? new ContentModel.fromJson(json['content'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.content != null) {
      data['content'] = this.content!.toJson();
    }
    return data;
  }
}

class ContentModel {
  late List<CategoryModel> subs;

  ContentModel({required this.subs});

  ContentModel.fromJson(Map<String, dynamic> json) {
    subs = [];
    json['subs'].forEach((v) {
      subs.add(new CategoryModel.fromJson(v));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subs'] = this.subs.map((v) => v.toJson()).toList();
    return data;
  }
}

class CategoryModel {
  late int id;
  late String title;

  CategoryModel({required this.id, required this.title});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
