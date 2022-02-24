import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ltcapp/core/services/CurrentSession.dart';
import 'package:ltcapp/core/services/DatabaseConnector.dart';
import 'package:stacked/stacked.dart';

class AdminViewModel extends MultipleFutureViewModel {



  DatabaseHandler db = DatabaseHandler();
  static const String _ParadeStateDelayedFuture = "paradeState";
  List<List<String>> get fetchedParadeState=> dataMap![_ParadeStateDelayedFuture];
  bool get fetchingParadeState => busy(_ParadeStateDelayedFuture);

  @override
  Map<String, Future Function()> get futuresMap => {
    _ParadeStateDelayedFuture: getParadeState,
  };


  Future<List<List<String>>> getParadeState() async {
    List<List<String>> _list = await db.getParadeState();
    for(int i=0; i< _list.length; i++){
      String _localUser = _list[i][0];
      String rank = await db.singleDataPull("Users", "username", _localUser, "rank");
      String fullName = await db.singleDataPull("Users", "username", _localUser, "fullName");
      String appendedName = rank + " " + fullName;
      _list[i].add(appendedName);
      print(_list);
    }
    print("List of parade state is $_list");
    return _list;
  }


  void floatingButtonPress(BuildContext context) {}
}
