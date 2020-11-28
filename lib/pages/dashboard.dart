import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:woocommer_api/widgets/widget_home_categories.dart';
import 'package:woocommer_api/widgets/widget_home_products.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: ListView(
          children: [
            imageCarousel(context),
            WidgetCategories(),
            SizedBox(
              height: 5.0,
            ),
            WidgetHomeProducts(tagId: "74", label: "Today's Offer"),
            SizedBox(
              height: 5.0,
            ),
            WidgetHomeProducts(tagId: "75", label: "Top Selling Products"),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }

  Widget imageCarousel(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300.0,
      child: Carousel(
        overlayShadow: false,
        borderRadius: true,
        boxFit: BoxFit.none,
        autoplay: true,
        dotSize: 4.0,
        images: [
          FittedBox(
            fit: BoxFit.fill,
            child:
                Image.network("https://dummyimage.com/600x400/2cdecf/000233"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child:
                Image.network("https://dummyimage.com/600x400/4841d1/000233"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child:
                Image.network("https://dummyimage.com/600x400/hj789e/000233"),
          ),
          FittedBox(
            fit: BoxFit.fill,
            child:
                Image.network("https://dummyimage.com/600x400/678gaA/000233"),
          )
        ],
      ),
    );
  }
}
