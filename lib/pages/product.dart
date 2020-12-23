import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommer_api/models/product.dart';
import 'package:woocommer_api/models/sortby.dart';
import 'package:woocommer_api/pages/base_page.dart';
import 'package:woocommer_api/provider/products_provider.dart';
import 'package:woocommer_api/widgets/widget_product_cart.dart';

// class SortBy {
//   String value;
//   String text;
//   String sortOrder;

//   SortBy(this.sortOrder, this.text, this.value);
// }

class ProductPage extends BasePage {
  int categoryId;
  ProductPage({this.categoryId});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends BasePageState<ProductPage> {
  int _page = 1;
  ScrollController _scrollController = new ScrollController();
  final _sortByOptions = [
    SortBy("popularity", "Popularity", "asc"),
    SortBy("modified", "Latest", "asc"),
    SortBy("price", "Price: High to Low", "desc"),
    SortBy("price", "Price: Low to High", "asc")
  ];

  @override
  void initState() {
    super.initState();
    var productList = Provider.of<ProductProvider>(context, listen: false);
    productList.resetStreams();
    productList.setLoadingState(LoadMoreStatus.INITIAL);
    productList.fetchProducts(_page);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        productList.setLoadingState(LoadMoreStatus.LOADING);
        productList.fetchProducts(++_page);
      }
    });
  }

  @override
  Widget pageUI() {
    return _productList();
  }

  Widget _productList() {
    return Consumer<ProductProvider>(
      builder: (context, productsModel, child) {
        if (productsModel.allProducts != null &&
            productsModel.allProducts.length > 0 &&
            productsModel.getLoadMoreStatus() != LoadMoreStatus.INITIAL) {
          return _buildList(productsModel.allProducts,
              productsModel.getLoadMoreStatus() == LoadMoreStatus.LOADING);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildList(List<Product> products, bool isLoadMore) {
    return Column(
      children: [
        Container(height: 70.0, child: _productFilter()),
        Flexible(
            child: GridView.count(
          shrinkWrap: true,
          controller: _scrollController,
          physics: ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          crossAxisCount: 2,
          children: products.map((Product item) {
            return ProductCard(data: item);
          }).toList(),
        )),
        Visibility(
          child: Container(
              padding: EdgeInsets.all(5.0),
              height: 35,
              width: 35,
              child: CircularProgressIndicator()),
          visible: isLoadMore,
        )
      ],
    );
  }

  Widget _productFilter() {
    return Container(
      height: 5.0,
      margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Color(0xffe6e6ec),
                  filled: true),
            ),
          ),
          SizedBox(width: 15.0),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffe6e6ec),
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: PopupMenuButton(
              onSelected: (sortBy) {
                print(sortBy);
                var productList =
                    Provider.of<ProductProvider>(context, listen: false);
                productList.resetStreams();
                productList.setSortOrder(sortBy);
                productList.fetchProducts(_page);
              },
              itemBuilder: (BuildContext context) {
                return _sortByOptions.map((item) {
                  return PopupMenuItem(
                    value: item,
                    child: Container(
                      child: Text(item.text),
                    ),
                  );
                }).toList();
              },
              icon: Icon(Icons.tune),
            ),
          )
        ],
      ),
    );
  }
}
