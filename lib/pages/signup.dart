import 'package:flutter/material.dart';
import 'package:woocommer_api/models/customer.dart';
import 'package:woocommer_api/services/api_service.dart';
import 'package:woocommer_api/utils/form_helper.dart';
import 'package:woocommer_api/utils/progress_hud.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  ApiService apiService;
  CustomerModel model;
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  bool hidePassword = true;
  bool isApiCallProcess = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiService = new ApiService();
    model = new CustomerModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: true,
        title: Text('Sign Up'),
      ),
      body: ProgressHUD(
        child: Form(
          key: globalKey,
          child: _formUI(),
        ),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
      ),
    );
  }

  Widget _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHelper.fieldLabel('First Name'),
                FormHelper.textInput(
                    context,
                    model.firstname,
                    (value) => {
                          this.model.firstname = value,
                        }, onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter first name.';
                  }
                  return null;
                }),
                FormHelper.fieldLabel('Last Name'),
                FormHelper.textInput(
                    context,
                    model.lastname,
                    (value) => {
                          this.model.lastname = value,
                        }, onValidate: (value) {
                  return null;
                }),
                FormHelper.fieldLabel('Email'),
                FormHelper.textInput(
                    context,
                    model.email,
                    (value) => {
                          this.model.email = value,
                        }, onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter email.';
                  }
                  return null;
                }),
                FormHelper.fieldLabel('Password'),
                FormHelper.textInput(
                    context,
                    model.password,
                    (value) => {
                          this.model.password = value,
                        }, onValidate: (value) {
                  if (value.toString().isEmpty) {
                    return 'Please enter password.';
                  }
                  return null;
                },
                    obscureText: true,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          hidePassword = !hidePassword;
                        });
                      },
                      color: Theme.of(context).accentColor.withOpacity(0.4),
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                      ),
                    )),
                SizedBox(
                  height: 20.0,
                ),
                Center(
                    child: FormHelper.saveButton('Register', () {
                  if (validateAndSave()) {
                    print(model.toJson());
                    setState(() {
                      isApiCallProcess = true;
                    });
                    apiService.createCustomer(model).then((ret) {
                      setState(() {
                        isApiCallProcess = false;
                      });
                      if (ret) {
                        FormHelper.showMessage(context, 'WooCommerce App',
                            'Registration Successfull', 'Ok', () {
                          Navigator.of(context).pop();
                        });
                      } else {
                        FormHelper.showMessage(context, 'WooCommerce App',
                            'Email is already taken', 'Ok', () {
                          Navigator.of(context).pop();
                        });
                      }
                    });
                  }
                }))
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
