import 'package:flutter/material.dart';
import 'package:woocommer_api/models/product.dart';
import 'package:woocommer_api/models/sortby.dart';
import 'package:woocommer_api/services/api_service.dart';

enum LoadMoreStatus { INITIAL, LOADING, STABLE }

class ProductProvider with ChangeNotifier {
  ApiService _apiService;
  List<Product> _productList;
  SortBy _sortBy;

  int pageSize = 10;

  List<Product> get allProducts => _productList;
  double get totalRecords => _productList.length.toDouble();

  LoadMoreStatus _loadMoreStatus = LoadMoreStatus.STABLE;
  getLoadMoreStatus() => _loadMoreStatus;

  ProductProvider() {
    resetStreams();
    _sortBy = SortBy("modified", "Latest", "asc");
  }

  void resetStreams() {
    _apiService = ApiService();
    _productList = List<Product>();
  }

  setLoadingState(LoadMoreStatus loadMoreStatus) {
    _loadMoreStatus = loadMoreStatus;
    notifyListeners();
  }

  setSortOrder(SortBy sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  fetchProducts(int pageNumber,
      {String strSearch,
      String tagname,
      String categoryId,
      String sortBy,
      String sortOrder = "asc"}) async {
    print(pageNumber);
    List<Product> itemModel = await _apiService.getProducts(
        srtSearch: strSearch,
        tagname: tagname,
        pageNumber: pageNumber,
        pageSize: this.pageSize,
        categoryId: categoryId,
        sortBy: this._sortBy.sortOrder,
        sortOrder: this._sortBy.value);

    if (itemModel.length > 0) {
      _productList.addAll(itemModel);
    }

    setLoadingState(LoadMoreStatus.STABLE);
    notifyListeners();
  }
}
