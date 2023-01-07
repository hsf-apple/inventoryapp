import 'package:flutter/material.dart';

import 'package:line_icons/line_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../About/AboutScreenAdmin.dart';
import '../DataMainPage/AdminMainPage.dart';


class NavBarAdmin extends StatefulWidget {
  const NavBarAdmin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavBarAdminState createState() => _NavBarAdminState();
}

class _NavBarAdminState extends State<NavBarAdmin> {
  final PersistentTabController _controller =
  PersistentTabController(initialIndex: 0);

//Screens for each nav items.
  List<Widget> _navScreens() {
    return [

      // const EquipmentList(),
      const AdminMainPage(),

      // ///test template
      // const AcknowledgmentDelivery(),

      const AboutScreenAdmin(),


      // const ConfirmCartScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(LineIcons.home),
        title: ("admin homepage"),
        activeColorPrimary: Colors.white,
        inactiveColorPrimary: Colors.black,
        activeColorSecondary: Colors.black,
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(LineIcons.alternativeTrashRestore),
      //   title: ("equipment form"),
      //   activeColorPrimary: Colors.white,
      //   inactiveColorPrimary: Colors.black,
      //   activeColorSecondary: Colors.black,
      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(LineIcons.cogs),
        title: ("acknowledge delivery"),
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
