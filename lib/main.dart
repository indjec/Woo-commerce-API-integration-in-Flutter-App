import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:woocommer_api/pages/home.dart';
import 'package:woocommer_api/pages/login.dart';
import 'package:woocommer_api/pages/product.dart';
import 'package:woocommer_api/pages/signup.dart';
import 'package:woocommer_api/provider/products_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductProvider(),
          child: ProductPage(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomePage(),
      ),
    );
  }
}
