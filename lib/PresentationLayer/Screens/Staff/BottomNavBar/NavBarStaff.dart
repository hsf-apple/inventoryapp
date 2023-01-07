import 'package:flutter/material.dart';
import 'package:inventoryapp/PresentationLayer/Screens/Staff/StaffHomeScreen.dart';
import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../About/AboutScreen.dart';
import '../DeliveryForm.dart';
import '../Equipment/EquipmentListUser.dart';





class NavBarStaff extends StatefulWidget {
  const NavBarStaff({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavBarStaffState createState() => _NavBarStaffState();
}

class _NavBarStaffState extends State<NavBarStaff> {
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

//Screens for each nav items.
  List<Widget> _navScreens() {
    return [

      const StaffHomeScreen(),

      const EquipmentListUser(),
      ///test template
      const AboutScreen()
      // const ConfirmCartScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(LineIcons.home),
        title: ("Home"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black,
        activeColorSecondary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(LineIcons.list),
        title: ("Equipment List"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black,
        activeColorSecondary: Colors.black,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(LineIcons.cogs),
        title: ("About"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black,
        activeColorSecondary: Colors.black,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: Center(
            child: PersistentTabView(
              context,
              screens: _navScreens(),
              controller: _controller,
              items: _navBarsItems(),
              confineInSafeArea: true,
              backgroundColor:  Colors.white,
              handleAndroidBackButtonPress: true,
              resizeToAvoidBottomInset: true,
              hideNavigationBarWhenKeyboardShows: true,
              stateManagement: true,
              decoration: const NavBarDecoration(
                //borderRadius: BorderRadius.circular(10.0),
              ),
              popAllScreensOnTapOfSelectedTab: true,
              navBarStyle: NavBarStyle.style13,
            )),
        onWillPop: () async => false);
  }
}
