//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:ltcapp/features/registration/model/individual_identity.dart';
import 'package:ltcapp/core/services/CurrentSession.dart';
import 'dart:async';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:postgres/postgres.dart';
import 'package:ltcapp/core/utils/DateAndTimeGetter.dart';
import 'package:ltcapp/core/services/Hash.dart';
//import 'package:dart_mssql/dart_mssql.dart';

class DatabaseHandler {
  DatabaseHandler();
  DateAndTime dt = DateAndTime();
  Hash hash = new Hash();
  Future<void> DBFunctionTemplate(String value) async {
    // In PostgreSQL, use " (double quotes) for Columns Eg. "Username"
    // use ' (apostrophe) for Values Eg. 'elephant123'
    // End PostgreSQL Query with ;

    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'SELECT "rank" FROM Users WHERE' " username = '" + value + "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    value = results.toString();
    connection.close();
  }

  Future<bool> verifyLoginCreds(String username, String pass) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring = 'SELECT "password" FROM Users WHERE "username" = ' "'" +
        username +
        "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    connection.close();
    if (results.toString() == "[[" + hash.getHash(pass) + "]]") {
      return true;
    } else {
      return false;
    }
  }

  Future<void> createUserAccount(
      String rank,
      String fullName,
      String nricLast4Digits,
      String handphoneNumber,
      String personalEmail,
      String dateOfEnlistment,
      String dateOfORD,
      String dateOfPostIn,
      String pesType,
      String vocationType,
      String stayInStayOut,
      String drivingCategory,
      String username,
      String password,
      String permissionsLevel,
      String totalClass3Mileage,
      String totalClass4Mileage,
      String remarks,
      String inUse,
      String vcPackage,
      String chatID) async {
    dateOfEnlistment = dateOfEnlistment.split("/")[0].padLeft(2, "0") + "/" + dateOfEnlistment.split("/")[1].padLeft(2, "0") + "/" + dateOfEnlistment.split("/")[2];
    dateOfORD = dateOfORD.split("/")[0].padLeft(2, "0") + "/" + dateOfORD.split("/")[1].padLeft(2, "0") + "/" + dateOfORD.split("/")[2];
    dateOfPostIn = dateOfPostIn.split("/")[0].padLeft(2, "0") + "/" + dateOfPostIn.split("/")[1].padLeft(2, "0") + "/" + dateOfPostIn.split("/")[2];
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'INSERT INTO Users ("UUID", "rank", "fullName", "nricLast4Digits", "handphoneNumber", "personalEmail", "dateOfEnlistment", "dateOfORD", "dateOfPostIn", "pesType", "vocationType", "stayInStayOut", "drivingCategory", "username", "password", "permissionLevel", "totalClass3Mileage", "totalClass4Mileage", "remarks", "inUse", "vcPackage", "chatID") '
                "VALUES (uuid_generate_v4(),'" +
            rank +
            "','" +
            fullName +
            "','" +
            nricLast4Digits +
            "','" +
            handphoneNumber +
            "','" +
            personalEmail +
            "','" +
            dateOfEnlistment +
            "','" +
            dateOfORD +
            "','" +
            dateOfPostIn +
            "','" +
            pesType +
            "','" +
            vocationType +
            "','" +
            stayInStayOut +
            "','" +
            drivingCategory +
            "','" +
            username +
            "','" +
            hash.getHash(password) +
            "','" +
            permissionsLevel +
            "','" +
            totalClass3Mileage +
            "','" +
            totalClass4Mileage +
            "','" +
            remarks +
            "','" +
            inUse +
            "','" +
            vcPackage +
            "','" +
            chatID +
            "');";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    connection.close();
  }

  Future<String> singleDataPull(String table, String collumIdentifier,
      String collumIdentifierValue, String neededCollum) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring = 'SELECT "' +
        neededCollum +
        '" FROM ' +
        table +
        ' WHERE "' +
        collumIdentifier +
        '"' " = '" +
        collumIdentifierValue +
        "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    var rawValue = results.toString();
    connection.close();
    var value = rawValue.substring(2, rawValue.length - 2);
    return value;
  }

  Future<void> createVehicle(
      String vehicleNo,
      String carModel,
      String carType,
      String classType,
      String status,
      String inUse,
      String lastAVIDate,
      String nextAVIDate,
      String lastWPTDate,
      String nextWPTDate,
      String lastPMMonth,
      String nextPMMonth,
      String additionalPlate,
      String additionalRemarks) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'INSERT INTO Vehicles ("UUID", "vehicleNo", "carModel", "carType", "classType", "status", "inUse", "lastAVIDate", "nextAVIDate", "lastWPTDate", "nextWPTDate", "additionalPlate", "additionalRemarks", "lastPMMonth", "nextPMMonth") '
                "VALUES (uuid_generate_v4(),'" +
            vehicleNo +
            "','" +
            carModel +
            "','" +
            carType +
            "','" +
            classType +
            "','" +
            status +
            "','" +
            inUse +
            "','" +
            lastAVIDate +
            "','" +
            nextAVIDate +
            "','" +
            lastWPTDate +
            "','" +
            nextWPTDate +
            "','" +
            lastPMMonth +
            "','" +
            nextPMMonth +
            "','" +
            additionalPlate +
            "','" +
            additionalRemarks +
            "');";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    connection.close();
  }

  Future<void> editSingleDataEntry(
      String table,
      String collumIdentifier,
      String collumIdentifierValue,
      String editingCollum,
      String editingCollumValue) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring = "UPDATE " +
        table +
        ' SET "' +
        editingCollum +
        '" = ' "'" +
        editingCollumValue +
        "' WHERE " '"' +
        collumIdentifier +
        '"' " = '" +
        collumIdentifierValue +
        "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    connection.close();
  }

  Future<void> checkAndCreateLoginEntry(String deviceIdentifier,
      String username, String password, String date, String time) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'SELECT "username" FROM RememberLogin WHERE "deviceIdentifier" = ' "'" +
            deviceIdentifier +
            "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    if (results.toString() == "[[" + username + "]]") {
      var querystring = "UPDATE RememberLogin" +
          ' SET "date" = ' +
          "'" +
          date +
          "', " +
          '"time" = ' +
          "'" +
          time +
          "' WHERE " '"deviceIdentifier" = ' "'" +
          deviceIdentifier +
          "' AND " '"username" = ' "'" +
          username +
          "';";
      print("Query String: " + querystring);
      var results = await connection.query(querystring);
      print("Database Result: " + results.toString());
    } else {
      var querystring =
          'INSERT INTO RememberLogin ("UUID", "deviceIdentifier", "username", "password", "date", "time") '
                  "VALUES (uuid_generate_v4(),'" +
              deviceIdentifier +
              "','" +
              username +
              "','" +
              hash.getHash(password) +
              "','" +
              date +
              "','" +
              time +
              "');";
      print("Query String: " + querystring);
      var results = await connection.query(querystring);
      print("Database Result: " + results.toString());
    }
    connection.close();
  }

  Future<List<dynamic>> findLoginEntry(
      //This Function takes in deviceIdentifier and returns username and password
      String deviceIdentifier) async {
    bool _ignoreTime = true;
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'SELECT * FROM RememberLogin WHERE "deviceIdentifier" = ' "'" +
            deviceIdentifier +
            "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    if (results.toString() == "[]" || results.toString() == "[[]]") {
      print("No Entry with match Device Identifier");
      print("Can't find UUID");
      return [];
    } else {
      var storingDate = [];
      var storingDateString = [];
      var storingTime = [];
      var storingTimeString = [];
      var querystring1;
      var querystring =
          'SELECT "date" FROM RememberLogin WHERE "deviceIdentifier" = ' "'" +
              deviceIdentifier +
              "';";
      print("Query String: " + querystring);
      List<dynamic> results = await connection.query(querystring);
      results.forEach((row) {
        print("Database Result: " + row.toString());
        var rawdate = row.toString().substring(1, row.toString().length - 1);
        var date = rawdate.split("/");
        var d1 = DateTime.utc(
            int.parse(date[2]), int.parse(date[1]), int.parse(date[0]));
        storingDate.add(d1);
        storingDateString.add(rawdate);
      });
      if (storingDate.length == 2) {
        if (storingDate[0].compareTo(storingDate[1]) < 0) {
          DateTime temp = storingDate[0];
          storingDate[0] = storingDate[1];
          storingDate[1] = temp;
          String temp1 = storingDateString[0];
          storingDateString[0] = storingDateString[1];
          storingDateString[1] = temp1;
        }
        if (storingDate[0] == storingDate[1]) {
          _ignoreTime = false;
          var samedate = storingDateString[0];
          var querystring =
              'SELECT "time" FROM RememberLogin WHERE "deviceIdentifier" = '
                      "'" +
                  deviceIdentifier +
                  "'" ' AND "date" = ' "'" +
                  samedate +
                  "';";
          print("Query String: " + querystring);
          List<dynamic> results = await connection.query(querystring);
          results.forEach((row) {
            print("Database Result: " + row.toString());
            var rawtime =
                row.toString().substring(1, row.toString().length - 1);
            var t1 = DateTime.utc(
                2021,
                12,
                18,
                int.parse(rawtime.substring(0, rawtime.length - 4)),
                int.parse(rawtime.substring(2, rawtime.length - 2)),
                int.parse(rawtime.substring(4, rawtime.length)));
            storingTime.add(t1);
          });
          if (storingTime[0].compareTo(storingTime[1]) < 0) {
            DateTime temp = storingTime[0];
            storingTime[0] = storingTime[1];
            storingTime[1] = temp;
          }
        }
      } else if (storingDate.length != 1) {
        for (int i = 0; i < storingDate.length - 1; i++) {
          for (int j = 0; j < storingDate.length - i - 1; j++) {
            if (storingDate[i].compareTo(storingDate[i + 1]) < 0) {
              DateTime temp = storingDate[i];
              storingDate[i] = storingDate[i + 1];
              storingDate[i + 1] = temp;
              String temp1 = storingDateString[i];
              storingDateString[i] = storingDateString[i + 1];
              storingDateString[i + 1] = temp1;
            }
          }
        }
        print('Storing Date is ' + storingDateString[0]);
        if (storingDate[0] == storingDate[1]) {
          _ignoreTime = false;
          var samedate = storingDateString[0];
          var querystring =
              'SELECT "time" FROM RememberLogin WHERE "deviceIdentifier" = '
                      "'" +
                  deviceIdentifier +
                  "'" ' AND "date" = ' "'" +
                  samedate +
                  "';";
          print("Query String: " + querystring);
          List<dynamic> results = await connection.query(querystring);
          results.forEach((row) {
            print("Database Result: " + row.toString());
            var rawtime =
                row.toString().substring(1, row.toString().length - 1);
            var t1 = DateTime.utc(
                2021,
                12,
                18,
                int.parse(rawtime.substring(0, rawtime.length - 4)),
                int.parse(rawtime.substring(2, rawtime.length - 2)),
                int.parse(rawtime.substring(4, rawtime.length)));
            storingTime.add(t1);
          });
          for (int x = 0; x < storingTime.length - 1; x++) {
            for (int y = 0; y < storingTime.length - x - 1; y++) {
              if (storingTime[x].compareTo(storingTime[x + 1]) < 0) {
                DateTime temp = storingTime[x];
                storingTime[x] = storingTime[x + 1];
                storingTime[x + 1] = temp;
              }
            }
          }
          print('Storing time is ' + storingTime.toString());
        }
/*      var entrydate = storingDate[0].day.toString().padLeft(2, '0') +
          "/" +
          storingDate[0].month.toString().padLeft(2, '0') +
          "/" +
          storingDate[0].year.toString();*/
        var entrydate = storingDateString[0];
        print("Date of Last Login: " + entrydate);
      } else {
        _ignoreTime = true;
      }
      if (_ignoreTime == true) {
        querystring1 =
            'SELECT "username", "password" FROM RememberLogin WHERE "deviceIdentifier" = '
                    "'" +
                deviceIdentifier +
                "'" ' AND "date" = ' "'" +
                storingDateString[0] +
                "';";
      } else {
        var entrytime = storingTime[0].hour.toString().padLeft(2, '0') +
            storingTime[0].minute.toString().padLeft(2, '0') +
            storingTime[0].second.toString().padLeft(2, '0');
        querystring1 =
            'SELECT "username", "password" FROM RememberLogin WHERE "deviceIdentifier" = '
                    "'" +
                deviceIdentifier +
                "'" ' AND "date" = ' "'" +
                storingDateString[0] +
                "'" ' AND "time" = ' "'" +
                entrytime +
                "';";
      }
      print("Query String : " + querystring1);
      List<dynamic> results1 = await connection.query(querystring1);
      print("Database Result: " + results1.toString());
      var userpass = [];
      results1.forEach((row) {
        userpass.add(row);
      });
      connection.close();
      return userpass[0];
    }
  }

  Future<String> startTrip(
      String username,
      String date,
      String vehicleNo,
      String timeStart,
      String odometerStart,
      String locationStart,
      String locationEnd,
      String purposeOfTrip,
      String classType,
      String vcRankFullName) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'INSERT INTO Logging ("UUID", "username", "date", "vehicleNo", "timeStart", "odometerStart", "locationStart", "locationEnd", "purposeOfTrip", "classType", "vcRankFullName") ' +
            "VALUES (uuid_generate_v4(),'" +
            username +
            "','" +
            date +
            "','" +
            vehicleNo +
            "','" +
            timeStart +
            "','" +
            odometerStart +
            "','" +
            locationStart +
            "','" +
            locationEnd +
            "','" +
            purposeOfTrip +
            "','" +
            classType +
            "','" +
            vcRankFullName +
            "');";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    // Get UUID to give Jovan
    var querystring2 = 'SELECT "UUID" FROM logging WHERE "username"=' "'" +
        username +
        "' AND " '"date" = ' "'" +
        date +
        "' AND " '"timeStart" = ' "'" +
        timeStart +
        "';";
    print("Query String: " + querystring2);
    var results2 = await connection.query(querystring2);
    print("Database Result: " + results2.toString());
    //Get Current Date and NextWPTDate for Vehicle
    DateTime currentDateTime = DateTime.now();
    var now = DateTime.parse(currentDateTime.toString());
    String lastWPTDate = now.day.toString().padLeft(2, '0') +
        "/" +
        now.month.toString().padLeft(2, '0') +
        "/" +
        now.year.toString();
    var nextWPTDateTime = now.add(Duration(days: 7));
    var nextWPTDate = nextWPTDateTime.day.toString().padLeft(2, '0') +
        "/" +
        nextWPTDateTime.month.toString().padLeft(2, '0') +
        "/" +
        nextWPTDateTime.year.toString();
    //Update Vehicle In use and WPT Dates
    var querystring3 =
        'UPDATE vehicles SET "inUse" = ' "'true', " '"lastWPTDate" = ' "'" +
            lastWPTDate +
            "', " '"nextWPTDate" = ' "'" +
            nextWPTDate +
            "' WHERE " '"vehicleNo" = ' "'" +
            vehicleNo +
            "';";
    print("Query String: " + querystring3);
    var results3 = await connection.query(querystring3);
    print("Database Result: " + results3.toString());
    //Update driver inUse to true
    var querystring4 =
        'UPDATE users SET "inUse" = ' "'true' WHERE " '"username" = ' "'" +
            username +
            "';";
    print("Query String: " + querystring4);
    var results4 = await connection.query(querystring4);
    print("Database Result: " + results4.toString());
    //Update Veh Com inUse to true
    if (vcRankFullName != '') {
      var vcFullName =
          vcRankFullName.substring(vcRankFullName.split(' ')[0].length);
      var querystring5 =
          'UPDATE users SET "inUse" = ' "'true' WHERE " '"fullName" = ' "'" +
              vcFullName +
              "';";
      print("Query String: " + querystring5);
      var results5 = await connection.query(querystring5);
      print("Database Result: " + results5.toString());
    }
    var rawValue = results2.toString();
    var value = rawValue.substring(2, rawValue.length - 2);
    connection.close();
    return value;
  }

  Future<void> endTrip(
      String UUID, String mileage, String timeEnd, String odometerEnd) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring4point5;
    var querystring5;
    var querystring = "UPDATE logging " +
        'SET "timeEnd" = ' "'" +
        timeEnd +
        "', " '"odometerEnd" = ' "'" +
        odometerEnd +
        "', " '"mileage" = ' "'" +
        mileage.toString() +
        "' WHERE " '"UUID" = ' "'" +
        UUID +
        "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    //Get Vehicle Number and Class Type using UUID
    var querystring2 =
        'SELECT "vehicleNo", "classType" FROM logging WHERE "UUID"=' "'" +
            UUID +
            "';";
    print("Query String: " + querystring2);
    var results2 = await connection.query(querystring2);
    print("Database Result: " + results2.toString()); // [[41556, 3]]
    var vehNo = results2.toString().split(',')[0].substring(2);
    var classType = results2.toString().split(',')[1].substring(1, 2);
    // Set inUse to false for Vehicles
    var querystring3 =
        'UPDATE vehicles SET "inUse" = ' "'false' WHERE " '"vehicleNo" = ' "'" +
            vehNo +
            "';";
    print("Query String: " + querystring3);
    var results3 = await connection.query(querystring3);
    print("Database Result: " + results3.toString());
    //Get username from logging using UUID
    var querystring4 =
        'SELECT "username" FROM logging WHERE "UUID"=' "'" + UUID + "';";
    print("Query String: " + querystring4);
    var results4 = await connection.query(querystring4);
    print("Database Result: " + results4.toString());
    var username =
        results4.toString().substring(2, results4.toString().length - 2);
    //Get old mileage from users using username
    if (classType == '3') {
      querystring4point5 =
          'SELECT "totalClass3Mileage" FROM Users WHERE "username"=' "'" +
              username +
              "';";
    } else {
      querystring4point5 =
          'SELECT "totalClass4Mileage" FROM Users WHERE "username"=' "'" +
              username +
              "';";
    }
    print("Query String: " + querystring4point5);
    var results4point5 = await connection.query(querystring4point5);
    print("Database Result: " + results4point5.toString());
    var oldMileage = results4point5
        .toString()
        .substring(2, results4point5.toString().length - 2);
    //Update driver inUse to false and mileage update
    if (classType == '3') {
      querystring5 = 'UPDATE users SET "inUse" = '
              "'false', "
              '"totalClass3Mileage" = '
              "'" +
          (int.parse(oldMileage) + int.parse(mileage)).toString() +
          "' WHERE " '"username" = ' "'" +
          username +
          "';";
    } else {
      querystring5 = 'UPDATE users SET "inUse" = '
              "'false', "
              '"totalClass4Mileage" = '
              "'" +
          (int.parse(oldMileage) + int.parse(mileage)).toString() +
          "' WHERE " '"username" = ' "'" +
          username +
          "';";
    }
    print("Query String: " + querystring5);
    var results5 = await connection.query(querystring5);
    print("Database Result: " + results5.toString());
    //Get VC fullname from logging table
    var querystring6 =
        'SELECT "vcRankFullName" FROM logging WHERE "UUID"=' "'" + UUID + "';";
    print("Query String: " + querystring6);
    var results6 = await connection.query(querystring6);
    print("Database Result: " + results6.toString());
    // if there is a Veh Com
    if (results6.toString() != "[[]]") {
      var vcRankFullName =
          results6.toString().substring(2, results6.toString().length - 2);
      //Update Veh Com inUse to false
      var vcFullName =
          vcRankFullName.substring(vcRankFullName.split(' ')[0].length);
      var querystring7 =
          'UPDATE users SET "inUse" = ' "'false' WHERE " '"fullName" = ' "'" +
              vcFullName +
              "';";
      print("Query String: " + querystring7);
      var results7 = await connection.query(querystring7);
      print("Database Result: " + results7.toString());
    }
    connection.close();
  }

  Future<bool> checkDataExist(String table, String column, String data) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring = 'SELECT "' + column + '" FROM ' + table + ';';
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    var value = [];
    results.forEach((row) {
      value.add(row);
    });
    for (int i = 0; i < value.length; i++) {
      if ("[" + data + "]" == value[i].toString()) {
        connection.close();
        return true;
      }
    }
    connection.close();
    return false;
  }

  Future<List<dynamic>> multiDataPullColumn(String table, String column) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring = 'SELECT "' + column + '" FROM ' + table + ';';
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    var value = [];
    results.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      value.add(row);
    });
    connection.close();
    return value;
  }

  Future<List<dynamic>> multiDataPullRow(String table, String columnIdentifier,
      String columnIdentifierValue) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring = 'SELECT * FROM ' +
        table +
        ' WHERE "' +
        columnIdentifier +
        '" = ' "'" +
        columnIdentifierValue +
        "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    String values =
        results.toString().substring(2, results.toString().length - 2);
    var trueresults = values.split(", ");
    connection.close();
    return trueresults;
  }

  Future<List<dynamic>> vehiclesBasedOnCarType(String carType) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'SELECT "vehicleNo" FROM vehicles WHERE "carType" = ' "'" +
            carType +
            "' AND " +
            '"inUse" = ' +
            "'false';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    var value = [];
    results.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      value.add(row);
    });
    connection.close();
    return value;
  }

  Future<List<List<dynamic>>> getMileageHistory(String username) async {
    var finallist = [[]];
    var count = 0;
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'SELECT "vehicleNo", "date", "odometerStart", "odometerEnd", "mileage" FROM logging WHERE "username" = '
                "'" +
            username +
            "' AND " +
            '"mileage" != ' +
            "'';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    results.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      var innerList = row.split(", ");
      finallist.add(innerList);
      count = count + 1;
    });
    finallist.removeAt(0);
    print("There are " + count.toString() + " mileage entries");
    connection.close();
    return finallist;
  }

  Future<List<String>> getAvailableVehCom() async {
    var finallist = [];
    var count = 0;
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'SELECT "rank", "fullName" FROM users WHERE "inUse" = ' "'false'" ';';
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    results.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      var innerList = row.split(", ");
      var rankName = innerList[0] + " " + innerList[1];
      finallist.add(rankName);
      count = count + 1;
    });
    print("There are " + count.toString() + " available Vehicle Commanders");
    List<String> _returnList =
        finallist.map((string) => string.toString()).toList();
    connection.close();
    return _returnList;
  }

  Future<List<String>> getAllUsers() async {
    var finallist = [];
    var count = 0;
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'SELECT "rank", "fullName" FROM users;';
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    results.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      var innerList = row.split(", ");
      var rankName = innerList[0] + " " + innerList[1];
      finallist.add(rankName);
      count = count + 1;
    });
    print("There are " + count.toString() + " Drivers");
    List<String> _returnList =
    finallist.map((string) => string.toString()).toList();
    connection.close();
    return _returnList;
  }

  Future<String> checkOngoingTrips(String username) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var UUID = "";
    var querystring = 'SELECT "UUID" FROM Logging WHERE' " username = '" +
        username +
        "' AND " '"odometerEnd" = ' "'';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());

    if (results.toString() == "[]") {
      UUID = results.toString().substring(1, results.toString().length - 1);
      print("Trip ongoing");
    } else if (results.toString() == "[[]]") {
      UUID = results.toString().substring(2, results.toString().length - 2);
      print("Trip ongoing");
    } else {
      print("No Ongoing Trips");
      return "";
    }
    connection.close();
    return UUID;
  }

  Future<List<List<dynamic>>> getGreenFileData(String username) async {
    var finallist = [[]];
    var count = 0;
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'SELECT "vehicleNo", "date", "odometerStart", "odometerEnd", "mileage", "classType" FROM logging WHERE "username" = '
                "'" +
            username +
            "' AND " +
            '"mileage" != ' +
            "'';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    results.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      var innerList = row.split(", ");
      finallist.add(innerList);
      count = count + 1;
    });
    finallist.removeAt(0);
    print("There are " + count.toString() + " mileage entries");
    if (count == 1) {
    } else if (count == 2) {
      var dateX = finallist[0][1].split('/');
      var datetimeX = DateTime.utc(dateX[2], dateX[1], dateX[0]);
      var dateY = finallist[1][1].split('/');
      var datetimeY = DateTime.utc(dateY[2], dateY[1], dateY[0]);
      if (datetimeX.compareTo(datetimeY) > 0) {
        var temp = finallist[0][1];
        finallist[0][1] = finallist[1][1];
        finallist[1][1] = temp;
      }
      for (int x = 0; x < finallist.length; x++) {
        var dateX = finallist[0][1].split('/');
        var dateY = finallist[1][1].split('/');
        var vehNoX = finallist[0][0];
        var vehNoY = finallist[1][0];
        var endOdometer = finallist[0][3];
        var startOdometer = finallist[1][2];
        if (dateX == dateY &&
            endOdometer == startOdometer &&
            vehNoY == vehNoX) {
          finallist[0][3] = finallist[1][3];
          finallist[0][4] =
              (int.parse(finallist[0][4]) + int.parse(finallist[1][4]))
                  .toString();
          finallist.removeAt(1);
        }
      }
    } else {
      for (int x = 0; x < finallist.length - 1; x++) {
        for (int y = 0; y < finallist.length - x - 1; y++) {
          var dateX = finallist[x][1].split('/');
          var datetimeX = DateTime.utc(dateX[2], dateX[1], dateX[0]);
          var dateY = finallist[x + 1][1].split('/');
          var datetimeY = DateTime.utc(dateY[2], dateY[1], dateY[0]);
          if (datetimeX.compareTo(datetimeY) > 0) {
            var temp = finallist[0][1];
            finallist[0][1] = finallist[1][1];
            finallist[1][1] = temp;
          }
        }
      }
      for (int x = 0; x < finallist.length - 1; x++) {
        for (int y = 0; y < finallist.length - x - 1; y++) {
          var dateX = finallist[x][1].split('/');
          var dateY = finallist[x + 1][1].split('/');
          var vehNoX = finallist[x][0];
          var vehNoY = finallist[x + 1][0];
          var endOdometer = finallist[x][3];
          var startOdometer = finallist[x + 1][2];
          if (dateX == dateY &&
              endOdometer == startOdometer &&
              vehNoY == vehNoX) {
            finallist[x][3] = finallist[x + 1][3];
            finallist[x][4] =
                (int.parse(finallist[x][4]) + int.parse(finallist[x + 1][4]))
                    .toString();
            finallist.removeAt(x + 1);
          }
        }
      }
    }
    connection.close();
    return finallist;
  }

  Future<List<List<String>>> getWPTVehicles() async {
    List<List<String>> finallist = [[]];
    DateTime currentDateTime = DateTime.now();
    var now = DateTime.parse(currentDateTime.toString());
    String lastWPTDate = now.day.toString().padLeft(2, '0') +
        "/" +
        now.month.toString().padLeft(2, '0') +
        "/" +
        now.year.toString();
    var nextWPTDateTime = now.add(Duration(days: 7));
    var nextWPTDate = nextWPTDateTime.day.toString().padLeft(2, '0') +
        "/" +
        nextWPTDateTime.month.toString().padLeft(2, '0') +
        "/" +
        nextWPTDateTime.year.toString();
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'SELECT "vehicleNo" FROM vehicles WHERE "nextWPTDate" = ' "'" +
            lastWPTDate +
            "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    List<String> innerList = [];
    var count = 0;
    results.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      innerList.add(row);
      count = count + 1;
    });
    finallist.add(innerList);
    print("There are " + count.toString() + " WPT1");
    var querystring2 =
        'SELECT "vehicleNo" FROM vehicles WHERE "nextWPTDate" = ' "'" +
            nextWPTDate +
            "';";
    print("Query String: " + querystring2);
    var results2 = await connection.query(querystring2);
    print("Database Result: " + results2.toString());
    List<String> innerList2 = [];
    var count2 = 0;
    results2.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      innerList2.add(row);
      count2 = count2 + 1;
    });
    finallist.add(innerList2);
    print("There are " + count2.toString() + " WPT2");
    connection.close();
    finallist.removeAt(0);
    return finallist;
  }

  Future<List<List<String>>> getAllVehicles() async {
    List<List<String>> finallist = [[]];
    var count = 0;
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring = 'SELECT * FROM vehicles;';
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    results.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      var innerList = row.split(", ");
      finallist.add(innerList);
      count = count + 1;
    });
    finallist.removeAt(0);
    print("There are " + count.toString() + " vehicles");
    connection.close();
    return finallist;
  }

  Future<void> createCheckInEntry(
      String username, String location, String status) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring = "";
    var querystring0 =
        'SELECT "rank" FROM Users WHERE' " username = '" + username + "';";
    print("Query String: " + querystring0);
    var results0 = await connection.query(querystring0);
    print("Database Result: " + results0.toString());
    var rank = results0.toString().substring(2, results0.toString().length - 2);
    DateTime currentDateTime = DateTime.now();
    var now = DateTime.parse(currentDateTime.toString());
    String currentDate = now.day.toString().padLeft(2, '0') +
        "/" +
        now.month.toString().padLeft(2, '0') +
        "/" +
        now.year.toString();
    String currentTime = now.hour.toString().padLeft(2, '0') +
        now.minute.toString().padLeft(2, '0') +
        now.second.toString().padLeft(2, '0');
    if (status == "OFF" ||
        status == "LEAVE" ||
        status == "MC" ||
        status == "MA" ||
        status == "RSO") {
      querystring =
          'INSERT INTO checkin ("UUID", "rank", "username", "location", "checkInDate", "checkInTime", "status", "checkOutDate", "checkOutTime","remarks") '
                  "VALUES (uuid_generate_v4(),'" +
              rank +
              "','" +
              username +
              "','" +
              location +
              "','" +
              currentDate +
              "','" +
              currentTime +
              "','" +
              status +
              "','" +
              currentDate +
              "','" +
              "235959" +
              "','');";
    } else {
      querystring =
          'INSERT INTO checkin ("UUID", "rank", "username", "location", "checkInDate", "checkInTime", "status", "checkOutDate", "checkOutTime", "remarks") '
                  "VALUES (uuid_generate_v4(),'" +
              rank +
              "','" +
              username +
              "','" +
              location +
              "','" +
              currentDate +
              "','" +
              currentTime +
              "','" +
              status +
              "','','','');";
    }
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    connection.close();
  }

  Future<void> checkOut(String username) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    DateTime currentDateTime = DateTime.now();
    var now = DateTime.parse(currentDateTime.toString());
    String currentDate = now.day.toString().padLeft(2, '0') +
        "/" +
        now.month.toString().padLeft(2, '0') +
        "/" +
        now.year.toString();
    String currentTime = now.hour.toString().padLeft(2, '0') +
        now.minute.toString().padLeft(2, '0') +
        now.second.toString().padLeft(2, '0');
    var querystring = "UPDATE checkin" +
        ' SET "checkOutDate" = ' +
        "'" +
        currentDate +
        "', " +
        '"checkOutTime" = ' +
        "'" +
        currentTime +
        "' WHERE " +
        '"checkOutTime" = ' +
        "'' AND " +
        '"username" = ' +
        "'" +
        username +
        "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    connection.close();
  }

  Future<List<List<String>>> getParadeState() async {
    List<List<String>> finallist = [[]];
    List<String> userlist = [];
    var count = 0;
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    DateTime currentDateTime = DateTime.now();
    var now = DateTime.parse(currentDateTime.toString());
    String currentDate = now.day.toString().padLeft(2, '0') +
        "/" +
        now.month.toString().padLeft(2, '0') +
        "/" +
        now.year.toString();
    String currentTime = now.hour.toString().padLeft(2, '0') +
        now.minute.toString().padLeft(2, '0') +
        now.second.toString().padLeft(2, '0');
    // Get those that check in
    var querystring =
        'SELECT "username", "location", "status" FROM checkin WHERE "checkInDate" = ' +
            "'" +
            currentDate +
            "'" +
            ';';
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    results.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      var innerList = row.split(", ");
      finallist.add(innerList);
      count = count + 1;
    });
    finallist.removeAt(0);
    print("There are " + count.toString() + " men that Checked In Today");
    // Get those that have not check out and did not check in today
    count = 0;
    var querystring2 =
        'SELECT "username", "location", "status" FROM checkin WHERE ("checkInDate" != ' +
            "'' AND " +
            '"checkInDate" = ' +
            "''" +
            ') AND "checkOutDate" = ' +
            "''" +
            ';';
    print("Query String: " + querystring2);
    var results2 = await connection.query(querystring2);
    print("Database Result: " + results2.toString());
    results2.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      var innerList = row.split(", ");
      finallist.add(innerList);
      count = count + 1;
    });
    print("There are " +
        count.toString() +
        " men that have not Checked Out (Stay In)");
    // Get those that never check in
    var querystring3 = 'SELECT "username" FROM users;';
    print("Query String: " + querystring3);
    var results3 = await connection.query(querystring3);
    print("Database Result: " + results3.toString());
    results3.forEach((rawRow) {
      var row = rawRow.toString().substring(1, rawRow.toString().length - 1);
      userlist.add(row);
    });
    for (int x = 0; x < userlist.length; x++) {
      bool checkedIn = false;
      for (int y = 0; y < finallist.length; y++) {
        if (finallist[y][0] == userlist[x]) {
          checkedIn = true;
        }
      }
      if (checkedIn == false) {
        finallist.add([userlist[x], "", ""]);
      }
    }
    connection.close();
    return finallist;
  }

  Future<String> checkCheckedIn(String username) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var result = "";
    var querystring =
        'SELECT "checkInDate" FROM checkin WHERE' " username = '" +
            username +
            "' AND " +
            '"checkOutDate" = ' +
            "'';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    if (results.toString() == "[]" || results.toString() == "[[]]") {
      var querystring2 =
          'SELECT "checkInDate" FROM checkin WHERE' " username = '" +
              username +
              "' AND " +
              '"checkInDate" = ' +
              "'" +
              dt.getCurrentDate() +
              "';";
      print("Query String: " + querystring2);
      var results2 = await connection.query(querystring2);
      print("Database Result: " + results2.toString());
      if (results2.toString() == "[]" || results2.toString() == "[[]]") {
        result = "NotCheckedIn";
        print("You have Not Checked In");
      } else {
        result = "CheckedOut";
        print("You have Checked Out for the day");
      }
    } else {
      result = "NotCheckedOut";
      print("You have not Checked Out");
    }
    connection.close();
    return result;
  }

  Future<void> changeAVIDate(String vehicleNo, String givenDate) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring2;
    var now = DateTime.now();
    if (givenDate != ""){
      var regenDate = givenDate.split("/")[2] + givenDate.split("/")[1] + givenDate.split("/")[0];
      now = DateTime.parse(regenDate);
    }
    String currentDate = now.day.toString().padLeft(2, '0') +
        "/" +
        now.month.toString().padLeft(2, '0') +
        "/" +
        now.year.toString();
    var querystring = 'SELECT "carType" FROM vehicles WHERE "vehicleNo" = '"'" +
        vehicleNo +
        "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    var carType =
        results.toString().substring(2, results.toString().length - 2);
    if (carType == "Grade 2" || carType == "Grade 3" || carType == "OUV") {
      var nextAVIDateTime = new DateTime(now.year, now.month + 12, now.day);
      var nextAVIDate = nextAVIDateTime.day.toString().padLeft(2, '0') +
          "/" +
          nextAVIDateTime.month.toString().padLeft(2, '0') +
          "/" +
          nextAVIDateTime.year.toString();
      querystring2 = 'UPDATE vehicles SET "lastAVIDate" = ' +
          "'" +
          currentDate +
          "'" +
          '"nextAVIDate" = ' +
          "'" +
          nextAVIDate +
          "' WHERE " '"vehicleNo" = ' "'" +
          vehicleNo +
          "';";
    } else {
      var nextAVIDateTime;
      if (now.day == 31) {
        nextAVIDateTime = new DateTime(now.year, now.month + 6, 30);
      }
      nextAVIDateTime = new DateTime(now.year, now.month + 6, now.day);
      var nextAVIDate = nextAVIDateTime.day.toString().padLeft(2, '0') +
          "/" +
          nextAVIDateTime.month.toString().padLeft(2, '0') +
          "/" +
          nextAVIDateTime.year.toString();
      querystring2 = 'UPDATE vehicles SET "lastAVIDate" = ' +
          "'" +
          currentDate +
          "'" +
          '"nextAVIDate" = ' +
          "'" +
          nextAVIDate +
          "' WHERE " '"vehicleNo" = ' "'" +
          vehicleNo +
          "';";
    }
    print("Query String: " + querystring2);
    var results2 = await connection.query(querystring2);
    print("Database Result: " + results2.toString());
    connection.close();
  }

  Future<void> createIncidentReport(String username, String vehicleNo,
      String date, String time, String reportType, String report) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring =
        'INSERT INTO incidentReport ("UUID", "username", "vehicleNo", "date", "time", "reportType", "report") '
                "VALUES (uuid_generate_v4(),'" +
            username +
            "','" +
            vehicleNo +
            "','" +
            date +
            "','" +
            time +
            "','" +
            reportType +
            "','" +
            report +
            "');";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    connection.close();
  }

  Future<List<String>> checkStatus(String username) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring2;
    var querystring =
        'SELECT "checkOutDate" FROM checkin WHERE' " username = '" +
            username +
            "'" +
            ' AND "checkInDate" = ' +
            "'" +
            dt.getCurrentDate() +
            "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    if (results.toString() == "[]" || results.toString() == "[[]]") {
      querystring2 =
          'SELECT "checkInDate", "checkInTime", "location", "status" FROM checkin WHERE'
                  " username = '" +
              username +
              "'" +
              ' AND "checkOutDate" = ' +
              "'" +
              "';";
    } else {
      querystring2 =
          'SELECT "checkInDate", "checkInTime", "location", "status", "checkOutDate", "checkOutTime" FROM checkin WHERE'
                  " username = '" +
              username +
              "'" +
              ' AND "checkInDate" = ' +
              "'" +
              dt.getCurrentDate() +
              "';";
    }
    print("Query String: " + querystring2);
    var results2 = await connection.query(querystring2);
    print("Database Result: " + results2.toString());
    List<String> finallist = results2
        .toString()
        .substring(2, results2.toString().length - 2)
        .split(", ");
    if (finallist.length == 6) {
      finallist[5] = dt.convertDBTimetoTime(finallist[5]);
    }
    finallist[1] = dt.convertDBTimetoTime(finallist[1]);
    connection.close();
    return finallist;
  }

  Future<bool> checkOffPass(String username) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring = 'SELECT "remarks" FROM checkin WHERE "username" = ' "'" +
        username +
        "' AND " +
        '"checkInDate" = ' +
        "'" +
        dt.getCurrentDate() +
        "' AND " +
        '"status" = ' +
        "'OFF';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    connection.close();
    if (results.toString() != "[]") {
      return true; // Signed
    } else {
      return false; // Not Signed
    }
  }

  Future<void> signOffPass(String username) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring = 'UPDATE checkin SET "remarks" = ' +
        "'OFF'" +
        ' WHERE "username" = ' "'" +
        username +
        "' AND " +
        '"checkInDate" = ' +
        "'" +
        dt.getCurrentDate() +
        "' AND " +
        '"status" = ' +
        "'OFF';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    connection.close();
  }

  Future<void> changePMMonth(String vehicleNo,String givenDate) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var querystring2;
    var nextMonth;
    var now = DateTime.now();
    if (givenDate != ""){
      var regenDate = givenDate.split("/")[2] + givenDate.split("/")[1] + givenDate.split("/")[0];
      now = DateTime.parse(regenDate);
    }
    String currentMonth = now.month.toString();
    var querystring = 'SELECT "carType" FROM vehicles WHERE "vehicleNo" = '"'" +
        vehicleNo +
        "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    var carType =
    results.toString().substring(2, results.toString().length - 2);
    if (carType == "Grade 3" || carType == "GP Car") {
      if ((int.parse(currentMonth) + 6) > 12){
        nextMonth = int.parse(currentMonth) - 6;
      }
      else {
        nextMonth = int.parse(currentMonth) + 6;
      }
    }
    else if (carType == "CLR") {
      if ((int.parse(currentMonth) + 5) > 12){
        nextMonth = int.parse(currentMonth) - 7;
      }
      else {
        nextMonth = int.parse(currentMonth) + 5;
      }
    }
    else if (carType == "OUV") {
      if ((int.parse(currentMonth) + 3) > 12){
        nextMonth = int.parse(currentMonth) - 9;
      }
      else {
        nextMonth = int.parse(currentMonth) + 3;
      }
    }
    else {
      nextMonth = int.parse(currentMonth);
    }
    querystring2 = 'UPDATE vehicles SET "lastPMMonth" = ' +
        "'" +
        currentMonth +
        "'" +
        '"nextPMMonth" = ' +
        "'" +
        nextMonth.toString() +
        "' WHERE " '"vehicleNo" = ' "'" +
        vehicleNo +
        "';";
    print("Query String: " + querystring2);
    var results2 = await connection.query(querystring2);
    print("Database Result: " + results2.toString());
    connection.close();
  }

  Future<void> createDetail(String dateOfDetail, String typeOfDetail, String LTCorBPC,
      String rank, String fullName, String carPlate, String additionalPlate,
      String reportTo, String vehicleCommander, String timeDepart, String timeRTU) async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();

    /// Masked NRIC
    var querystring = 'SELECT "nricLast4Digits" FROM users WHERE "fullName" = '"'" + fullName + "';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    var maskedNRIC = "XXXXX" + results.toString().substring(2, results.toString().length - 2);

    /// Phone Number
    var querystring2 = 'SELECT "handphoneNumber" FROM users WHERE "fullName" = '"'" + fullName + "';";
    print("Query String: " + querystring2);
    var results2 = await connection.query(querystring2);
    print("Database Result: " + results2.toString());
    var phoneNumber = results2.toString().substring(2, results2.toString().length - 2);

    var querystring3 =
        'INSERT INTO detailing ("UUID", "dateOfIndent", "dateOfDetail", "typeOfDetail", "LTCorBPC", "rank", "fullName", "maskedNRIC", "phoneNumber", "carPlate", "additionalPlate", "reportTo", "vehicleCommander", "timeDepart", "timeRTU") '
            "VALUES (uuid_generate_v4(),'" +
            dt.getCurrentDate() +
            "','" +
            dateOfDetail +
            "','" +
            typeOfDetail +
            "','" +
            LTCorBPC +
            "','" +
            rank +
            "','" +
            fullName +
            "','" +
            maskedNRIC +
            "','" +
            phoneNumber +
            "','" +
            carPlate +
            "','" +
            additionalPlate +
            "','" +
            reportTo +
            "','" +
            vehicleCommander +
            "','" +
            timeDepart +
            "','" +
            timeRTU +
            "');";
    print("Query String: " + querystring3);
    var results3 = await connection.query(querystring3);
    print("Database Result: " + results3.toString());
    connection.close();
  }

  Future<String> getDetailsInLTC() async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var finalString = "0";
    var querystring =
        'SELECT "rank" FROM detailing WHERE "dateOfDetail"'" = '" +
            dt.getCurrentDate() +
            "' AND " +
            '"LTCorBPC" = ' +
            "'LTC';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    if (results.toString() == "[]" || results.toString() == "[[]]") {
      finalString = "0";
    }
    else {
      var count = 0;
      results.forEach((row) {
        count = count + 1;
      });
      finalString = count.toString();
    }
    connection.close();
    return finalString;
  }

  Future<String> getDetailsInBPC() async {
    var connection = new PostgreSQLConnection("116.89.31.147", 5667, "LTC",
        username: "LTCAppUser", password: "LTCuser123");
    await connection.open();
    var finalString = "0";
    var querystring =
        'SELECT "rank" FROM detailing WHERE "dateOfDetail"'" = '" +
            dt.getCurrentDate() +
            "' AND " +
            '"LTCorBPC" = ' +
            "'BPC';";
    print("Query String: " + querystring);
    var results = await connection.query(querystring);
    print("Database Result: " + results.toString());
    if (results.toString() == "[]" || results.toString() == "[[]]") {
      finalString = "0";
    }
    else {
      var count = 0;
      results.forEach((row) {
        count = count + 1;
      });
      finalString = count.toString();
    }
    connection.close();
    return finalString;
  }


}
