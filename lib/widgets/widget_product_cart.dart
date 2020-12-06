import 'package:flutter/material.dart';
import 'package:woocommer_api/models/product.dart';
import 'package:woocommer_api/pages/product_details.dart';

class ProductCard extends StatelessWidget {
  ProductCard({this.data});
  Product data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetails(
                      product: data,
                    )));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color(0xfff8f8f8), blurRadius: 15, spreadRadius: 10),
            ]),
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Flexible(
                      child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Color(0xffE65829).withAlpha(40),
                      ),
                      Image.network(
                        data.images.length > 0
                            ? data.images[0].src
                            : "https://dummyimage.com/600x400/678gaA/000233",
                        height: 160.0,
                      )
                    ],
                  )),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    data.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Visibility(
                      //   visible: data.salePrice != data.regularPrice,

                      //   child: Text(
                      //     "Rs ${data.regularPrice}",
                      //     style: TextStyle(
                      //       fontSize: 14,
                      //       decoration: TextDecoration.lineThrough,
                      //       color: Colors.redAccent,
                      //       fontWeight: FontWeight.bold,
                      //     ),
                      //   ),
                      // ),
                      Text(
                        "Rs ${data.regularPrice}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
