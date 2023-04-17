
import 'package:sqflite/sqflite.dart';

final String tableDevices = "devices";

class Device{
 String?  name, serial, phone;
  int? sms, deviceId;
  Device(
       this.name, this.serial, this.phone);

  Device.a(){
    this.sms = -1;
    this.deviceId = -1;
    this.name ="";
    this.serial ="";
    this.phone ="";
  }

  fromMap(Map map){
    map["sms"]!= null?this.sms = map["sms"]: this.sms = -1;
    map["device_id"] != null? this.deviceId = map["device_id"]: this.deviceId = -1;
    map["name"] != null?    this.name = map["name"]: this.name = "";
    map["serial"] != null?this.serial = map["serial"]: this.serial = "";
    map["phone"] != null?this.phone = map["phone"]: this.phone = "";
  }

  toMap(){
    Map<String, dynamic> map = new Map();
    this.sms !=null? map["sms"] = this.sms:null;
    this.name!=null?map["name"] = this.name:null;
    this.serial !=null?map["serial"] = this.serial:null;
    this.phone !=null?map["phone"] = this.phone:null;
    this.deviceId != null? map["device_id"] = deviceId:null;
    return map;
  }


}


