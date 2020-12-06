import 'package:flutter/material.dart';
import 'package:woocommer_api/models/product.dart';
import 'package:woocommer_api/pages/base_page.dart';
import 'package:woocommer_api/widgets/widget_product_detail.dart';

class ProductDetails extends BasePage {
  ProductDetails({this.product});
  Product product;
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends BasePageState<ProductDetails> {
  @override
  Widget pageUI() {
    return Container(
      child: ProductDetailsWidget(data: widget.product),
    );
  }
}
