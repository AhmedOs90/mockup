
import 'package:flutter/material.dart';
import 'package:mockup/database/DatabaseProvider.dart';
import 'package:mockup/values.dart';

import '../models/Relays.dart';

class Prevalent{


  static String relay1 = "relay1";
  static String relay2 = "relay2";
  static String relay3 = "relay3";
  static showDialogue(context, msg){
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              content: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(PadValues.lessPad),
                    child: Image(image: AssetImage("assets/TickIcon.png"),
                      height: 30,
                      width: 30,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(msg),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(

                  onPressed: () =>
                  {
                    Navigator.pop(context),
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text("OK"),
                ),
              ],
            )
    );
  }

  static showSerialDialogue(context){
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            SimpleDialog(
              title: Text("You can find Serial Number on the main PCP", textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green),),
              children: <Widget>[
                Image(
                  image: AssetImage("assets/serialNumber.png"),
                  height: MediaQuery.of(context).size.height * .7,
                ),
                Padding(
                  padding: EdgeInsets.all(PadValues.mainPad),
                  child: Container(
                    height: 40,
                    child: ElevatedButton(

                      onPressed: () =>
                      {
                        Navigator.pop(context),
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                      child: Text("CLOSE"),
                    ),
                  ),
                ),
              ],
            )
    );
  }

  static Future<List<Relays>?> getRelaysFromDb(device) async {
    DataBaseProvider db = DataBaseProvider();
    await db.open("mockup_dp");
    List<Relays>? relayList = [];
    relayList = await db.getRelays(device.deviceId!);
    Prevalent.relay1 = relayList![0].name;
    Prevalent.relay2 = relayList![1].name;
    Prevalent.relay3 = relayList![2].name;

    return relayList;
  }
}