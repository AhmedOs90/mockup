const String device_id = "device_id";
const String delay_dp = "delay";
const String mode_dp = "mode";
const String phone_dp = "phone";
const String name_dp = "name";
const String relay1_dp = "relay1";
const String relay2_dp = "relay2";
const String relay3_dp = "relay3";


class Authorized {

  late String phone, name, relay1, relay2, relay3, mode;
  late int deviceId, delay;


  Authorized(this.deviceId, this.phone, this.name,this.mode, this.relay1, this.relay2,
      this.relay3, this.delay);

  Authorized.a(){
    this.deviceId=0; this.mode=""; this.delay=0;
    this.phone="";
    this.name="";
    this.relay1="";
    this.relay2="";
    this.relay3="";

  }

  fromMap(Map map){

    map[device_id] != null? this.deviceId = map[device_id]: this.deviceId = -1;print(1);
    map[mode_dp] != null? this.mode = map[mode_dp].toString(): this.mode = "0";print(2);
    map[delay_dp] != null? this.delay = int.parse(map[delay_dp].toString()): this.delay = 0;print(3);
    map[phone_dp] != null? this.phone = map[phone_dp].toString(): this.phone = "";print(4);
    map[name_dp] != null? this.name = map[name_dp].toString(): this.name = "";print(5);
    map[relay1_dp] != null?this.relay1 = map[relay1_dp].toString():this.relay1 = "";print(6);
    map[relay2_dp] != null? this.relay2 = map[relay2_dp].toString(): this.relay2 = "";print(7);
    map[relay3_dp] != null? this.relay3 = map[relay3_dp].toString(): this.relay3 = "";print(8);

  }

  toMap(){
    Map<String, dynamic> map = new Map();
    map[device_id] =this.deviceId;
    map[mode_dp] =this.mode;
    map[delay_dp] = this.delay;
    map[phone_dp] = this.phone;
    map[name_dp] = this.name;
    map[relay1_dp] = this.relay1;
    map[relay2_dp] = this.relay2;
    map[relay3_dp] = this.relay3;
    return map;
  }
}