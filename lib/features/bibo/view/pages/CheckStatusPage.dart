import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ltcapp/core/config/Globals.dart';
import 'package:intl/intl.dart';
import 'package:ltcapp/features/bibo/view/widgets/CheckStatusCard.dart';
import 'package:ltcapp/features/bibo/viewmodel/CheckStatusViewModel.dart';
import 'package:ltcapp/features/bibo/viewmodel/CheckInViewModel.dart';
import 'package:ltcapp/features/bibo/viewmodel/CheckOutViewModel.dart';
import 'package:stacked/stacked.dart';

class CheckStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CheckStatusViewModel>.reactive(
      viewModelBuilder: () => CheckStatusViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              "You have checked out",
              style: TextStyle(color: darkTextColor),
            ),
            centerTitle: true,
            leading: GestureDetector(
              onTap: () => {
                Navigator.pop(context),
              },
              child: Icon(
                Icons.arrow_back_rounded,
                color: Colors.black,
              ),
            ),
            backgroundColor: darkGreenAccent,
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CheckInStatusCard(
                    checkInTime: model.fetchingStatus || model.fetchedStatus.isEmpty ? '' : model.fetchedStatus[1].toString(),
                    checkInDate:  model.fetchingStatus || model.fetchedStatus.isEmpty ? '' : model.fetchedStatus[0].toString(),
                    location:  model.fetchingStatus || model.fetchedStatus.isEmpty ? '' : model.fetchedStatus[2].toString(),
                    status:  model.fetchingStatus || model.fetchedStatus.isEmpty ? '' : model.fetchedStatus[3].toString(),
                    checkOutDate:  model.fetchingStatus || model.fetchedStatus.isEmpty ? '' : model.fetchedStatus[4].toString(),
                    checkOutTime:  model.fetchingStatus || model.fetchedStatus.isEmpty ? '' : model.fetchedStatus[5].toString(),
                    nric:  model.fetchingStatus || model.fetchedStatus.isEmpty ? '' : model.fetchedStatus[6].toString(),
                  ),
                  _backButton(context, model),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _backButton(BuildContext context, CheckStatusViewModel model) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: InkWell(
        onTap: () => model.backPush(context),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          padding: EdgeInsets.symmetric(vertical: 13),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(24)),
            color: darkGreenAccent,
          ),
          child: Text(
            'Back to home',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
