
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltcapp/core/config/Globals.dart';
import 'package:intl/intl.dart';
import 'package:ltcapp/features/maintenance/view/widgets/MaintenanceVehCard.dart';
import 'package:ltcapp/features/maintenance/view/widgets/MaintenanceWPTCard.dart';
import 'package:ltcapp/features/maintenance/viewmodel/MaintenanceMainViewModel.dart';
import 'package:ltcapp/features/maintenance/viewmodel/MaintenanceWPTViewModel.dart';
import 'package:stacked/stacked.dart';

class MaintenanceWPTPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MaintenanceWPTViewModel>.reactive(
        viewModelBuilder: () => MaintenanceWPTViewModel(),
        builder: (context, model, child) {
          return Column(
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "WPT 1",
                  style: GoogleFonts.roboto(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                    itemCount: model.fetchingWPT || model.isWPTEmpty
                        ? 0
                        : model.wptLength,
                    itemBuilder: (context, index) {
                      final item = model.fetchedWPT[0][index];
                      return MaintenanceWPTCard(
                        vehicleNo: item,
                        onEdit: (context) {
                          ///Todo edit function
                        },
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    "WPT 2",
                    style: GoogleFonts.roboto(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                    itemCount: model.fetchingWPT || model.isWPT2Empty
                        ? 0
                        : model.wptLength,
                    itemBuilder: (context, index) {
                      final item = model.fetchedWPT[1][index];
                      return MaintenanceWPTCard(
                        vehicleNo: item,
                        onEdit: (context) {
                          ///Todo edit function
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }
}
