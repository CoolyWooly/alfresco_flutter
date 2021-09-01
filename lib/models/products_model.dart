class ProductsResponse {
  bool? status;
  Content? content;

  ProductsResponse({
    this.status,
    this.content,
  });

  ProductsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.content != null) {
      data['content'] = this.content?.toJson();
    }
    return data;
  }
}

class Content {
  List<ProductModel>? data;

  Content({this.data});

  Content.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <ProductModel>[];
      json['data'].forEach((v) {
        data?.add(new ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModel {
  int? id;
  String? title;
  String? description;
  String? unit;
  String? cost;
  int? unitId;
  String? unitStep;
  String? unitStartingPoint;
  Image? image;

  ProductModel(
      {this.id,
      this.title,
      this.description,
      this.unit,
      this.cost,
      this.unitStep,
      this.unitStartingPoint,
      this.image});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    unit = json['unit'];
    cost = json['cost'];
    unitStep = json['unit_step'];
    unitStartingPoint = json['unit_starting_point'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['unit'] = this.unit;
    data['cost'] = this.cost;
    data['unit_step'] = this.unitStep;
    data['unit_starting_point'] = this.unitStartingPoint;
    if (this.image != null) {
      data['image'] = this.image?.toJson();
    }
    return data;
  }
}

class Image {
  late int id;
  late String name;
  late String thumb;
  late String path;

  Image({
    required this.id,
    required this.name,
    required this.thumb,
    required this.path,
  });

  Image.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    thumb = json['thumb'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['thumb'] = this.thumb;
    data['path'] = this.path;
    return data;
  }
}
