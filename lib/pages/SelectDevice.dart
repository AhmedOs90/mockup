import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:mockup/database/DatabaseProvider.dart';
import 'package:mockup/pages/SetUp.dart';

import '../component/mockAppBar.dart';
import '../component/widgets.dart';
import '../models/Device.dart';
import '../values.dart';
import 'AddDevice.dart';
import 'info.dart';

class SelectDevice extends StatefulWidget {
  const SelectDevice({Key? key}) : super(key: key);

  @override
  State<SelectDevice> createState() => _SelectDeviceState();
}

class _SelectDeviceState extends State<SelectDevice> {



  late Future<List<Device>> devices = getDevicesFromDp();


  DataBaseProvider dp = DataBaseProvider();

  Device selectedDevice = Device.a();
  @override
  Widget build(BuildContext context) {
    print("after " + selectedDevice.deviceId.toString());
    return FutureBuilder(
        future:devices,
        builder: (BuildContext context, AsyncSnapshot<List<Device>> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(

              body: Column(

                children: [
                  appHeadWithBack("Select Device", context, false,),
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(PadValues.mainPad,),
                          child:Text("Select Device or add a new one...", style: TextStyle(fontWeight: FontWeight.bold)),
                      )
                    ]
                  ),
                  Flexible(
                    flex: 2,
                    child: ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return DeviceCard(device: snapshot.data![index],
                              selected: selectedDevice,
                              action: () {
                                setState(() {
                                  selectedDevice = snapshot.data![index];
                                });
                              }
                          );
                        }),
                  ),
                  Flexible(
                    flex: 1,
                    child: selectedDevice.deviceId! == -1 ? Container(
                      child: Center(
                          child: Text("Nothing Selected")
                      ),
                    )
                        : Container(
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Colors.green,
                              height: 2,
                            ),
                            Expanded(
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: PadValues.mainPad,
                                          right: PadValues.mainPad),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        mainAxisAlignment: MainAxisAlignment
                                            .start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(
                                                PadValues.mainPad),
                                            child: Text("Device Selected: ",
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight
                                                      .bold),),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(
                                                PadValues.lessPad),
                                            child: Text(selectedDevice.name!,
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold)),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.all(
                                                PadValues.lessPad),
                                            child: Text(selectedDevice.serial!),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    InkWell(
                                      onTap: () {
                                        showDialog<String>(
                                            barrierDismissible: false,
                                            context: context,
                                            builder: (BuildContext context) =>
                                                AlertDialog(
                                                  content: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,

                                                    children: [
                                                      Icon(Icons.info_outline),
                                                      Flexible(
                                                        child: Text(
                                                          "Are you sure you want to remove this device?",textAlign: TextAlign.center,style: TextStyle(color: Colors.green)),
                                                      )

                                                    ],
                                                  ),
                                                  actionsAlignment: MainAxisAlignment.center,
                                                  actions: <Widget>[
                                                    ElevatedButton(

                                                      onPressed: () =>
                                                      {
                                                        Navigator.pop(context),
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                          backgroundColor: Colors
                                                              .green),
                                                      child: Text("CANCEL"),
                                                    ),
                                                    ElevatedButton(

                                                      onPressed: () =>
                                                      {
                                                        DeleteDevice(
                                                            selectedDevice),

                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                          backgroundColor: Colors
                                                              .red),
                                                      child: Text("DELETE"),
                                                    ),
                                                  ],
                                                )
                                        );
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: PadValues.mainPad,
                                            right: PadValues.mainPad),
                                        child: Icon(
                                          Icons.close, color: Colors.red,),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: (){
                                        Navigator.push(
                                            context, MaterialPageRoute(builder:
                                            (context) => AddDevice(selectedDevice: selectedDevice)));

                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: PadValues.mainPad,
                                            right: PadValues.mainPad),
                                        child: Icon(
                                          Icons.edit, color: Colors.green,),
                                      ),
                                    )
                                  ]
                              ),
                            ),
                            Container(
                              color: Colors.green,
                              height: 2,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                    child: Row(
                      children: [
                        Expanded(child: Padding(
                          padding: EdgeInsets.all(PadValues.mainPad),
                          child: Container(
                              height: 60,
                              child: ElevatedButton(onPressed: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder:
                                    (context) => AddDevice()));
                              },
                                child: Text("ADD DEVICE",),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,),)),
                        )),
                        selectedDevice.name!.isNotEmpty ? Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(PadValues.mainPad),
                              child: Container(
                                  height: 60,
                                  child: ElevatedButton(onPressed: () {
                                    Navigator.push(
                                        context, MaterialPageRoute(builder:
                                        (context) => SetUp(selectedDevice)));
                                  }, child: Text("CONTINUE",),)),
                            )) : Container()
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Center(child: CircularProgressIndicator()));
        });
    }

    // Scaffold(
    //   body: DeviceCard(device: snapshot.data!.first, selected: selectedDevice,action: ()
    //   {
    //     setState(() {
    //       selectedDevice = snapshot.data!.first;
    //     });
    //   }
    //   ),
    // );
    //

  Future<List<Device>> getDevicesFromDp() async {

    await dp.open("mockup_dp");
    List<Device> devices1 = await dp.getDevices();
    return devices1;
  }

  DeleteDevice(Device selectedDevice) async{
    await dp.deleteDevice(selectedDevice.deviceId!);
    setState(() {
      this.selectedDevice = Device.a();
      devices = getDevicesFromDp();
      });
    Navigator.pop(context);

  }

}




