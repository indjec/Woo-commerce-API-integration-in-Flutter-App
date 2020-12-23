import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommer_api/models/cart_request_model.dart';
import 'package:woocommer_api/models/product.dart';
import 'package:woocommer_api/provider/cart_provider.dart';
import 'package:woocommer_api/provider/loader_provider.dart';
import 'package:woocommer_api/utils/custom_stepper.dart';
import 'package:woocommer_api/utils/expand_text.dart';
import 'package:woocommer_api/widgets/widgets_realted_products.dart';

class ProductDetailsWidget extends StatelessWidget {
  ProductDetailsWidget({this.data});
  Product data;
  final CarouselController controller = new CarouselController();
  int qty = 0;

  CartProducts cartProducts = new CartProducts();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                productImages(data.images, context),
                SizedBox(height: 10.0),
                Text(
                  data.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(data.attributes != null && data.attributes.length > 0
                        ? data.attributes[0].options.join(".").toString() +
                            "" +
                            data.attributes[0].name
                        : ""),
                    Text(
                      "Rs. ${data.regularPrice}",
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomStepper(
                      lowerLimit: 0,
                      upperLimit: 20,
                      stepValue: 1,
                      iconSize: 22,
                      value: this.qty,
                      onChanged: (value) {
                        cartProducts.quantity = value;
                      },
                    ),
                    FlatButton(
                      onPressed: () {
                        Provider.of<LoaderProvider>(context, listen: false)
                            .setLoadingStatus(true);
                        var cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        cartProducts.productId = data.id;
                        cartProvider.addToCart(cartProducts, (val) {
                          Provider.of<LoaderProvider>(context, listen: false)
                              .setLoadingStatus(false);
                        });
                      },
                      child: Text(
                        'Add To Cart',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.redAccent,
                      padding: EdgeInsets.all(15.0),
                      shape: StadiumBorder(),
                    )
                  ],
                ),
                SizedBox(height: 5.0),
                ExpandText(
                  labelHeader: "Product Details",
                  shortDesc: data.shortDesc,
                  desc: data.desc,
                ),
                Divider(),
                SizedBox(
                  height: 10,
                ),
                // WidgetRelatedProducts(
                //   labelName: "Related Products",
                //   products: this.data.relatedIds,
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget productImages(List<Images> images, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 250,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: CarouselSlider.builder(
                  carouselController: controller,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Center(
                        child: Image.network(
                          images[index].src,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      viewportFraction: 1,
                      aspectRatio: 1.0)),
            ),
            Positioned(
              top: 100,
              child: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  controller.previousPage();
                },
              ),
            ),
            Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width - 80,
              child: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  controller.nextPage();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
