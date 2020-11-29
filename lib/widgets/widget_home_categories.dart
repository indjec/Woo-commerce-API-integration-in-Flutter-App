import 'package:flutter/material.dart';
import 'package:woocommer_api/models/category.dart';
import 'package:woocommer_api/pages/product.dart';
import 'package:woocommer_api/services/api_service.dart';

class WidgetCategories extends StatefulWidget {
  @override
  _WidgetCategoriesState createState() => _WidgetCategoriesState();
}

class _WidgetCategoriesState extends State<WidgetCategories> {
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
                  'All Categories',
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
          _categoriesList()
        ],
      ),
    );
  }

  Widget _categoriesList() {
    return FutureBuilder(
      future: apiService.getCategories(),
      builder: (BuildContext context, AsyncSnapshot<List<Category>> model) {
        if (model.hasData) {
          return _buildCategoryList(model.data);
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildCategoryList(List<Category> categories) {
    return Container(
      height: 114.0,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          var data = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ProductPage(categoryId: data.categoryId)));
            },
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 80.0,
                  height: 80.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(data.image.url)),
                      shape: BoxShape.circle,
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
                    Text(data.categoryName.toString()),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 14,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
