import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:mockup/models/PinCodes.dart';

import '../component/widgets.dart';
import '../database/DatabaseProvider.dart';
import '../models/Device.dart';
import '../models/PinCodes.dart';
import '../models/PinCodes.dart';
import '../prevalent/Prevalent.dart';
import '../values.dart';
import 'info.dart';

class ChangePins extends StatefulWidget {
  Device device;

  ChangePins(this.device);

  @override
  State<ChangePins> createState() => _ChangePinsState(device);
}

class _ChangePinsState extends State<ChangePins>
{
  Device device;
  String selectedItem = "Add/Edit Pin";

  PinCodes selectedPin = PinCodes.a();
  PinCodes editPin = PinCodes.a();
  DataBaseProvider db = DataBaseProvider();
  int path = 1;
  final int select = 1;
  final int edit = 2;
  final int add = 3;

int counter = 0;
  String relay1 = "No Action",
      relay2 = "No Action",
      relay3 = "No Action";
  TextEditingController codeController = new TextEditingController();
  TextEditingController newCodeController = new TextEditingController();

  List<String> choices = ["Add/Edit Pin",
    "Change the code",
    "Delete PIN",
  ];
  List<String> pinActions = [
    "No Action",
    "Pulse",
    "Latch",
    "Unlatch",
    "Toogle",
  ];

  late Future<List<PinCodes>?> pinCodes = getPinCodesFromDp(device.deviceId);

  _ChangePinsState(this.device);

