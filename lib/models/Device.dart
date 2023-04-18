
import 'package:sqflite/sqflite.dart';

final String tableDevices = "devices";

class Device{
 String?  name, serial, phone, sms;
  int? deviceId;
  Device(
       this.name, this.serial, this.phone);

  Device.a(){
    this.sms = "";
    this.deviceId = -1;
    this.name ="";
    this.serial ="";
    this.phone ="";
  }

  fromMap(Map map){
    map["sms"]!= null?this.sms = map["sms"]: this.sms = "";
    map["device_id"] != null? this.deviceId = map["device_id"]: this.deviceId = -1;
    map["name"] != null?    this.name = map["name"]: this.name = "";
    map["serial"] != null?this.serial = map["serial"]: this.serial = "";
    map["phone"] != null?this.phone = map["phone"]: this.phone = "";
  }

  toMap(){
    Map<String, dynamic> map = new Map();
    if(this.sms != null){
      print(1);
      map["sms"] = this.sms.toString();
    }
    if(this.name != null){
      print(2);
      map["name"] = this.name.toString();
    }
    if(this.serial != null){

      print(3);
      map["serial"] = this.serial.toString();
    }
    if(this.phone != null){
      print(4);
      map["phone"] = this.phone.toString();
    }
    if(this.deviceId != null){
      print(5);
      map["device_id"] = this.deviceId;
    }
    // this.sms !=null? map["sms"] = this.sms:null;
    // this.name!=null?map["name"] = this.name:null;
    // this.serial !=null?map["serial"] = this.serial:null;
    // this.phone !=null?map["phone"] = this.phone:null;
    // this.deviceId != null? map["device_id"] = deviceId:null;
    return map;
  }


}


