import 'package:sqflite/sqflite.dart';

final String tableWifi = 'wifi';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnDone = 'done';

class WifiSpeed {
  int id;
  double downloadSpeed;
  double uploadSpeed;
  DateTime createdAt = DateTime.now();
  String isp = ' ';
  String name;
  String ipAddress;
  String server = ' ';
  String device;

  WifiSpeed({this.downloadSpeed, this.uploadSpeed, this.isp, this.name,
    this.ipAddress, this.server, this.device });

  Map<String, Object> toMap() {
    return {
      'id': id,
      'downloadSpeed': downloadSpeed,
      'uploadSpeed': uploadSpeed,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'isp': isp,
      'name': name,
      'ipAddress': ipAddress,
      'server': server,
      'device': device,
    };
  }

  WifiSpeed.fromMap(Map<String, Object> map) {
    id = map['id'];
    downloadSpeed = map['downloadSpeed'];
    uploadSpeed = map['uploadSpeed'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(map['createdAt']);
    isp = map['isp'];
    name = map['name'];
    ipAddress = map['ipAddress'];
    server = map['server'];
    device = map['device'];
  }


  static List<String> getAttrs(){
    return ['id', 'downloadSpeed', 'uploadSpeed', 'createdAt', 'isp', 'name',
      'ipAddress', 'server', 'device'];
  }

}

class WifiSpeedProvider{
  Database db;

  Future open(String path) async {
    var databasesPath = await getDatabasesPath();
    // String path = join(databasesPath, 'demo.db');
    print(databasesPath);

    // await deleteDatabase(path);

    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
              create table $tableWifi ( 
                id integer primary key autoincrement, 
                downloadSpeed double not null,
                uploadSpeed double not null,
                createdAt integer not null,
                isp text,
                name text,
                ipAddress text,
                server text,
                device text)
              ''');
        });
  }

  Future<WifiSpeed> insert(WifiSpeed wifiSpeed) async {
    wifiSpeed.id = await db.insert(tableWifi, wifiSpeed.toMap());
    return wifiSpeed;
  }

  Future<WifiSpeed> getWifi(int id) async {
    List<Map> maps = await db.query(tableWifi,
        columns: WifiSpeed.getAttrs(),
        where: 'id = ?',
        whereArgs: [id]);

    if (maps.length > 0) {
      return WifiSpeed.fromMap(maps.first);
    }
    return null;
  }

  Future<List<WifiSpeed>> getAll() async {
    List<Map> maps = await db.query(tableWifi,
        columns: WifiSpeed.getAttrs(),);

    List<WifiSpeed> wifiSpeeds = maps.map((wifiSpeed) => WifiSpeed.fromMap(wifiSpeed)).toList();
    return wifiSpeeds;
  }


  Future<int> delete(int id) async {
    return await db.delete(tableWifi, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteAll() async {
    return await db.delete(tableWifi);
  }

  Future<int> update(WifiSpeed wifiSpeed) async {
    return await db.update(tableWifi, wifiSpeed.toMap(),
        where: 'id = ?', whereArgs: [wifiSpeed.id]);
  }

  Future close() async => db.close();

}

