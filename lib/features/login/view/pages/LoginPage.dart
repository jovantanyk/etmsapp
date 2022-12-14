import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:ltcapp/core/widgets/ErrorDialogs.dart';
import 'package:ltcapp/features/login/view/widgets/PasswordEntryField.dart';
import 'package:ltcapp/features/login/view/widgets/UsernameEntryField.dart';
import 'package:ltcapp/features/login/viewmodel/LoginPageViewModel.dart';
import 'package:ltcapp/features/registration/view/pages/SignupPage.dart';
import 'package:ltcapp/core/services/CurrentSession.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltcapp/core/widgets/widgets.dart';
import 'package:ltcapp/core/config/Globals.dart';
import 'package:ltcapp/main.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return ViewModelBuilder<LoginPageViewModel>.reactive(
        viewModelBuilder: () => LoginPageViewModel(),
        onModelReady: (viewModel) => viewModel.initialise(context),
        builder: (context, model, child) {
          return Scaffold(
            body: Container(
              height: height,
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: height * .2),
                          _title(context),
                          SizedBox(height: 50),
                          Column(
                            children: <Widget>[
                              UserNameEntryField(),
                              PasswordEntryField(),
                            ],
                          ),
                          SizedBox(height: 30),
                          _submitButton(context, model),
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            alignment: Alignment.centerRight,
                            child: Text('Forgot Password ?',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ),
                          SizedBox(height: height * .055),
                          _createAccountLabel(context),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      top: 40,
                      left: 0,
                      child: TopBackButton(
                          padding: EdgeInsets.symmetric(
                        horizontal: 10,
                      ))),
                ],
              ),
            ),
          );
        });
  }

  /*Widget _usernameEntryField() {
    return Consumer<LoginPageViewModel>(
      builder: (context, vm, child) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Username",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: darkTextColor,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: darkTextColor),
                obscureText: false,
                controller: vm.usernameController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: darkPrimary500, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: darkPrimary300, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    fillColor: darkPrimary700,
                    filled: true),
              ),
            )
          ],
        ),
      ),
    );
  }*/

  /*Widget _passwordEntryField() {
    return Consumer<LoginPageViewModel>(
      builder: (context, vm, child) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Password",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: darkTextColor),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: TextField(
                style: GoogleFonts.lato(
                    textStyle: Theme.of(context).textTheme.headline4,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: darkTextColor),
                obscureText: true,
                controller: vm.passwordController,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: darkPrimary500, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: darkPrimary300, width: 1.5),
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    fillColor: darkPrimary700,
                    filled: true),
              ),
            )
          ],
        ),
      ),
    );
  }*/

  Widget _submitButton(BuildContext context, LoginPageViewModel model) {
    return InkWell(
        onTap: () {
          model.verifyLoginData(context);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: darkGreenAccent,
            borderRadius: BorderRadius.all(Radius.circular(5)),
          ),
          child: Text(
            'Login',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ));
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
          ),
          Text(
            'or',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                color: Colors.white,
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _singPassButton(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5)),
              ),
              alignment: Alignment.center,
              child: Icon(
                Icons.accessibility_new_rounded,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: InkWell(
              onTap: () => Navigator.pushNamed(context, '/afterLogin'),
              child: Container(
                decoration: BoxDecoration(
                  color: darkGreenAccent,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(5),
                      topRight: Radius.circular(5)),
                ),
                alignment: Alignment.center,
                child: Text('Login using Singpass',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Function Not Available Yet"),
              );
            });
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Don\'t have an account ?',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Login',
        style: GoogleFonts.roboto(
          textStyle: Theme.of(context).textTheme.headline4,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}
