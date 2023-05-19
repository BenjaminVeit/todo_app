import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_flutter/widgets/addNewNote.dart';
import 'package:notes_app_flutter/widgets/navDrawer.dart';

void main() {
  runApp(const MainApp());
}

/*
TODO:
- Datenbankanbindung erstellen vllt. zwei Tabellen, einmal mit ID Titel und dann FK auf andere Tabelle, welche ID, Titel, Beschreibung, Erstellt, Fertiggestellt? und Fertigstellungsdatum beinhaltet 
- Beim drücken auf erstellen muss der Eintrag in die DB geschrieben werden
- Beim build müssen alle Einträge aus der DB gelesen werden 
- Einstellungen für Darkmode?
- Wenn User auf Abgeschlossene Einträge geht, dann sollen hier alle gelistet werden, welche bei Fertiggestellt ein true haben
- Vielleicht vom Benutzer beim ersten mal starten einen Namen verlangen, welcher immer wieder verwendet wird um eine direkte Ansprache zu ermöglichen?
  

*/

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  final appName = "ToDo-App"; // current AppName
  @override
  Widget build(BuildContext context) {
    return Config(
      appName: appName,
      child: MaterialApp(
        title: appName,
        home: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

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
            onPressed: () => Navigator.of(context).push(CupertinoPageRoute(builder: (context) => const addNewNote())),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const CupertinoPageScaffold(
        child: Center(
          child: Text("Hallo"),
        ),
      ),
    );
  }
}

class Config extends InheritedWidget {
  final String appName;

  const Config({super.key, required this.appName, required Widget child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static Config? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Config>();
  }
}
