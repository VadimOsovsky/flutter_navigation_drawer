import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'navigation_drawer_item.dart';

class NavigationDrawer extends StatefulWidget {
  final NavigationDrawerController controller;
  final List<dynamic> children;
  final int initialIndex;
  final bool scrollable;
  final Widget Function(BuildContext, int) routeBuilder;

  const NavigationDrawer({
    @required this.controller,
    @required this.children,
    this.initialIndex = 0,
    this.scrollable = true,
    @required this.routeBuilder,
  }) : assert(children != null && routeBuilder != null && controller != null);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  int _currentIndex = 0;
  Widget _currentScreen;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex ?? 0;
    _currentScreen = widget.routeBuilder(context, _currentIndex);
  }

  List<Widget> _getChildren() {
    return widget.children.map((child) {
      if (child is Widget) {
        return child;
      } else if (child is NavigationDrawerItem) {
        final selected = child.index == _currentIndex;
        return Container(
          color: selected
              ? child.selectedBackgroundColor ??
                  Theme.of(context).disabledColor.withOpacity(0.1)
              : null,
          child: ListTile(
            dense: true,
            key: Key(child.index.toString()),
            selected: selected,
            title: Text(
              child.title,
              style: TextStyle(fontSize: 14.0),
            ),
            leading: selected && child.activeIcon != null
                ? child.activeIcon
                : child.icon,
            enabled: child.enabled,
            onTap: () async {
              final result = await child.onPressed?.call(child.index);
              if (result == false) return;
              Navigator.pop(context);
              setState(() {
                _currentIndex = child.index;
                _currentScreen = widget.routeBuilder(context, _currentIndex);
              });
            },
          ),
        );
      } else {
        throw "Navigation drawer child must be either a Widget or NavigationDrawerItem";
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final navItems = widget.children.where((c) => c is NavigationDrawerItem);
    navItems.forEach((c) {
      c.index = navItems.toList().indexOf(c);
    });

    return Scaffold(
      drawer: Drawer(
        child: widget.scrollable
            ? SingleChildScrollView(child: Column(children: _getChildren()))
            : Column(children: _getChildren()),
      ),
      body: LayoutBuilder(builder: (context, _) {
        widget.controller.openDrawer = Scaffold.of(context).openDrawer;
        widget.controller.isDrawerOpen = Scaffold.of(context).isDrawerOpen;
        return _currentScreen;
      }),
    );
  }
}

class NavigationDrawerController {
  void Function() openDrawer = () {};
  bool isDrawerOpen = false;
}
