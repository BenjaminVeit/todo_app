import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_flutter/database/database_helper.dart';

import '../main.dart';

class addNewNote extends StatefulWidget {
  addNewNote({super.key});

  @override
  State<addNewNote> createState() => _addNewNoteState();
}

class _addNewNoteState extends State<addNewNote> {
  late TextEditingController _feedbackDescriptionController;
  late TextEditingController _feedbackTitleController;

  //FocusNode
  late FocusNode _descriptionFocusNode;

  final feedbackMaxLength = 90;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _feedbackDescriptionController = TextEditingController();
    _feedbackTitleController = TextEditingController();
    _descriptionFocusNode = FocusNode();
  }

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
                  CupertinoTextField(
                    //TODO: Wenn fertig, Focus auf die Beschreibung legen
                    placeholder: "Titel",
                    clearButtonMode: OverlayVisibilityMode.editing,
                    controller: _feedbackTitleController,
                    onSubmitted: (value) => _descriptionFocusNode.requestFocus(),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  StatefulBuilder(
                    builder: (context, builderSetState) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              CupertinoTextField(
                                //TODO: Wenn submitted bzw. fertig, dann Tastatur einfahren lassen
                                //TODO: Sollte eine Zeichen beschränkung eingegeben werden mit maximale Zeilen?
                                focusNode: _descriptionFocusNode,
                                placeholder: 'Beschreibung',
                                maxLines: 3,
                                maxLength: feedbackMaxLength,
                                controller: _feedbackDescriptionController,
                                onChanged: (value) => builderSetState(() {}),
                              ),
                              Text('${_feedbackDescriptionController.text.length} / $feedbackMaxLength'),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                  CupertinoButton(
                    onPressed: () {
                      //TODO: Wenn gedrückt, dann Eintrag in DB schreiben --> ggf. toast anzeigen lassen
                      database_helper.insertNote(_feedbackTitleController.text, _feedbackDescriptionController.text);
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
