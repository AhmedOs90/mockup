// entrance_id INTEGER PRIMARY KEY AUTOINCREMENT," +
// "device_id INTEGER NOT NULL," +
// "phone TEXT NOT NULL," +
// "name TEXT NOT NULL," +
// "name_entrance TEXT NOT NULL," +
// "mode INTEGER NOT NULL," +
// "relay INTEGER NOT NULL" +
const String entrance_id = "entrance_id";
const String device_id = "device_id";
const String mode_dp = "mode";
const String phone_dp = "phone";
const String name_dp = "name";
const String nameEntrance_dp = "name_entrance";
const String relay_dp = "relay";






class Entrance{
  late int entranceId, deviceId;
  late String phone, name, nameEntrance;
  late int mode, relay;

  Entrance(this.entranceId, this.deviceId, this.phone, this.name,
      this.nameEntrance, this.mode, this.relay);

  Entrance.a(){
    this.entranceId = 0;
    this.deviceId = 0;
    this.phone = "";
    this.name = "";
    this.nameEntrance = "";
    this.mode = 0;
    this.relay = 0;
  }
  fromMap(Map map){
    this.entranceId = map[entrance_id];
    this.deviceId = map[device_id];
    this.phone = map[phone_dp];
    this.name = map[name_dp];
    this.nameEntrance = map[nameEntrance_dp];
    this.mode = map[mode_dp];
    this.relay = map[relay_dp];
  }

  toMap(){
    Map<String, dynamic> map = new Map();
    map[entrance_id] =this.entranceId;
    map[device_id] =this.deviceId;
    map[phone_dp] = this.phone;
    map[name_dp] = this.name;
    map[nameEntrance_dp] = this.nameEntrance;
    map[mode_dp] = this.mode;
    map[relay_dp] = this.relay;
    return map;
  }

}