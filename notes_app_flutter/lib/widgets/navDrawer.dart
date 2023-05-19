
import 'package:flutter/material.dart';
import 'package:notes_app_flutter/main.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    var appName = context.dependOnInheritedWidgetOfExactType<Config>()!.appName;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 116,
            child: DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: Center(
                child: Text(
                  appName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          const ListTile(
            leading: Icon(Icons.today),
            title: Text("Offene Aufgaben"),
          ),
          const ListTile(
            leading: Icon(Icons.done),
            title: Text("Abgeschlossene Aufgaben"),
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Einstellungen"),
          ),
        ],
      ),
    );
  }
}
