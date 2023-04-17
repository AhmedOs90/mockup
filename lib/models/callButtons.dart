const String device_id = "device_id";
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

class CallButtons {
late String firstName, secondName, thirdName, firstDial, secondDial, thirdDial, firstRing, secondRing, thirdRing, buttonId;
late int deviceId;

CallButtons(
      this.deviceId,
      this.buttonId,
      this.firstName,
      this.firstDial,
      this.firstRing,
      this.secondName,
      this.secondDial,
      this.secondRing,
      this.thirdName,
      this.thirdDial,
      this.thirdRing);

CallButtons.a(){
  this.firstName = "";
  this.secondName = "";
  this.thirdName = "";
  this.firstDial = "";
  this.secondDial = "";
  this.thirdDial = "";
  this.firstRing = "";
  this.secondRing = "";
  this.thirdRing = "";
  this.deviceId= 0;
  this.buttonId = "";
}

fromMap(Map map){
  map[device_id] != null? this.deviceId = map[device_id]: this.deviceId = -1;
  map[button_id] != null? this.buttonId = map[button_id].toString(): this.buttonId = "";
  map[name1] != null? this.firstName = map[name1].toString(): this.firstName = "";
  map[name2] != null? this.secondName = map[name2].toString(): this.secondName = "";
  map[name3] != null? this.thirdName = map[name3].toString(): this.thirdName = "";
  map[dial1] != null?this.firstDial = map[dial1].toString():this.firstDial = "";
  map[dial2] != null? this.secondDial = map[dial2].toString(): this.secondDial = "";
  map[dial3] != null? this.thirdDial = map[dial3].toString(): this.thirdDial = "";
  map[rings1] != null? this.firstRing = map[rings1].toString(): this.firstRing = "";
  map[rings2] != null? this.secondRing = map[rings2].toString(): this.secondRing = "";
  map[rings3] != null? this.thirdRing = map[rings3].toString(): this.thirdRing = "";
}

toMap(){
  Map<String, dynamic> map = new Map();
  map[name1] = this.firstName;
  map[name2] =this.secondName;
  map[name3] =this.thirdName;
  map[dial1] = this.firstDial;
  map[dial2] = this.secondDial;
  map[dial3] = this.thirdDial;
  map[rings1] =this.firstRing;
  map[rings2] =this.secondRing;
  map[rings3] = this.thirdRing;
  map[device_id] = this.deviceId;
  map[button_id] = this.buttonId;
  return map;
}


}
