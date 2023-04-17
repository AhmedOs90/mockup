import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mockup/database/DatabaseProvider.dart';
import 'package:mockup/models/Relays.dart';
import 'package:mockup/pages/info.dart';
import 'package:mockup/prevalent/Prevalent.dart';
import 'package:sqflite/sqflite.dart';

import '../component/widgets.dart';
import '../models/Device.dart';
import '../values.dart';

class RenameRelay extends StatelessWidget {
  Device device;
  TextEditingController relay1Controller = TextEditingController();
  TextEditingController relay2Controller = TextEditingController();
  TextEditingController relay3Controller = TextEditingController();
  int counter = 0;

  @override
  Widget build(BuildContext context) {
    populateField();

    return Scaffold(

      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            appHeadWithBack("Rename Relays", context, true,),
            Padding(
              padding: EdgeInsets.only(left: PadValues.extraPad, right: PadValues.extraPad),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: PadValues.mainPad, bottom:PadValues.mainPad, ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.start,

                        children: [
                          Image(image: AssetImage("assets/RenameRelaysPage.png"),
                            height: 120,
                            width: 120,),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(PadValues.lesserPad),
                                child: Text(
                                  device.name!,style: TextStyle(color: Colors.green,),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(PadValues.lesserPad),
                                child: Text(
                                  "Phone :" + device.phone!,style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )

                            ],
                          )
                        ]
                    ),
                  ),
                  labeledFieldCardEditable(
                      context: context,
                      label: "Relay 1",
                      edit: false,
                      hint: "Relay 1",
                      controller: relay1Controller,
                      inputType : FilteringTextInputFormatter.singleLineFormatter),
                  labeledFieldCardEditable(
                      context: context,
                      label: "Relay 2",
                      field: "",edit: false,
                      controller: relay2Controller,
                      inputType: FilteringTextInputFormatter.singleLineFormatter,
                      hint: "Relay 2"),
                  labeledFieldCardEditable(
                      context: context,
                      label: "Relay 3",
                      field: "",edit: false,
                      controller: relay3Controller,
                      inputType: FilteringTextInputFormatter.digitsOnly,
                      hint: "Relay 3"),
                  Container(
                      margin: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(onPressed: (){

                        Renam(context, device);
                      }, child: Text("RENAME", ), )),


                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<void> Renam(context, Device device) async {
    DataBaseProvider db = DataBaseProvider();
    await db.open("mockup_dp");
    if (relay1Controller.text.length < 1)
    {
      Prevalent.showDialogue(context, "Field Relay 1 can not be empty");

    }
    else  if (relay2Controller.text.length < 1)
    {

      Prevalent.showDialogue(context,  "Field Relay 2 can not be empty");

    }
    else  if (relay3Controller.text.length < 1)
    {
      Prevalent.showDialogue(context, "Field Relay 3 can not be empty");
    }
    else
    {
      await db.updateRelays(Relays(device.deviceId!, 1, relay1Controller.text));
      await db.updateRelays(Relays(device.deviceId!, 2, relay2Controller.text));
      await db.updateRelays(Relays(device.deviceId!, 3, relay3Controller.text));
      Prevalent.relay1 =relay1Controller.text;
      Prevalent.relay2 =relay2Controller.text;
      Prevalent.relay3 =relay3Controller.text;
      counter = 0;
      populateField();
      Prevalent.showDialogue(context, "Saved");
    }
  }

  populateField(){
    if (counter == 0){
    relay1Controller.text = Prevalent.relay1;
    relay2Controller.text = Prevalent.relay2;
    relay3Controller.text = Prevalent.relay3;
    counter++;
    }

  }

  RenameRelay(this.device);

}
