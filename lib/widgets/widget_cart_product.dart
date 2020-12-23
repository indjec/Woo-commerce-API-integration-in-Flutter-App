import 'package:flutter/material.dart';
import 'package:woocommer_api/models/cart_response_model.dart';

class WidgetCartProduct extends StatelessWidget {
  WidgetCartProduct({this.data});
  CartItem data;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: makeListTitle(context),
      ),
    );
  }

  ListTile makeListTitle(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
      );
}
