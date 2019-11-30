import 'package:flutter/material.dart';
import 'package:navigation_drawer/navigation_drawer.dart';
import 'package:navigation_drawer/navigation_drawer_item.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Drawer Demo',
      theme: ThemeData(
        primaryColor: Color(0xFF008376),
        scaffoldBackgroundColor: Color(0xFFfafafa),
        splashFactory: InkRipple.splashFactory,
      ),
      home: ExampleScreen(),
    );
  }
}

class ExampleScreen extends StatelessWidget {
  final drawerCtrl = new NavigationDrawerController();

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      controller: drawerCtrl,
      children: [
        UserAccountsDrawerHeader(
          accountEmail: Text('v.osovsky@mail.com'),
          accountName: Text('Vadim Osovsky'),
        ),
        NavigationDrawerItem(
          icon: Icon(Icons.account_circle),
          title: 'Profile',
        ),
        NavigationDrawerItem(
          icon: Icon(Icons.people),
          title: 'Friends',
          onPressed: (int i) async {
            print("VO: I dont have friends");
            return true;
          },
        ),
        NavigationDrawerItem(
          icon: Icon(Icons.dashboard),
          enabled: false,
          title: 'Dashboard',
        ),
        NavigationDrawerItem(
          icon: Icon(Icons.youtube_searched_for),
          title: 'Tools',
        ),
        Divider(),
        NavigationDrawerItem(
          icon: Icon(Icons.settings),
          title: 'Settings',
        ),
        NavigationDrawerItem(
          icon: Icon(Icons.exit_to_app),
          title: 'Log out',
        ),
      ],
      routeBuilder: (_, i) => Scaffold(
        appBar: AppBar(
          title: Text('Screen $i'),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => drawerCtrl.openDrawer(),
          ),
        ),
        body: Center(
            child: Text(
          'Screen $i',
          style: TextStyle(color: Colors.black45),
        )),
      ),
    );
  }
}
