

const String device_id = "device_id";
const String alert_id = "alert_id";
const String aux_id = "aux_id";
const String phone_dp = "phone";
const String name_dp = "name";
const String sms_dp = "sms";



class Alerts {
  // "device_id INTEGER NOT NULL," +
  // "alert_id INTEGER NOT NULL," +
  // "aux_id INTEGER NOT NULL," +
  // "phone TEXT NOT NULL," +
  // "name TEXT NOT NULL," +
  // "sms TEXT NOT NULL," +
  late int deviceId, alertId, auxId;
  late String phone, name, sms;

  Alerts(
      this.deviceId, this.alertId, this.auxId, this.phone, this.name, this.sms);

  Alerts.a(){
    this.deviceId= 0;
    this.alertId= 0;
    this.auxId= 0;
    this.phone= "";
    this.name= "";
    this.sms= "";
  }

  fromMap(Map map){
    this.deviceId = map[device_id];
    this.alertId = map[alert_id];
    this.auxId = map[aux_id];
    this.phone = map[phone_dp];
    this.name = map[name_dp];
    this.sms = map[sms_dp];

  }

  toMap(){
    Map<String, dynamic> map = new Map();
    map[device_id] =this.deviceId;
    map[alert_id] = this.alertId;
    map[aux_id] = this.auxId;
    map[phone_dp] = this.phone;
    map[name_dp] = this.name;
    map[sms_dp] =this.sms;
    return map;
  }



}