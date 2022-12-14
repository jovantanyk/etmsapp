import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ltcapp/core/config/Globals.dart';
import 'package:intl/intl.dart';
import 'package:ltcapp/features/maintenance/view/pages/MaintenanceEditPage.dart';
import 'package:ltcapp/features/maintenance/view/pages/MaintenanceReportPage.dart';
import 'package:ltcapp/features/maintenance/view/pages/MaintenanceVehiclePage.dart';
import 'package:ltcapp/features/maintenance/view/pages/MaintenanceWPTPage.dart';
import 'package:ltcapp/features/maintenance/view/widgets/MaintenanceVehCard.dart';
import 'package:ltcapp/features/maintenance/viewmodel/MaintenanceMainViewModel.dart';
import 'package:stacked/stacked.dart';

class MaintenanceMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MaintenanceMainViewModel>.reactive(
        viewModelBuilder: () => MaintenanceMainViewModel(),
        builder: (context, model, child) {
          return Scaffold(
            backgroundColor: Theme.of(context).backgroundColor,
            appBar: AppBar(
              backgroundColor: darkGreenAccent,
              title: Text(
                "Maintenance Section",
                style: GoogleFonts.roboto(color: darkTextColor, fontSize: 24.0),
              ),
              centerTitle: true,
            ),
            body: getViewForIndex(model.currentTabIndex),
            bottomNavigationBar: BottomNavigationBar(
                elevation: 2,
                type: BottomNavigationBarType.fixed,
                currentIndex: model.currentTabIndex,
                backgroundColor: darkBackgroundColor,
                onTap: model.setTabIndex,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.borderAll), label: "Total"),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.wrench), label: "Edit"),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.square), label: "WPT"),
                  BottomNavigationBarItem(
                      icon: Icon(FontAwesomeIcons.flag), label: "Report"),
                ]),
          );
        });
  }

  final Map<int, Widget> _viewCache = Map<int, Widget>();
  Widget getViewForIndex(int index) {
    if (!_viewCache.containsKey(index)) {
      switch (index) {
        case 0:
          _viewCache[index] = MaintenanceVehiclePage();
          break;
        case 1:
          _viewCache[index] = MaintenanceEditPage();
          break;
        case 2:
          _viewCache[index] = MaintenanceWPTPage();
          break;
        case 3:
          _viewCache[index] = MaintenanceReportPage();
          break;
      }
    }

    return _viewCache[index]!;
  }


}
