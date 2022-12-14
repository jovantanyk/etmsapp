import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltcapp/core/config/Globals.dart';
import 'package:intl/intl.dart';
import 'package:ltcapp/features/admin/view/widgets/ParadeStateCard.dart';
import 'package:ltcapp/features/admin/viewmodel/ParadeStateViewModel.dart';
import 'package:ltcapp/features/maintenance/view/widgets/MaintenanceVehCard.dart';
import 'package:ltcapp/features/maintenance/viewmodel/MaintenanceMainViewModel.dart';
import 'package:stacked/stacked.dart';

class ParadeStatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ParadeStateViewModel>.reactive(
        viewModelBuilder: () => ParadeStateViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              title: Text(
                "Parade State",
                style: GoogleFonts.roboto(color: darkTextColor, fontSize: 24.0),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: ListView.builder(
                      itemCount: model.fetchingParadeState || model.fetchedParadeState.isEmpty
                          ? 0
                          : model.fetchedParadeState.length,
                      itemBuilder: (context, index) {
                        final item = model.fetchedParadeState[index];
                        return ParadeStateCard(
                          username: item[3],
                          location: item[1],
                          status: item[2],
                          value: model.statusValue,
                          values: model.statusList,
                          onChanged: (value) => model.onEditStatus(value, item[0]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => model.sendParadeState(context),
              backgroundColor: darkGreenAccent,
              label: Text('Send Parade State'),
              icon: Icon(FontAwesomeIcons.calendarWeek),
            ),
          );
        });
  }
}
