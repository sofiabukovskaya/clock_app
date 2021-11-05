import 'package:clock_app/app/data/models/alarm_info.dart';
import 'package:sqflite/sqflite.dart';

const String tableAlarm = 'alarm';
const String columnId = 'id';
const String columnTitle = 'title';
const String columnDate = 'alarmDateTime';
const String columnPending = 'isPending';
const String columnColorIndex = 'gradientColorIndex';

class AlarmDB {
  static Database? _database;
  static AlarmDB? _alarmDB;

  AlarmDB._createInstance();

  factory AlarmDB() {
    _alarmDB ??= AlarmDB._createInstance();
    return _alarmDB!;
  }

  Future<Database> get database async {
    // ignore: prefer_conditional_assignment
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    String direction = await getDatabasesPath();
    String path = direction + 'alarm.db';

    Future<Database> database =
        openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
          CREATE TABLE $tableAlarm ( 
          $columnId INTEGER PRIMARY KEY AUTOINCREMENT, 
          $columnTitle TEXT NOT NULL,
          $columnDate TEXT NOT NULL,
          $columnPending INTEGER,
          $columnColorIndex INTEGER)
        ''');
    });
    return database;
  }

  void insertAlarm(AlarmInfo alarmInfo) async {
    var db = await database;
    db.insert(tableAlarm, alarmInfo.toMap());
  }

  Future<List<AlarmInfo>> getAlarms() async {
    List<AlarmInfo> _alarms = [];

    var db = await database;
    var result = await db.query(tableAlarm);
    for (var element in result) {
      var alarmInfo = AlarmInfo.fromMap(element);
      _alarms.add(alarmInfo);
    }

    return _alarms;
  }

  Future<int> delete(int id) async {
    var db = await database;
    return await db.delete(tableAlarm, where: '$columnId = ?', whereArgs: [id]);
  }
}
