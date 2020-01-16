import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String linkTable = "linkTable";

final String idColumn = "idColumn";
final String urlColumn = "urlColumn";
final String titleColumn = "titleColumn";
final String phoneColumn = "phoneColumn";

class LinkHelper {

  static final LinkHelper _instance = LinkHelper.internal();

  factory LinkHelper() => _instance;

  LinkHelper.internal();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "linksnewtwo.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $linkTable($idColumn INTEGER PRIMARY KEY, $urlColumn TEXT, $titleColumn TEXT,"
            "$phoneColumn TEXT)"
      );
    });
  }

  Future<Link> saveLink(Link link) async {
    Database dbLink = await db;
    link.id = await dbLink.insert(linkTable, link.toMap());
    return link;
  }

  Future<Link> getLink(int id) async {
    Database dbLink = await db;
    List<Map> maps = await dbLink.query(linkTable,
      columns: [idColumn, urlColumn, titleColumn, phoneColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    if(maps.length > 0){
      return Link.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteLink(int id) async {
    Database dbLink = await db;
    return await dbLink.delete(linkTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateLink(Link link) async {
    Database dbLink = await db;
    return await dbLink.update(linkTable,
        link.toMap(),
        where: "$idColumn = ?",
        whereArgs: [link.id]);
  }

  Future<List> getAllLink() async {
    Database dbLink = await db;
    List listMap = await dbLink.rawQuery("SELECT * FROM $linkTable");
    List<Link> listLink = List();
    for(Map m in listMap){
      listLink.add(Link.fromMap(m));
    }
    return listLink;
  }

  Future<int> getNumber() async {
    Database dbLink = await db;
    return Sqflite.firstIntValue(await dbLink.rawQuery("SELECT COUNT(*) FROM $linkTable"));
  }

  Future close() async {
    Database dbLink = await db;
    dbLink.close();
  }

}

class Link {

  int id;
  String url;
  String title;
  String phone;

  Link();

  Link.fromMap(Map map){
    id = map[idColumn];
    url = map[urlColumn];
    title = map[titleColumn];
    phone = map[phoneColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      urlColumn: url,
      titleColumn: title,
      phoneColumn: phone,
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Link(id: $id, url: $url, title: $title, phone: $phone,)";
  }

}