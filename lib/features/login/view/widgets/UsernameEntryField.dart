import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltcapp/core/config/Globals.dart';
import 'package:ltcapp/features/login/viewmodel/LoginPageViewModel.dart';
import 'package:stacked/stacked.dart';

class UserNameEntryField extends ViewModelWidget<LoginPageViewModel> {
  const UserNameEntryField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, LoginPageViewModel model) {
    return Container(
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
              controller: model.usernameController,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: darkPrimary500, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: darkPrimary300, width: 1.5),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  fillColor: darkPrimary700,
                  filled: true),
            ),
          )
        ],
      ),
    );
  }
}
