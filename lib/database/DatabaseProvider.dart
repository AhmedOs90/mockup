import 'dart:math';

import 'package:sqflite/sqflite.dart';

import '../models/Alerts.dart';
import '../models/Authorized.dart';
import '../models/Device.dart';
import '../models/Entrance.dart';
import '../models/PinCodes.dart';
import '../models/Relays.dart';
import '../models/SMS.dart';
import '../models/callButtons.dart';

const String device_id = "device_id";
const String alert_id = "alert_id";
const String aux_id = "aux_id";
const String relay_id = "relay_id";
const String sms_id = "sms_id";

const String phone_dp = "phone";
const String name_dp = "name";
const String sms_dp = "sms";
const String serial_dp = "serial";

const String delay_dp = "delay";
const String mode_dp = "mode";
const String relay1_dp = "relay1";
const String relay2_dp = "relay2";
const String relay3_dp = "relay3";


const String button_id = "button_id";
const String name1 = "name1";
const String dial1 = "dial1";
const String rings1 = "rings1";
const String name2 = "name2";
const String dial2 = "dial2";
const String rings2 = "rings2";
const String name3 = "name3";
const String rings3 = "rings3";
const String dial3 = "dial3";

const String entrance_id = "entrance_id";
const String nameEntrance_dp = "name_entrance";
const String relay_dp = "relay";
const String date_dp = "date";
const String pin_code = "pin_code";
const String relay1 = "relay1";
const String relay2 = "relay2";
const String relay3 = "relay3";
const String table_alerts = "alerts";
const String table_callbuttons = "call_buttons";
const String table_authorized = "authorised";
const String table_entrance = "entrance";
final String tablePinCodes = "pin_codes";
final String tableSMS = "sms_sent";
final String tableRelays = "relays";

class DataBaseProvider{
  late Database db;


