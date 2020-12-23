import 'package:flutter/material.dart';
import 'package:woocommer_api/widgets/widget_cart_product.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return WidgetCartProduct();
  }
}
