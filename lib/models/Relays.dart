const String device_id = "device_id";
const String relay_id = "relay_id";
const String delay_dp = "delay";
const String mode_dp = "mode";
const String phone_dp = "phone";
const String name_dp = "name";
const String relay1_dp = "relay1";
const String relay2_dp = "relay2";
const String relay3_dp = "relay3";



class Relays{
  // "device_id INTEGER," +
  // "relay_id INTEGER," +
  // "name TEXT," +
  // "PRIMARY KEY (device_id, relay_id)" +
  // ")";
  late int deviceId, relayId;
  late String name;

  Relays(this.deviceId, this.relayId, this.name);

  Relays.a(){
    this.deviceId = -1;
    this.relayId = -1;
    this.name = "";
  }
  fromMap(Map map){
    map[device_id] != null? this.deviceId = map[device_id]: this.deviceId = -1;print(1);
    map[relay_id] != null? this.relayId = map[relay_id]: this.relayId = -1;print(2);
    map[name_dp] != null? this.name = map[name_dp].toString(): this.name = "";print(5);
  }

  toMap(){
    Map<String, dynamic> map = new Map();
    map[device_id] = this.deviceId;
    map[relay_id] = this.relayId;
    map[name_dp] = this.name;
    return map;
  }
}
