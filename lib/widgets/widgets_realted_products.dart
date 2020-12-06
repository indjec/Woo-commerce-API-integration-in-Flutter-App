import 'package:flutter/material.dart';
import 'package:woocommer_api/models/product.dart';
import 'package:woocommer_api/services/api_service.dart';

class WidgetRelatedProducts extends StatefulWidget {
  String labelName;
  List<int> products;

  WidgetRelatedProducts({this.labelName, this.products});
  @override
  _WidgetRelatedProductsState createState() => _WidgetRelatedProductsState();
}

class _WidgetRelatedProductsState extends State<WidgetRelatedProducts> {
  ApiService apiService;

  @override
  void initState() {
    super.initState();
    apiService = new ApiService();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4),
                child: Text(
                  this.widget.labelName,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, top: 4, right: 16.0),
                child: Text(
                  'View All',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
            ],
          ),
          _productList()
        ],
      ),
    );
  }

  Widget _productList() {
    return FutureBuilder(
      future: apiService.getProducts(productIDs: this.widget.products),
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
    return Container(
      height: 114.0,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          var data = products[index];
          return Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: 80.0,
                height: 80.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(data.images[0].src)),
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 5),
                          blurRadius: 15)
                    ]),
              ),
              Row(
                children: [
                  Text(data.name.toString()),
                  Icon(
                    Icons.keyboard_arrow_right,
                    size: 14,
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
