import 'package:flutter/material.dart';
import 'package:interviews/contstants.dart';
import 'package:interviews/screens/chat_screen.dart';
import 'package:interviews/screens/home_page.dart';
import 'package:interviews/screens/location_screen.dart';
import 'package:interviews/screens/profile_screen.dart';

import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';



_MainNavigationPageState mainNavigationPageState = _MainNavigationPageState();

class MainNavigationPage extends StatefulWidget {
  static String routeName = "/main_page";


  MainNavigationPage({Key? key}) : super(key: key);

  @override
  _MainNavigationPageState createState() {
    mainNavigationPageState = _MainNavigationPageState();
    return mainNavigationPageState;
  }
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  late DateTime currentBackPressTime;
  bool hasReviewedApp=false;

  PersistentTabController? controller;
  TextStyle style = const TextStyle(fontSize: 12, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    currentBackPressTime = DateTime.now();
    controller = PersistentTabController(initialIndex: 0);



  }





  List<Widget> _buildScreens() {
    return [
      const HomePage(),
      const LocationScreen(),
       Container(),
      const ChatScreen(),
      const ProfileScreen(),
      //Container()

    ];
  }

  @override
  Widget build(BuildContext context) {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home_filled),
          title: "Home",
          //  textStyle: style,
          activeColorPrimary: kPrimaryIcon,
          inactiveColorPrimary: Colors.grey,
        ),PersistentBottomNavBarItem(
          icon: const Icon(Icons.location_on_outlined),
          title: "Location",
          //  textStyle: style,
          activeColorPrimary: kPrimaryIcon,
          inactiveColorPrimary: Colors.grey,
        ),PersistentBottomNavBarItem(
          icon: const Icon(Icons.add, color: Colors.white),
          activeColorPrimary: Colors.deepPurple,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.speaker_notes),
          title: "Chat",
          //  textStyle: style,
          activeColorPrimary: kPrimaryIcon,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          title: ("Profile"),
          //   textStyle: style,
          activeColorPrimary: kPrimaryIcon,
          inactiveColorPrimary: Colors.grey,
          routeAndNavigatorSettings: RouteAndNavigatorSettings(
            initialRoute: '/',
            routes: {
              '/first': (context) => const HomePage(),
              '/second': (context) => const LocationScreen(),
              '/third': (context) => const ChatScreen(),
              //'/fourth': (context) => const ProfileScreen(),
            },
          ),
        ),
        // PersistentBottomNavBarItem(icon: Icon(Icons.add))

      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      // backgroundColor: themeProvider.themeMode == ThemeModeOptions.dark
      //     ? kToggleDark
      //     :kLightAppbar, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        //colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15, // Choose the nav bar style with this property.
    );
  }
}
