import 'package:flutter/material.dart';
import 'package:woocommer_api/models/product.dart';
import 'package:woocommer_api/pages/base_page.dart';
import 'package:woocommer_api/services/api_service.dart';
import 'package:woocommer_api/widgets/widget_product_cart.dart';

class ProductPage extends BasePage {
  int categoryId;
  ProductPage({this.categoryId});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends BasePageState<ProductPage> {
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = new ApiService();
  }

  @override
  Widget pageUI() {
    return _productList();
  }

  Widget _productList() {
    return FutureBuilder(
      future: apiService.getProducts(),
      builder: (BuildContext context, AsyncSnapshot<List<Product>> model) {
        if (model.hasData) {
          return _buildList(model.data);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildList(List<Product> products) {
    return GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      scrollDirection: Axis.vertical,
      crossAxisCount: 2,
      children: products.map((Product item) {
        return ProductCard(data: item);
      }).toList(),
    );
  }
}
