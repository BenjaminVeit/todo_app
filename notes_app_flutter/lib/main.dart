import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_flutter/database/database_helper.dart';
import 'package:notes_app_flutter/widgets/addNewNote.dart';
import 'package:notes_app_flutter/widgets/navDrawer.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MainApp());
}

/*
TODO:
- Datenbankanbindung erstellen vllt. zwei Tabellen, einmal mit ID Titel und dann FK auf andere Tabelle, welche ID, Titel, Beschreibung, Erstellt, Fertiggestellt? und Fertigstellungsdatum beinhaltet 
- Beim drücken auf erstellen muss der Eintrag in die DB geschrieben werden
- Beim build müssen alle Einträge aus der DB gelesen werden 
- Einstellungen für Darkmode?
- Wenn User auf Abgeschlossene Einträge geht, dann sollen hier alle gelistet werden, welche bei Fertiggestellt ein true haben
- Vielleicht vom Benutzer beim ersten mal starten einen Namen verlangen, welcher immer wieder verwendet wird um eine direkte Ansprache zu ermöglichen?
  
Git local mit dem git remote verbinden

*/

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final appName = "ToDo-App";

  // current AppName
  @override
  Widget build(BuildContext context) {
    return Config(
      appName: appName,
      child: MaterialApp(
        title: appName,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });

  late List<Map<String, Object?>> allEntrys;

  @override
  Widget build(BuildContext context) {
    var appName = context.dependOnInheritedWidgetOfExactType<Config>()?.appName;
    return Scaffold(
      backgroundColor: CupertinoColors.secondarySystemBackground,
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: Text('$appName'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const addNewNote()));
              database_helper.exampleUsage();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
          future: _getEachEntryFromDB(),
          builder: (context, AsyncSnapshot<List<Map<String, Object?>>> snapshot) {
            if (snapshot.hasData) {
              allEntrys = snapshot.data!;
              return ListView.separated(
                  itemBuilder: (contex, index) => ListTile(
                        leading: Text("${allEntrys.elementAt(index)['id']}"),
                        title: Text("${allEntrys.elementAt(index)['title']}"),
                        onTap: () {},
                      ),
                  separatorBuilder: (context, _) => const Divider(),
                  itemCount: allEntrys.length);
            } else {
              return const Text("No data!");
            }
          }
          // child: ListView.separated(
          //     itemBuilder: (contex, index) => ListTile(
          //           title: Text("${allEntrys?.elementAt(index).values}"),
          //           onTap: () {},
          //         ),
          //     separatorBuilder: (context, _) => const Divider(),
          //     itemCount: allEntrys.length),
          ),
    );
  }

  Future<List<Map<String, Object?>>> _getEachEntryFromDB() async {
    return await database_helper.getAllEntrys();
  }
}

/**
 * 
 * ListView. separated (
  itemCount: items.length,
  itemBuilder: (context, index) => ListTile(
    title: Text(items.elementAt(index) + (++index).toString()),
    onTap: () {},
  ), 
  separatorBuilder: (context, _) => Divider(),
);

 */

class Config extends InheritedWidget {
  final String appName;

  const Config({super.key, required this.appName, required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static Config? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Config>();
  }
}
