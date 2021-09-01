import 'package:flutter/foundation.dart';
import 'package:untitled/models/category_model.dart';
import 'package:untitled/models/products_model.dart';
import 'package:untitled/networking/api_base_helper.dart';

class ProductsRepository {

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<List<CategoryModel>> fetchCategoryList() async {
    final response = await _helper.get("api/v1/categories/562");
    if (CategoriesResponse.fromJson(response).content?.subs == null) return [];
    return CategoriesResponse.fromJson(response).content!.subs;
  }

  Future<List<ProductModel>> fetchProductList(int id) async {
    final response = await _helper.get("api/v1/categories/$id/products");
    if (ProductsResponse.fromJson(response).content?.data == null) return [];
    return ProductsResponse.fromJson(response).content!.data!;
  }
}