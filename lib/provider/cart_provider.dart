import 'package:flutter/material.dart';
import 'package:woocommer_api/models/cart_request_model.dart';
import 'package:woocommer_api/models/cart_response_model.dart';
import 'package:woocommer_api/services/api_service.dart';

class CartProvider with ChangeNotifier {
  ApiService _apiService;
  List<CartItem> _cartitems;

  List<CartItem> get CartItems => _cartitems;
  double get totalRecords => _cartitems.length.toDouble();

  CartProvider() {
    _apiService = new ApiService();
    _cartitems = new List<CartItem>();
  }

  void resetStreams() {
    _apiService = new ApiService();
    _cartitems = new List<CartItem>();
  }

  void addToCart(CartProducts product, Function onCallback) async {
    CartRequestModel requestModel = new CartRequestModel();
    requestModel.products = new List<CartProducts>();

    if (_cartitems == null) resetStreams();

    _cartitems.forEach((element) {
      requestModel.products.add(new CartProducts(
          productId: element.productId, quantity: element.qty));
    });

    var isProductExist = requestModel.products.firstWhere(
      (prd) => prd.productId == product.productId,
      orElse: () => null,
    );

    if (isProductExist != null) {
      requestModel.products.remove(isProductExist);
    }

    requestModel.products.add(product);

    await _apiService.addToCart(requestModel).then((cartResponseModel) {
      if (cartResponseModel.data != null) {
        _cartitems = [];
        _cartitems.addAll(cartResponseModel.data);
      }
      onCallback(cartResponseModel);
      notifyListeners();
    });
  }
}
