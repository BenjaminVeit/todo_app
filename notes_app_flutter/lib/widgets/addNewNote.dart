import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class addNewNote extends StatelessWidget {
  const addNewNote({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(context.dependOnInheritedWidgetOfExactType<Config>()!.appName),
          centerTitle: true,
        ),
        body: CupertinoPageScaffold(
          backgroundColor: CupertinoColors.secondarySystemBackground,
          child: Center(
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Neuer Eintrag',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const CupertinoTextField(
                    //TODO: Wenn fertig, Focus auf die Beschreibung legen
                    placeholder: "Titel",
                    clearButtonMode: OverlayVisibilityMode.editing,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const CupertinoTextField(
                    //TODO: Wenn submitted bzw. fertig, dann Tastatur einfahren lassen
                    //TODO: Sollte eine Zeichen beschränkung eingegeben werden mit maximale Zeilen?
                    //focusNode: _commentFocusNode,
                    placeholder: 'Beschreibung',
                    maxLines: 3,
                    //maxLength: feedbackMaxLength,
                    //controller: _feedbackTextController,
                    //onChanged: (value) => builderSetState(() {}),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  CupertinoButton(
                    onPressed: () {
                      //TODO: Wenn gedrückt, dann Eintrag in DB schreiben --> ggf. toast anzeigen lassen
                      Navigator.of(context).pop();
                    },
                    child: const Text('Erstellen'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