  late List<PinCodes> pins = [];

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: pinCodes,
        builder: (BuildContext context, AsyncSnapshot<List<PinCodes>?>snapshot){
          if (!snapshot.hasData) {
            return Scaffold(
              body: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    appHeadWithBack("Change Pins", context, true,),
                    Padding(
                      padding: EdgeInsets.only(left:PadValues.extraPad, right:PadValues.extraPad),
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom:  PadValues.mainPad),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  Image(
                                    image: AssetImage("assets/Pincode.png"),
                                    height: 120,
                                    width: 120,),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(
                                            PadValues.lesserPad),
                                        child: Text(
                                          device.name!,
                                          style: TextStyle(
                                            color: Colors.green,),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(
                                            PadValues.lesserPad),
                                        child: Text(
                                          "Phone :" + device.phone!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      )

                                    ],
                                  )
                                ]
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom:  PadValues.mainPad),
                            child: Text(
                                "Pin:",
                                style: TextStyle(color: Colors.green,)),
                          ),//OldCode
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: PadValues.doubleExtraPad),
                            child: TextField(
                              controller: codeController,
                              style: TextStyle(fontSize: 12,
                                  color: Colors.grey.shade900
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                fillColor: Colors.grey.shade300,

                                hintText: "0-9*#",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1.0,),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.teal.shade900,
                                      width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0),
                                ),
                              ),

                            ),
                          ),

                          selectedItem== choices[1]?Padding(
                            padding: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                            child: Text(
                                "New Pin:",
                                style: TextStyle(color: Colors.green,)),
                          ):Container(),//newCode
                          selectedItem== choices[1]?Padding(
                            padding: EdgeInsets.only(
                                bottom: PadValues.doubleExtraPad),
                            child: TextField(
                              controller: newCodeController,
                              style: TextStyle(fontSize: 12,
                                  color: Colors.grey.shade900
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                fillColor: Colors.grey.shade300,

                                hintText: "0-9*#",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300, width: 1.0,),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.teal.shade900,
                                      width: 1.0),
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade300,
                                      width: 1.0),
                                ),
                              ),

                            ),
                          ):Container(),

                          Padding(
                            padding: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                            child: Text("Relay Operations",
                                style: TextStyle(color: Colors.green,)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              // Flexible(
                              //     flex: 1,
                              //     child: Container()),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  labeledSpinnerPins(
                                      context, Prevalent.relay1, relay1,
                                      pinActions),
                                  labeledSpinnerPins(
                                      context, Prevalent.relay2, relay2,
                                      pinActions),
                                  labeledSpinnerPins(
                                      context, Prevalent.relay3, relay3,
                                      pinActions),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                            child: Text("Pin command: ",
                                style: TextStyle(color: Colors.green,)),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                                choices[0],
                                style: TextStyle(color: Colors.green,)),
                            leading: Radio<String>(
                              value: choices[0],
                              groupValue: selectedItem,
                              onChanged: (value) {
                                setState(() {
                                  selectedItem = value!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                                choices[1],
                                style: TextStyle(color: Colors.green,)),
                            leading: Radio<String>(
                              value: choices[1],
                              groupValue: selectedItem,
                              onChanged: (value) {
                                setState(() {
                                  selectedItem = value!;
                                });
                              },
                            ),
                          ),
                          ListTile(
                            contentPadding: EdgeInsets.zero,

                            title: Text(
                                choices[2],
                                style: TextStyle(color: Colors.green,)),
                            leading: Radio<String>(
                              value: choices[2],
                              groupValue: selectedItem,
                              onChanged: (value) {
                                setState(() {
                                  selectedItem = value!;
                                });
                              },
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                              height: 50,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: ElevatedButton(onPressed: () {
                                sendCommand();
                              }, child: Text("SEND COMMAND",),)),


                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            pins = snapshot.data!;
            if (path == select) {
              return Scaffold(
                body: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      appHeadWithBack("Change Pins", context, true,),
                      Padding(
                        padding: EdgeInsets.all(PadValues.mainPad),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(
                                image: AssetImage("assets/Pincode.png"),
                                height: 120,
                                width: 120,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(
                                        PadValues.lesserPad),
                                    child: Text(
                                      device.name!,
                                      style: TextStyle(
                                        color: Colors.green,),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(
                                        PadValues.lesserPad),
                                    child: Text(
                                      "Phone :" + device.phone!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )

                                ],
                              )
                            ]
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return PinCodesCard(pin: snapshot.data![index],
                                  selected: selectedPin,
                                  action: () {
                                if(selectedPin.pinCode.isEmpty)
                                  {
                                    print(1);
                                    setState(() {
                                      selectedPin = snapshot.data![index];
                                    });
                                  }
                                else{
                                  if(selectedPin == snapshot.data![index]){
                                    print(2);
                                    setState(() {
                                      selectedPin = PinCodes.a();
                                    });
                                  }
                                  else{
                                    print(3);
                                    setState(() {
                                      selectedPin = snapshot.data![index];
                                    });
                                  }
                                }
                                  }
                              );
                            }),
                      ),
                      Container(
                          margin: EdgeInsets.all(PadValues.mainPad),
                          height: 50,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          child: ElevatedButton(onPressed: () {
                            if (selectedPin.pinCode.isEmpty) {
                              setState(() {
                                path = add;
                                selectedPin = PinCodes.a();
                              });
                            }
                            else {
                              setState(() {
                                path = edit;
                                editPin = selectedPin;
                              });
                            }
                          }, child: Text("ADD/EDIT",),)),


                    ],
                  ),
                ),
              );
            }
            else if (path == edit) {

              populateFields();
              return Scaffold(
                body: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      appHeadWithBack("Change Pins", context, true,),
                      Padding(
                        padding: EdgeInsets.only(left:PadValues.extraPad, right:PadValues.extraPad),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: PadValues.mainPad, bottom:  PadValues.mainPad),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Image(
                                      image: AssetImage("assets/Pincode.png"),
                                      height: 120,
                                      width: 120,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              PadValues.lesserPad),
                                          child: Text(
                                            device.name!,
                                            style: TextStyle(
                                              color: Colors.green,),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              PadValues.lesserPad),
                                          child: Text(
                                            "Phone :" + device.phone!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )

                                      ],
                                    )
                                  ]
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: PadValues.mainPad, bottom:  PadValues.mainPad),
                              child: Text(
                                  "Pin:",
                                  style: TextStyle(color: Colors.green,)),
                            ),//OldCode
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: PadValues.doubleExtraPad),
                              child: TextField(
                                controller: codeController,
                                style: TextStyle(fontSize: 12,
                                    color: Colors.grey.shade900
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                  fillColor: Colors.grey.shade300,

                                  hintText: "0-9*#",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 1.0,),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.teal.shade900,
                                        width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                  ),
                                ),

                              ),
                            ),

                            selectedItem== choices[1]?Padding(
                              padding: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                              child: Text(
                                  "New Pin:",
                                  style: TextStyle(color: Colors.green,)),
                            ):Container(),//newCode
                            selectedItem== choices[1]?Padding(
                              padding: EdgeInsets.only(
                                  bottom: PadValues.doubleExtraPad),
                              child: TextField(
                                controller: newCodeController,
                                style: TextStyle(fontSize: 12,
                                    color: Colors.grey.shade900
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                  fillColor: Colors.grey.shade300,

                                  hintText: "0-9*#",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 1.0,),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.teal.shade900,
                                        width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                  ),
                                ),

                              ),
                            ):Container(),

                            Padding(
                              padding: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                              child: Text("Relay Operations",
                                  style: TextStyle(color: Colors.green,)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Flexible(
                                //     flex: 1,
                                //     child: Container()),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    labeledSpinnerPins(
                                        context, Prevalent.relay1, relay1,
                                        pinActions),
                                    labeledSpinnerPins(
                                        context, Prevalent.relay2, relay2,
                                        pinActions),
                                    labeledSpinnerPins(
                                        context, Prevalent.relay3, relay3,
                                        pinActions),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                              child: Text("Pin command: ",
                                  style: TextStyle(color: Colors.green,)),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                  choices[0],
                                  style: TextStyle(color: Colors.green,)),
                              leading: Radio<String>(
                                value: choices[0],
                                groupValue: selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                  choices[1],
                                  style: TextStyle(color: Colors.green,)),
                              leading: Radio<String>(
                                value: choices[1],
                                groupValue: selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,

                              title: Text(
                                  choices[2],
                                  style: TextStyle(color: Colors.green,)),
                              leading: Radio<String>(
                                value: choices[2],
                                groupValue: selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                                height: 50,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: ElevatedButton(onPressed: () {
                                  sendCommand();
                                }, child: Text("SEND COMMAND",),)),


                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            else {
              return Scaffold(
                body: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      appHeadWithBack("Change Pins", context, true,),
                      Padding(
                        padding: EdgeInsets.only(left:PadValues.extraPad, right:PadValues.extraPad),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: PadValues.mainPad, bottom:  PadValues.mainPad),
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,

                                  children: [
                                    Image(
                                      image: AssetImage("assets/Pincode.png"),
                                      height: 120,
                                      width: 120,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(
                                              PadValues.lesserPad),
                                          child: Text(
                                            device.name!,
                                            style: TextStyle(
                                              color: Colors.green,),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(
                                              PadValues.lesserPad),
                                          child: Text(
                                            "Phone :" + device.phone!,
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )

                                      ],
                                    )
                                  ]
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: PadValues.mainPad, bottom:  PadValues.mainPad),
                              child: Text(
                                  "Pin:",
                                  style: TextStyle(color: Colors.green,)),
                            ),//OldCode
                            Padding(
                              padding: EdgeInsets.only(
                                  bottom: PadValues.doubleExtraPad),
                              child: TextField(
                                controller: codeController,
                                style: TextStyle(fontSize: 12,
                                    color: Colors.grey.shade900
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                  fillColor: Colors.grey.shade300,

                                  hintText: "0-9*#",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 1.0,),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.teal.shade900,
                                        width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                  ),
                                ),

                              ),
                            ),

                            selectedItem== choices[1]?Padding(
                              padding: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                              child: Text(
                                  "New Pin:",
                                  style: TextStyle(color: Colors.green,)),
                            ):Container(),//newCode
                            selectedItem== choices[1]?Padding(
                              padding: EdgeInsets.only(
                                  bottom: PadValues.doubleExtraPad),
                              child: TextField(
                                controller: newCodeController,
                                style: TextStyle(fontSize: 12,
                                    color: Colors.grey.shade900
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                  fillColor: Colors.grey.shade300,

                                  hintText: "0-9*#",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 1.0,),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.teal.shade900,
                                        width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                        width: 1.0),
                                  ),
                                ),

                              ),
                            ):Container(),

                            Padding(
                              padding: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                              child: Text("Relay Operations",
                                  style: TextStyle(color: Colors.green,)),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                // Flexible(
                                //     flex: 1,
                                //     child: Container()),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    labeledSpinnerPins(
                                        context, Prevalent.relay1, relay1,
                                        pinActions),
                                    labeledSpinnerPins(
                                        context, Prevalent.relay2, relay2,
                                        pinActions),
                                    labeledSpinnerPins(
                                        context, Prevalent.relay3, relay3,
                                        pinActions),
                                  ],
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                              child: Text("Pin command: ",
                                  style: TextStyle(color: Colors.green,)),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                  choices[0],
                                  style: TextStyle(color: Colors.green,)),
                              leading: Radio<String>(
                                value: choices[0],
                                groupValue: selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                  choices[1],
                                  style: TextStyle(color: Colors.green,)),
                              leading: Radio<String>(
                                value: choices[1],
                                groupValue: selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                              ),
                            ),
                            ListTile(
                              contentPadding: EdgeInsets.zero,

                              title: Text(
                                  choices[2],
                                  style: TextStyle(color: Colors.green,)),
                              leading: Radio<String>(
                                value: choices[2],
                                groupValue: selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(top:PadValues.extraPad, bottom:PadValues.extraPad),
                                height: 50,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                child: ElevatedButton(onPressed: () {
                                  sendCommand();
                                }, child: Text("SEND COMMAND",),)),


                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          }
          return Container(
              color:Colors.white,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator()));
        });

  }

  labeledSpinnerPins(context, label, field, List<String> val) {
    return Container(

      child: Padding(
        padding: EdgeInsets.only(top: PadValues.lesserPad,bottom: PadValues.lesserPad
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [

            Padding(
              padding: EdgeInsets.only(left: PadValues.doubleExtraPad,
                  right: PadValues.mainPad,
                  bottom: PadValues.lessPad,
                  top: PadValues.mainPad),
              child: Text(label, style: TextStyle(
                  fontSize: 16,
                  color: Colors.green
              ),),
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.only(left: PadValues.extraPad,
                      right: PadValues.extraPad,
                      bottom: PadValues.mainPad,
                      top: PadValues.mainPad),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: field,
                      hint: Text("Select Type",),
                      onChanged: (String? newValue) {
                        setField(label, newValue);
                      },

                      items: val.map<DropdownMenuItem<String>>((String valu) {
                        return DropdownMenuItem<String>(

                          value: valu,
                          child: Text(
                              valu, style: TextStyle(color: Colors.green)),
                        );
                      }
                      ).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sendCommand() async {
    String msgText = "";
    String pin1 = codeController.text;
    if(selectedItem == choices[1])
      {
        pin1 = newCodeController.text;
      }
    if (pin1.length < 1) {
      msgText = "Field PIN is mandatory";
      Prevalent.showDialogue(context, msgText);
    }
    else {
      String strAux = device.serial! + " pin " + pin1;

      if (relay1 != pinActions[0]) {
        strAux = strAux + " relay 1 " + relay1;
      }
      if (relay2 != pinActions[0])
        strAux = strAux + " relay 2 " + relay2;

      if (relay3 != pinActions[0]) {
        strAux = strAux + " relay 3 " + relay3;
      }

      if (pins.length > 100) {
        Prevalent.showDialogue(context, "Insuficiant Memory");
      }
      else {
        await db.open("mockup_dp");
        _sendSMS(strAux, [device.phone!]);
        bool condition = false;


        PinCodes pin = PinCodes(
            device.deviceId!, pin1, relay1, relay2, relay3);
        for(PinCodes pi in pins){
          if(pi.pinCode == pin.pinCode) {
            condition = true;
          }
        }

        setState(() {
          if(selectedItem == choices[2]){
            db.deletePinCodes(pin.pinCode , device.deviceId!).then((value){
              showDialogue(context, "Pin Deleted");
            });;
          }
          if(selectedItem == choices[1]){
            db.updatePinCodes(pin, codeController.text).then((value){
              showDialogue(context, "Pin Updated");
            });
          }
          else if(condition){
            db.updatePinCodes(pin, pin1).then((value){
              showDialogue(context, "Pin Updated");
            });
          }
          else {
            db.insertPinCodes(pin).then((value){
              showDialogue(context, "Pin Added");
            });
          }
          print("done");
        });

      }
    }
  }

  void setField(label, String? newValue) {
    if (label == Prevalent.relay1) {
      print(newValue);
      setState(() {
        relay1 = newValue!;

      });
    }
    else if (label == Prevalent.relay2) {
      setState(() {
        relay2 = newValue!;

      });
    }
    else if (label == Prevalent.relay3) {
      setState(() {
        relay3 = newValue!;
      });
    }
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(
        message: message, recipients: recipents, sendDirect: false)
        .catchError((onError) {
      print("Sms error: " + onError.toString());
    });
    print(_result);
  }

  Future<List<PinCodes>?> getPinCodesFromDp(int? deviceId) async {
    await db.open("mockup_dp");
    List<PinCodes>? pinCodesList = [];
    pinCodesList = await db.getPinCodes(device.deviceId!);
    return pinCodesList;
  }

  void populateFields() {
    if(counter ==0) {
      codeController.text = selectedPin.pinCode;
      relay1 = selectedPin.firstRelay1;
      relay2 = selectedPin.secondRelay2;
      relay3 = selectedPin.thirdRelay3;
      print("populated");
      if (relay1.isEmpty) {
        relay1 = pinActions[0];
      }
      if (relay2.isEmpty) {
        relay2 = pinActions[0];
      }
      if (relay3.isEmpty) {
        relay3 = pinActions[0];
      }
      counter++;
    }
  }

  showDialogue(context, msg){
    showDialog<String>(
        barrierDismissible: false,
        context: context,

        builder: (BuildContext context) =>
            AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: Padding(
                padding: EdgeInsets.all(PadValues.lessPad),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right:PadValues.lesserPad),
                          child: Image(image: AssetImage("assets/TickIcon.png"),
                            height: 30,
                            width: 30,
                            fit: BoxFit.contain,
                          ),
                        ),
                        Flexible(child: Text(msg)),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        color: Colors.grey,
                        height: 2,
                        width: 130,
                      ),
                    )
                  ],
                ),
              ),
              actions: <Widget>[
                ElevatedButton(

                  onPressed: () =>
                  {
                    Navigator.pop(context),
                    setState(() {
                      path = select;
                      pinCodes = getPinCodesFromDp(device.deviceId);
                      selectedPin = PinCodes.a();
                      selectedItem = choices[0];
                      counter = 0;
                      populateFields();
                    }),
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  child: Text("CLOSE"),
                ),
              ],
            )
    );
  }

}
