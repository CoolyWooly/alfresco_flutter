import 'dart:async';

import 'package:untitled/models/category_model.dart';
import 'package:untitled/models/products_model.dart';
import 'package:untitled/networking/api_response.dart';
import 'package:untitled/repository/products_repository.dart';

class ProductsBloc {
  final _productsRepository = ProductsRepository();

  final _categoriesListController =
      StreamController<ApiResponse<List<CategoryModel>>>();

  StreamSink<ApiResponse<List<CategoryModel>>> get listSink =>
      _categoriesListController.sink;

  Stream<ApiResponse<List<CategoryModel>>> get listStream =>
      _categoriesListController.stream;

  ProductsBloc() {
    fetchCategoryList();
    fetchProductList(563);
  }

  fetchCategoryList() async {
    listSink.add(ApiResponse.loading('Loading'));
    try {
      List<CategoryModel> list = await _productsRepository.fetchCategoryList();
      listSink.add(ApiResponse.completed(list));
    } catch (e) {
      listSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  final _productListController =
  StreamController<ApiResponse<List<ProductModel>>>();

  StreamSink<ApiResponse<List<ProductModel>>> get productListSink =>
      _productListController.sink;

  Stream<ApiResponse<List<ProductModel>>> get productListStream =>
      _productListController.stream;

  fetchProductList(int id) async {
    print("asdf");
    productListSink.add(ApiResponse.loading('Loading'));
    try {
      List<ProductModel> list = await _productsRepository.fetchProductList(id);
      productListSink.add(ApiResponse.completed(list));
    } catch (e) {
      productListSink.add(ApiResponse.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _categoriesListController.close();
    _productListController.close();
  }
}
