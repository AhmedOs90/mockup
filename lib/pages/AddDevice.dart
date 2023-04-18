import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mockup/pages/SelectDevice.dart';

import '../component/mockAppBar.dart';
import '../component/widgets.dart';
import '../database/DatabaseProvider.dart';
import '../models/Device.dart';
import '../models/Relays.dart';
import '../prevalent/Prevalent.dart';
import '../values.dart';
import 'info.dart';


class AddDevice extends StatelessWidget {
  Device? selectedDevice;
  int counter = 0;
  AddDevice({this.selectedDevice});

  TextEditingController nameController = new TextEditingController();
  TextEditingController serialController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    if(selectedDevice != null){
      populateFields();
    }

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            appHeadWithBack("App Name", context, false,),

            Padding(
              padding: EdgeInsets.only(left: PadValues.extraPad, right: PadValues.extraPad),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  labeledFieldCardEditable(
                      context: context,
                      label: "Insert Name",
                      field: "",
                      edit: false,
                      hint: "Name",
                      controller: nameController,
                      inputType : FilteringTextInputFormatter.singleLineFormatter),
                  labeledFieldCardEditable(
                      context: context,
                      label: "Insert Serial Number",
                      field: "",edit: false,
                      controller: serialController,
                      inputType: FilteringTextInputFormatter.singleLineFormatter,
                      hint: "Serial Number",
                  icon: true),
                  labeledFieldCardEditable(
                      context: context,
                      label: "Insert Phone Number",
                      field: "",edit: false,
                      controller: phoneController,
                      inputType: FilteringTextInputFormatter.digitsOnly,
                      keyboard: TextInputType.number,
                      hint: "Phone",
                  ),
                  Container(
                      margin: EdgeInsets.only(top: PadValues.mainPad,
                          bottom: PadValues.mainPad),
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(onPressed: () async {
                        await checkAndAddDevice(context);


                        }, child: Text("CONTINUE", ), )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

    checkAndAddDevice(context) async {

    if(nameController.text.isEmpty)
      {
        Prevalent.showDialogue(context, "Name is mandatory");
      }
    else if (serialController.text.isEmpty){
      Prevalent.showDialogue(context, "Serial number is mandatory");
    }
    else if (phoneController.text.isEmpty){
      Prevalent.showDialogue(context, "Phone number is mandatory");
    }
    else{

      Device device = Device(nameController.text, serialController.text, phoneController.text);
      DataBaseProvider db = new DataBaseProvider();
      await db.open("mockup_dp");
      if(selectedDevice != null){
        selectedDevice!.name = nameController.text;
        selectedDevice!.serial = serialController.text;
        selectedDevice!.phone = phoneController.text;
        await db.updateDevice(selectedDevice!);
      }
      else {
        print("insert");
        await db.insertDevice(device);
        await db.insertRelays(Relays(device.deviceId!, 1, 'Relay 1'));
        await db.insertRelays(Relays(device.deviceId!, 2, 'Relay 2'));
        await db.insertRelays(Relays(device.deviceId!, 3, 'Relay 3'));
      }


      Navigator.push(context, MaterialPageRoute(builder:
          (context) => SelectDevice()));
    }

  }

    checkAndModifyDevice(context) async {

      if(nameController.text.isEmpty)
      {
        Prevalent.showDialogue(context, "Name is mandatory");
      }
      else if (serialController.text.isEmpty){
        Prevalent.showDialogue(context, "Serial number is mandatory");
      }
      else if (phoneController.text.isEmpty){
        Prevalent.showDialogue(context, "Phone number is mandatory");
      }
      else{
        Device device = Device(nameController.text, serialController.text, phoneController.text);
        DataBaseProvider dp = new DataBaseProvider();
        await dp.open("mockup_dp");
        await dp.updateDevice(device);
        Navigator.push(context, MaterialPageRoute(builder:
            (context) => SelectDevice()));
      }

    }

  void populateFields() {
    if(counter == 0) {
      nameController.text = selectedDevice!.name!;
      serialController.text = selectedDevice!.serial!;
      phoneController.text = selectedDevice!.phone!;
      counter++;
    }
  }
}

