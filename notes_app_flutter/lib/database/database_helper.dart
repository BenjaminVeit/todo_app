import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class database_helper {
// welche ID, Titel, Beschreibung, Erstellt, Fertiggestellt? und Fertigstellungsdatum beinhaltet
  late final int id;
  late final String title;
  late final String description;
  late final bool done;
  //database_helper(this.id, this.title, this.description, this.done);

  /**
   * Return an database connection
   */
  static Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todoEntrys.db');
    print("Path: $path");

    return openDatabase(
      path,
      // Set the path to the database. Note: Using the `join` function from the
      // `path` package is best practice to ensure the path is correctly
      // constructed for each platform.
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          'CREATE TABLE todoEntrys(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, description TEXT, done INTEGER)',
        );
      },
      version: 1,
    );
  }

  static Future<void> exampleUsage() async {
    final database = await _openDatabase();

    // Führe Operationen auf der Datenbank durch
    await database.insert('todoEntrys', {'title': 'Test', 'description': 'Test Beschreibung', 'done': 0});
    final result = await database.query('todoEntrys');
    print(result);

    // Schließe die Datenbankverbindung, wenn sie nicht mehr benötigt wird
    // Du kannst dies an anderer Stelle oder in einer "dispose" Methode aufrufen.
    // Dieses Beispiel zeigt, dass die Verbindung nach Abschluss der Operation geschlossen wird.
    await database.close();
  }
}
