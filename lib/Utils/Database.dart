import 'package:juste_livrer/Models/User.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, "justeLivrer.db");
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          '''CREATE TABLE Client (id INTEGER PRIMARY KEY autoincrement, ident TEXT, name TEXT, phone TEXT, prefix TEXT, picture TEXT, recovery TEXT, email TEXT, role TEXT )''');
    });
  }

  static String join(directoryPath, file) {
    return '$directoryPath/$file';
  }

  Future<int> updateName(String name) async {
    final db = await database;
    return await db.rawUpdate("UPDATE Client SET name = ?", [name]);
  }

  newClient(User newClient) async {
    final db = await database;
    var res = await db.rawInsert(
        "INSERT INTO Client (ident,name,phone,prefix,picture,recovery, email, role) VALUES (?,?,?,?,?,?,?,?)",
        [
          newClient.ident,
          newClient.name,
          newClient.phone,
          newClient.prefix,
          newClient.picture,
          newClient.recovery,
          newClient.email,
          newClient.role,
        ]);
    return res;
  }

  getClient() async {
    final db = await database;
    var res = await db.query("Client");
    List<User> list = res.map((c) => User.fromJsonLite(c)).toList();
    return list[list.length - 1];
  }

  delClient() async {
    final db = await database;
    db.delete("Client");
  }

  // update

  updateClient(String recovery, String id) async {
    final db = await database;
    var res = db.rawUpdate(
        "UPDATE Client SET recovery = ? WHERE ident = ?", [recovery, id]);
    return res;
  }

  updateClientWallet(int wallet, String id) async {
    final db = await database;
    var res = db.rawUpdate(
        "UPDATE Client SET wallet = ? WHERE ident = ?", [wallet, id]);
    return res;
  }
}

// insert
// newClient(Client newClient) async {
//     final db = await database;
//     var res = await db.insert("Client", newClient.toMap());
//     return res;
//   }

// newClient(Client newClient) async {
//     final db = await database;
//     //get the biggest id in the table
//     var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Client");
//     int id = table.first["id"];
//     //insert to the table using the new id
//     var raw = await db.rawInsert(
//         "INSERT Into Client (id,first_name,last_name,blocked)"
//         " VALUES (?,?,?,?)",
//         [id, newClient.firstName, newClient.lastName, newClient.blocked]);
//     return raw;
//   }

// read
// getClient(int id) async {
//     final db = await database;
//     var res =await  db.query("Client", where: "id = ?", whereArgs: [id]);
//     return res.isNotEmpty ? Client.fromMap(res.first) : Null ;
//   }

// getBlockedClients() async {
//     final db = await database;
//     var res = await db.rawQuery("SELECT * FROM Client WHERE blocked=1");
//     List<Client> list =
//         res.isNotEmpty ? res.toList().map((c) => Client.fromMap(c)) : null;
//     return list;
//   }
// blockOrUnblock(Client client) async {
//     final db = await database;
//     Client blocked = Client(
//         id: client.id,
//         firstName: client.firstName,
//         lastName: client.lastName,
//         blocked: !client.blocked);
//     var res = await db.update("Client", blocked.toMap(),
//         where: "id = ?", whereArgs: [client.id]);
//     return res;
//   }

// Delete
// deleteClient(int id) async {
//     final db = await database;
//     db.delete("Client", where: "id = ?", whereArgs: [id]);
//   }

// deleteAll() async {
//     final db = await database;
//     db.rawDelete("Delete * from Client");
//   }
