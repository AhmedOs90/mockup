// "device_id INTEGER NOT NULL," +
// "pin_code TEXT NOT NULL," +
// "relay1 TEXT," +
// "relay2 TEXT," +
// "relay3 TEXT," +
// "PRIMARY KEY (device_id, pin_code)" +
// ")";

const String device_id = "device_id";
const String pin_code = "pin_code";
const String relay1 = "relay1";
const String relay2 = "relay2";
const String relay3 = "relay3";


class PinCodes {
  late int deviceId;
  late String pinCode, firstRelay1, secondRelay2, thirdRelay3;

  PinCodes(this.deviceId, this.pinCode, this.firstRelay1, this.secondRelay2, this.thirdRelay3);

  PinCodes.a(){
    this.deviceId = -1; this.pinCode = ""; this.firstRelay1 = ""; this.secondRelay2 = ""; this.thirdRelay3= "";
  }

  fromMap(Map map){

    map[device_id] != null? this.deviceId = map[device_id]: this.deviceId = -1;
    map[pin_code] != null? this.pinCode = map[pin_code].toString(): this.pinCode = "";
    map[relay1] != null? this.firstRelay1 = map[relay1].toString(): this.firstRelay1 = "";
    map[relay2] != null? this.secondRelay2 = map[relay2].toString(): this.secondRelay2 = "";
    map[relay3] != null? this.thirdRelay3 = map[relay3].toString(): this.thirdRelay3 = "";
    }

  toMap(){
    Map<String, dynamic> map = new Map();
    map[device_id] = this.deviceId;
    map[pin_code] =this.pinCode;
    map[relay1] = this.firstRelay1;
    map[relay2] = this.secondRelay2;
    map[relay3] = this.thirdRelay3;
    return map;
  }
}