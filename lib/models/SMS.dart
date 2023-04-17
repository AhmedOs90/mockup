

class SMS {
   late int smsId, deviceId;
  late String date, phone, sms;

  SMS(this.smsId, this.deviceId, this.date, this.phone, this.sms);

  SMS.a(){
    this.sms = "";
    this.date = "";
    this.phone = "";
    this.smsId = 0;
    this.deviceId = 0;


  }

  fromMap(Map map){
    this.sms = map["sms"];
    this.deviceId = map["device_id"];
    this.smsId = map["sms_id"];
    this.date = map["date"];
    this.phone = map["phone"];
  }

  toMap(){
    Map<String, dynamic> map = new Map();
    map["sms"] = this.sms;
    map["device_id"] = this.deviceId;
    map["date"] = this.date;
    map["sms_id"] = this.smsId;
    map["phone"] = this.phone;
    return map;
  }


}