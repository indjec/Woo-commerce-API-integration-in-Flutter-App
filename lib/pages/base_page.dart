import 'package:flutter/material.dart';
import 'package:woocommer_api/utils/progress_hud.dart';

class BasePage extends StatefulWidget {
  @override
  BasePageState createState() => BasePageState();
}

class BasePageState<T extends BasePage> extends State<T> {
  bool isApiCallProcess = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: ProgressHUD(
        child: pageUI(),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.dark,
      elevation: 0,
      backgroundColor: Colors.redAccent,
      automaticallyImplyLeading: true,
      title: Text(
        'Grocery App',
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        Icon(
          Icons.notifications_none,
          color: Colors.white,
        ),
        SizedBox(width: 10),
        Icon(
          Icons.shopping_cart,
          color: Colors.white,
        ),
        SizedBox(width: 10),
      ],
    );
  }

  Widget pageUI() {
    return null;
  }
}