  /*
  OpenDatabase
   */
  Future open(String path) async {
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
  create table $tableDevices ( 
  $device_id integer primary key autoincrement, 
  $name_dp text,
  $serial_dp text,
  $phone_dp text,
  $sms_dp text)
''');
          await db.execute('''
  create table $table_alerts ( 
  $device_id integer not null, 
  $alert_id integer not null, 
  $aux_id integer not null, 
  $phone_dp text not null, 
  $name_dp text not null, 
  $sms_dp text not null, 
   PRIMARY KEY ($device_id, $alert_id, $aux_id))
''');
          await db.execute('''
create table $table_authorized ( 
  $device_id integer not null, 
  $phone_dp integer not null, 
  $name_dp integer not null, 
  $mode_dp text not null, 
  $relay1_dp text not null,
  $relay2_dp text not null, 
  $relay3_dp text not null,  
  $delay_dp text not null, 
   PRIMARY KEY ($device_id, $phone_dp))
''');
          await db.execute('''
create table $table_callbuttons ( 
  $device_id integer not null, 
  $button_id text not null, 
  $name1 text, 
  $dial1 text, 
  $rings1 text, 
  $name2 text, 
  $dial2 text, 
  $rings2 text, 
  $name3 text, 
  $dial3 text, 
  $rings3 text,
   PRIMARY KEY ($device_id, $button_id)
  )
''');
          await db.execute('''
create table $table_entrance ( 
  $entrance_id integer primary key autoincrement, 
  $device_id integer not null, 
  $phone_dp text not null, 
  $name_dp text not null, 
  $nameEntrance_dp text not null, 
  $mode_dp integer not null, 
  $relay_dp integer not null)
''');
          await db.execute('''
create table $tablePinCodes ( 
  $device_id integer not null, 
  $pin_code text not null,
  $relay1 text not null,
  $relay2 text not null,
  $relay3 text not null,
  PRIMARY KEY ($device_id, $pin_code)
  
  )
''');
          await db.execute('''
create table $tableRelays ( 
  $device_id integer not null, 
  $relay_id integer not null,
  $name_dp text not null,
  PRIMARY KEY ($device_id, $relay_id)
  
  )
''');
          await db.execute('''
create table $tableSMS ( 
  $device_id integer not null, 
  $sms_id integer not null,
  $date_dp text not null,
  $phone_dp text not null,
  $sms_dp text not null,
  PRIMARY KEY ($device_id, $sms_id)
  
  )
''');

        });
  }

    /*
  devices
   */
  Future<Device> insertDevice(Device device) async {
    device.deviceId = await db.insert(tableDevices, device.toMap());
    return device;
  }

  Future<Device?> getDevice(int id) async {
    Device device = Device.a();
    List<Map> maps = await db.query(tableDevices,
        columns: ['$device_id', '$name_dp', '$serial_dp','$phone_dp','$sms_dp'],
        where: '$device_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return device.fromMap(maps.first);
    }
    return null;
  }

  Future<List<Device>> getDevices() async {
    Device device = Device.a();
    List<Device> devices = [];
    List<Map> maps = await db.query(tableDevices,
      columns: ['$device_id', '$name_dp', '$serial_dp','$phone_dp','$sms_dp'],
    );
    print("Length: ");
    for (var map in maps){
      device.fromMap(map);
      print(device.deviceId);
      devices.add(device);
      device = Device.a();
    }
    return devices;
  }

  Future<int> deleteDevice(int id) async {
    print(id);
    return await db.delete(tableDevices, where: '$device_id = ?', whereArgs: [id],);
  }

  Future<int> updateDevice(Device device) async {
    print("id" +device.deviceId.toString());
    print("Called");
    return await db.update(tableDevices, device.toMap(),
        where: '$device_id = ?', whereArgs: [device.deviceId]);
  }


  /*
  Alerts
   */
  Future<Alerts> insertAlerts(Alerts alerts) async {
    alerts.deviceId = await db.insert(table_alerts, alerts.toMap());
    return alerts;
  }

  Future<Alerts?> getAlerts(int id) async {
    Alerts alerts = Alerts.a();
    List<Map> maps = await db.query(table_alerts,
        columns: ['$device_id', '$alert_id','$aux_id','$phone_dp','$name_dp',
          '$sms_dp'],
        where: '$device_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return alerts.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteAlerts(int id) async {
    return await db.delete(table_alerts, where: '$device_id = ?', whereArgs: [id]);
  }

  Future<int> updateAlerts(Alerts alerts) async {
    return await db.update(table_alerts, alerts.toMap(),
        where: '$device_id = ?', whereArgs: [alerts.deviceId]);
  }

  /*
  Authorized
   */
  Future<Authorized> insertAuthorized(Authorized authorized) async {
    authorized.deviceId = await db.insert(table_authorized, authorized.toMap());
    return authorized;
  }

  Future<List<Authorized>?> getAuthorizedList(int id) async {
    print("called1");
    Authorized authorized = Authorized.a();
    List<Authorized> authorizedList = [];
    List<Map> maps = await db.query(table_authorized,
        columns: ['$device_id', '$phone_dp','$name_dp','$mode_dp','$relay1_dp',
          '$relay2_dp','$relay3_dp','$delay_dp'],
        where: '$device_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      for(var map in maps){
        print(map);
        authorized.fromMap(map);
        authorizedList.add(authorized);
        authorized = Authorized.a();
      }
      return authorizedList;

    }
    return null;
  }

  Future<int> deleteAuthorized(int id, authPhone) async {
    return await db.delete(table_authorized, where: '$device_id = ? AND $phone_dp = ?', whereArgs: [id, authPhone]);
  }

  Future<int> updateAuthorized(Authorized authorized) async {
    return await db.update(table_authorized, authorized.toMap(),
        where: '$device_id = ? AND $phone_dp = ?', whereArgs: [authorized.deviceId, authorized.phone]);
  }

  /*
  CallButtons
   */
  Future<CallButtons> insertCallButtons(CallButtons callButtons) async {
    callButtons.deviceId = await db.insert(table_callbuttons, callButtons.toMap());
    return callButtons;
  }

   Future<List<CallButtons>?> getCallButtons(int id) async {
    CallButtons callButton = CallButtons.a();
    List<CallButtons> callButtons = [];
    print("id:" + id.toString());


    List<Map> maps = await db.query(table_callbuttons,
        columns: ['$device_id', '$button_id','$name1','$dial1','$rings1',
          '$name2','$dial2','$rings2','$name3','$dial3','$rings3'],
        where: '$device_id = ?',
        whereArgs: [id]
    );

    if (maps.length > 0) {
      for(var map in maps){
        print("Map:" + map.toString());

        callButton.fromMap(map);
        print("call: " + callButton.toString());

        callButtons.add(callButton);
        callButton = CallButtons.a();
      }
      return callButtons;
    }
    return null;
  }

  Future<int> deleteCallButtons(int id, button) async {
    return await db.delete(table_callbuttons, where: '$device_id = ? AND $button_id = ?', whereArgs: [id, button]);
  }

  Future<int> updateCallButtons(CallButtons callButtons) async {
    return await db.update(table_callbuttons, callButtons.toMap(),
        where: '$device_id = ?', whereArgs: [callButtons.deviceId]);
  }


  /*
  Entrance
   */
  Future<Entrance> insertEntrance(Entrance entrance) async {
    entrance.deviceId = await db.insert(table_entrance, entrance.toMap());
    return entrance;
  }

  Future<Entrance?> getEntrance(int id) async {
    Entrance entrance = Entrance.a();
    List<Map> maps = await db.query(table_entrance,
        columns: ['$entrance_id', '$device_id','$phone_dp','$name_dp','$nameEntrance_dp',
          '$mode_dp', '$relay_dp'],
        where: '$device_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return entrance.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteEntrance(int id) async {
    return await db.delete(table_entrance, where: '$device_id = ?', whereArgs: [id]);
  }

  Future<int> updateEntrance(Entrance entrance) async {
    return await db.update(table_entrance, entrance.toMap(),
        where: '$device_id = ?', whereArgs: [entrance.deviceId]);
  }

  /*
  PinCodes
   */
  Future<PinCodes> insertPinCodes(PinCodes pinCodes) async {
    pinCodes.deviceId = await db.insert(tablePinCodes, pinCodes.toMap());
    return pinCodes;
  }

  Future<List<PinCodes>?> getPinCodes(int id) async {

    PinCodes pinCode = PinCodes.a();
    List<PinCodes> pinCodes = [];
    List<Map> maps = await db.query(tablePinCodes,
        columns: ['$device_id', '$pin_code', '$relay1','$relay2','$relay3'],
        where: '$device_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      for(var map in maps){
        pinCode.fromMap(map);
        pinCodes.add(pinCode);
        pinCode = PinCodes.a();
      }
      return pinCodes;
    }
    return null;
  }

  Future<int> deletePinCodes(String code, int id,) async {
    return await db.delete(tablePinCodes, where: '$device_id = ? AND $pin_code = ?', whereArgs: [id , code]);
  }

  Future<int> updatePinCodes(PinCodes pinCodes, oldpin) async {
    return await db.update(tablePinCodes, pinCodes.toMap(),
        where: '$device_id = ? AND $pin_code = ?', whereArgs: [pinCodes.deviceId , oldpin]);
  }

  /*
  Relays
   */
  Future<Relays> insertRelays(Relays relays) async {
    relays.deviceId = await db.insert(tableRelays, relays.toMap());
    return relays;
  }

  Future<List<Relays>?> getRelays(int id) async {
    Relays relays = Relays.a();
    List<Relays> relayList = [];
    List<Map> maps = await db.query(tableRelays,
        columns: ['$device_id', '$relay_id', '$name_dp'],
        where: '$device_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      for (var map in maps){
        relays.fromMap(map);
        relayList.add(relays);
        relays = Relays.a();
      }
      return relayList;
    }
    return null;
  }

  Future<int> deleteRelays(int id) async {
    return await db.delete(tableRelays, where: '$device_id = ?', whereArgs: [id]);
  }

  Future<int> updateRelays(Relays relays) async {
    return await db.update(tableRelays, relays.toMap(),
        where: '$device_id = ? AND $relay_id = ?', whereArgs: [relays.deviceId, relays.relayId]);
  }

  /*
  SMS
   */
  Future<SMS> insertSMS(SMS sms) async {
    sms.deviceId = await db.insert(tableSMS, sms.toMap());
    return sms;
  }

  Future<SMS?> getSMS(int id) async {
    SMS sms = SMS.a();
    List<Map> maps = await db.query(tableSMS,
        columns: ['$device_id', '$sms_id', '$sms','$date_dp','$phone_dp'],
        where: '$device_id = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return sms.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteSMS(int id) async {
    return await db.delete(tableSMS, where: '$device_id = ?', whereArgs: [id]);
  }

  Future<int> updateSMS(SMS sms) async {
    return await db.update(tableSMS, sms.toMap(),
        where: '$device_id = ?', whereArgs: [sms.deviceId]);
  }

  Future close() async => db.close();


}