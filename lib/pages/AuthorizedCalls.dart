import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:mockup/models/Authorized.dart';
import 'package:permission_handler/permission_handler.dart';

import '../component/widgets.dart';
import '../database/DatabaseProvider.dart';
import '../models/Device.dart';
import '../prevalent/Prevalent.dart';
import '../values.dart';
import 'info.dart';

class AuthorizedCalls extends StatefulWidget {
  Device device;

  AuthorizedCalls(this.device);

  @override
  State<AuthorizedCalls> createState() => _AuthorizedCallsState(device);
}

class _AuthorizedCallsState extends State<AuthorizedCalls> {
  Device device;
  String selectedItem = "";
  List<String> choices = ["Authorize Only",
  "Reject call & trigger relays",
  "Answer (delay) or trigger relays",
  "Delete authorised number"];
  DataBaseProvider db = DataBaseProvider();

  int path = 1;
  final int select = 1;
  final int edit = 2;
  final int add = 3;
  String relay1 = "No Action",
      relay2 = "No Action",
      relay3 = "No Action";
  TextEditingController phoneController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController delayController = new TextEditingController();

  int counter = 0;
  List<String> relayActions = [
    "No Action",
    "Pulse",
    "Latch",
    "Unlatch",
    "Toogle",
  ];

  Authorized selectedAuth = Authorized.a();

  Authorized editAuth = Authorized.a();
  _AuthorizedCallsState(this.device);
  late Future<List<Authorized>?> authorizedList = getAuthorizedFromDp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: authorizedList,
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return Scaffold(
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    appHeadWithBack("Authorized Calls", context, true,),

                    Padding(
                      padding:  EdgeInsets.only(left:PadValues.extraPad, right: PadValues.extraPad),
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                            child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Image(image: AssetImage("assets/AuthorisedIncomingCallsPage.png"),
                                    height: 120,
                                    width: 120,),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(top:PadValues.lesserPad, bottom:PadValues.lesserPad, right: PadValues.lesserPad),
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
                          Padding(
                            padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                            child: Text("Number to be authorized:",style: TextStyle(color: Colors.green)),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: PadValues.extraPad,
                                      ),
                                  child: TextField(
                                    controller: phoneController,
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.grey.shade900
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                      fillColor: Colors.grey.shade300,
                                      hintText: "07700900123",
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300, width: 1.0,),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.teal.shade900, width: 1.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300, width: 1.0),
                                      ),
                                    ),

                                  ),
                                ),
                              ),
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      right: PadValues.lesserPad,
                                      ),
                                  child: TextField(
                                    controller: nameController,
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.grey.shade900
                                    ),
                                    decoration: InputDecoration(
                                      hintText: "Name",
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                      fillColor: Colors.grey.shade300,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300, width: 1.0,),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.teal.shade900, width: 1.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300, width: 1.0),
                                      ),
                                    ),

                                  ),
                                ),
                              ),
                              IconButton(onPressed: (){
                                getContact();
                                },
                                  iconSize: 30,
                                icon: Image(image: AssetImage("assets/TelephoneIcon.png"),)),

                            ],
                          ),
                          selectedItem == choices[2]?Padding(
                            padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                            child: Text("Delay: ",style: TextStyle(color: Colors.green)),
                          ):Container(),
                          selectedItem == choices[2]?Row(
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: PadValues.doubleExtraPad),
                                  child: TextField(
                                    controller: delayController,
                                    keyboardType: TextInputType.number,

                                    style: TextStyle(fontSize: 12,
                                        color: Colors.grey.shade900
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                      fillColor: Colors.grey.shade300,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Colors.grey.shade300, width: 1.0,),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.teal.shade900, width: 1.0),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey.shade300, width: 1.0),
                                      ),
                                    ),

                                  ),
                                ),
                              ),
                            ],
                          ):Container(),
                          Padding(
                            padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                            child: Text("Relay Operations", style: TextStyle(color: Colors.green)),
                          ),
                          Row(
                            children: [
                              Flexible(
                                  flex: 1,
                                  child: Container()),
                              Flexible(
                                flex: 3,
                                child: Column(
                                  children: [
                                    labeledSpinnerAuth(context, Prevalent.relay1, relay1, relayActions),
                                    labeledSpinnerAuth(context, Prevalent.relay2, relay2, relayActions),
                                    labeledSpinnerAuth(context, Prevalent.relay3, relay3, relayActions),
                                  ],
                                ),
                              )
                            ],
                          ),


                          Padding(
                            padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                            child: Text("Authorized number command: ", style: TextStyle(color: Colors.green)),
                          ),
                          ListTile(
                            title: Text(choices[0],style: TextStyle(color: Colors.green)),
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
                            title: Text(choices[1],style: TextStyle(color: Colors.green)),
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
                            title: Text(choices[2], style: TextStyle(color: Colors.green)),
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
                          ListTile(
                            title: Text(choices[3], style: TextStyle(color: Colors.green)),
                            leading: Radio<String>(
                              value: choices[3],
                              groupValue: selectedItem,
                              onChanged: (value) {
                                setState(() {
                                  selectedItem = value!;
                                });
                              },
                            ),
                          ),

                          Container(
                              margin: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(onPressed: (){
                                sendCommand();
                              }, child: Text("SEDN COMMAND", ), )),


                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          }
          if(snapshot.connectionState == ConnectionState.done){
            if (path == select){
              print("Select");

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
                        child: Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Image(image: AssetImage("assets/AuthorisedIncomingCallsPage.png"),
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
                      Expanded(
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AuthCard(auth: snapshot.data![index],
                                  selected: selectedAuth,
                                  action: () {
                                    if(selectedAuth.phone.isEmpty)
                                    {
                                      print(1);
                                      setState(() {
                                        selectedAuth = snapshot.data![index];
                                      });
                                    }
                                    else{
                                      if(selectedAuth == snapshot.data![index]){
                                        print(2);
                                        setState(() {
                                          selectedAuth = Authorized.a();
                                        });
                                      }
                                      else{
                                        print(3);
                                        setState(() {
                                          selectedAuth = snapshot.data![index];
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
                            if (selectedAuth.phone.isEmpty) {
                              setState(() {
                                path = add;
                                selectedAuth = Authorized.a();
                              });
                            }
                            else {
                              setState(() {
                                path = edit;
                                editAuth = selectedAuth;
                              });
                            }
                          }, child: Text("ADD/EDIT",),)),
                    ],
                  ),
                ),
              );

            }
            else if (path == edit){

              populateFields();
              return Scaffold(
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      appHeadWithBack("Authorized Calls", context, true,),

                      Padding(
                        padding:  EdgeInsets.only(left:PadValues.extraPad, right: PadValues.extraPad),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(image: AssetImage("assets/AuthorisedIncomingCallsPage.png"),
                                      height: 120,
                                      width: 120,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top:PadValues.lesserPad, bottom:PadValues.lesserPad, right: PadValues.lesserPad),
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
                            Padding(
                              padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                              child: Text("Number to be authorized:",style: TextStyle(color: Colors.green)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: PadValues.extraPad,
                                    ),
                                    child: TextField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.number,

                                      style: TextStyle(fontSize: 12,
                                          color: Colors.grey.shade900
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                        fillColor: Colors.grey.shade300,
                                        hintText: "07700900123",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300, width: 1.0,),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade900, width: 1.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade300, width: 1.0),
                                        ),
                                      ),

                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: PadValues.lesserPad,
                                    ),
                                    child: TextField(
                                      controller: nameController,
                                      style: TextStyle(fontSize: 12,
                                          color: Colors.grey.shade900
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Name",
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                        fillColor: Colors.grey.shade300,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300, width: 1.0,),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade900, width: 1.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade300, width: 1.0),
                                        ),
                                      ),

                                    ),
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  getContact();
                                },
                                    iconSize: 30,
                                    icon: Image(image: AssetImage("assets/TelephoneIcon.png"),)),

                              ],
                            ),
                            selectedItem == choices[2]?Padding(
                              padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                              child: Text("Delay: ",style: TextStyle(color: Colors.green)),
                            ):Container(),
                            selectedItem == choices[2]?Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: PadValues.doubleExtraPad),
                                    child: TextField(
                                      controller: delayController,
                                      keyboardType: TextInputType.number,

                                      style: TextStyle(fontSize: 12,
                                          color: Colors.grey.shade900
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                        fillColor: Colors.grey.shade300,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300, width: 1.0,),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade900, width: 1.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade300, width: 1.0),
                                        ),
                                      ),

                                    ),
                                  ),
                                ),
                              ],
                            ):Container(),
                            Padding(
                              padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                              child: Text("Relay Operations", style: TextStyle(color: Colors.green)),
                            ),
                            Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    child: Container()),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      labeledSpinnerAuth(context, Prevalent.relay1, relay1, relayActions),
                                      labeledSpinnerAuth(context, Prevalent.relay2, relay2, relayActions),
                                      labeledSpinnerAuth(context, Prevalent.relay3, relay3, relayActions),
                                    ],
                                  ),
                                )
                              ],
                            ),


                            Padding(
                              padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                              child: Text("Authorized number command: ", style: TextStyle(color: Colors.green)),
                            ),
                            ListTile(
                              title: Text(choices[0],style: TextStyle(color: Colors.green)),
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
                              title: Text(choices[1],style: TextStyle(color: Colors.green)),
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
                              title: Text(choices[2], style: TextStyle(color: Colors.green)),
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
                            ListTile(
                              title: Text(choices[3], style: TextStyle(color: Colors.green)),
                              leading: Radio<String>(
                                value: choices[3],
                                groupValue: selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                              ),
                            ),

                            Container(
                                margin: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(onPressed: (){
                                  sendCommand();
                                }, child: Text("SEDN COMMAND", ), )),


                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );

            }
            else if( path == add){

              return Scaffold(
                body: Container(
                  height: MediaQuery.of(context).size.height,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      appHeadWithBack("Authorized Calls", context, true,),

                      Padding(
                        padding:  EdgeInsets.only(left:PadValues.extraPad, right: PadValues.extraPad),
                        child: Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                              child: Row(mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Image(image: AssetImage("assets/AuthorisedIncomingCallsPage.png"),
                                      height: 120,
                                      width: 120,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(top:PadValues.lesserPad, bottom:PadValues.lesserPad, right: PadValues.lesserPad),
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
                            Padding(
                              padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                              child: Text("Number to be authorized:",style: TextStyle(color: Colors.green)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: PadValues.extraPad,
                                    ),
                                    child: TextField(
                                      controller: phoneController,
                                      keyboardType: TextInputType.number,

                                      style: TextStyle(fontSize: 12,
                                          color: Colors.grey.shade900
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                        fillColor: Colors.grey.shade300,
                                        hintText: "07700900123",
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300, width: 1.0,),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade900, width: 1.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade300, width: 1.0),
                                        ),
                                      ),

                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      right: PadValues.lesserPad,
                                    ),
                                    child: TextField(
                                      controller: nameController,
                                      style: TextStyle(fontSize: 12,
                                          color: Colors.grey.shade900
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Name",
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                        fillColor: Colors.grey.shade300,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300, width: 1.0,),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade900, width: 1.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade300, width: 1.0),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(onPressed: (){
                                  getContact();
                                },
                                    iconSize: 30,
                                    icon: Image(image: AssetImage("assets/TelephoneIcon.png"),)),

                              ],
                            ),
                            selectedItem == choices[2]?Padding(
                              padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                              child: Text("Delay: ",style: TextStyle(color: Colors.green)),
                            ):Container(),
                            selectedItem == choices[2]?Row(
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: PadValues.doubleExtraPad),
                                    child: TextField(
                                      controller: delayController,
                                      keyboardType: TextInputType.number,

                                      style: TextStyle(fontSize: 12,
                                          color: Colors.grey.shade900
                                      ),
                                      decoration: InputDecoration(
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                        fillColor: Colors.grey.shade300,
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey.shade300, width: 1.0,),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.teal.shade900, width: 1.0),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey.shade300, width: 1.0),
                                        ),
                                      ),

                                    ),
                                  ),
                                ),
                              ],
                            ):Container(),
                            Padding(
                              padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                              child: Text("Relay Operations", style: TextStyle(color: Colors.green)),
                            ),
                            Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    child: Container()),
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    children: [
                                      labeledSpinnerAuth(context, Prevalent.relay1, relay1, relayActions),
                                      labeledSpinnerAuth(context, Prevalent.relay2, relay2, relayActions),
                                      labeledSpinnerAuth(context, Prevalent.relay3, relay3, relayActions),
                                    ],
                                  ),
                                )
                              ],
                            ),


                            Padding(
                              padding: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                              child: Text("Authorized number command: ", style: TextStyle(color: Colors.green)),
                            ),
                            ListTile(
                              title: Text(choices[0],style: TextStyle(color: Colors.green)),
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
                              title: Text(choices[1],style: TextStyle(color: Colors.green)),
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
                              title: Text(choices[2], style: TextStyle(color: Colors.green)),
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
                            ListTile(
                              title: Text(choices[3], style: TextStyle(color: Colors.green)),
                              leading: Radio<String>(
                                value: choices[3],
                                groupValue: selectedItem,
                                onChanged: (value) {
                                  setState(() {
                                    selectedItem = value!;
                                  });
                                },
                              ),
                            ),

                            Container(
                                margin: EdgeInsets.only(top:PadValues.mainPad, bottom:PadValues.mainPad),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ElevatedButton(onPressed: (){
                                  sendCommand();
                                }, child: Text("SEDN COMMAND", ), )),


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
              color: Colors.white,
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

    return Scaffold(

      body: Container(
        child: Column(
          children: [
            appHeadWithBack("Authorized Calls", context, true,),

            Container(
              height: MediaQuery.of(context).size.height,
              child: ListView(

                children: [

                  Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: EdgeInsets.all(PadValues.mainPad),
                        child: Row(mainAxisAlignment: MainAxisAlignment.start,

                            children: [
                              Image(image: AssetImage("assets/AuthorisedIncomingCallsPage.png"),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Number to be authorized:",style: TextStyle(color: Colors.green)),
                      ),
                      Row(
                        children: [
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: PadValues.doubleExtraPad,
                                  right: PadValues.extraPad,
                                  bottom: PadValues.doubleExtraPad),
                              child: TextField(
                                style: TextStyle(fontSize: 12,
                                    color: Colors.grey.shade700
                                ),
                                decoration: InputDecoration(
                                  hintText: "07700900123",
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 1.0,),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.teal.shade900, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: 1.0),
                                  ),
                                ),

                                ),
                            ),
                          ),
                          Flexible(
                            child: Padding(
                              padding: EdgeInsets.only(left: PadValues.doubleExtraPad,
                                  right: PadValues.extraPad,
                                  bottom: PadValues.doubleExtraPad),
                              child: TextField(
                                style: TextStyle(fontSize: 12,
                                    color: Colors.grey.shade700
                                ),
                                decoration: InputDecoration(
                                  hintText: "Name",

                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.grey.shade300, width: 1.0,),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.teal.shade900, width: 1.0),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey.shade300, width: 1.0),
                                  ),
                                ),

                                 ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Relay Operations", style: TextStyle(color: Colors.green)),
                      ),
                      Row(
                        children: [
                          Flexible(
                              flex: 2,
                              child: Container()),
                          Flexible(
                            flex: 4,
                            child: Column(
                              children: [
                                labeledSpinner(context, "Relay1", "Pulse", ["Pulse"],(){}),
                                labeledSpinner(context, "Relay2", "No Action", ["No Action"],(){}),
                                labeledSpinner(context, "Relay3", "No Action", ["No Action"],(){}),
                              ],
                            ),
                          )
                        ],
                      ),


                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Authorized number command: ", style: TextStyle(color: Colors.green)),
                      ),
                      ListTile(
                        title: Text(choices[0],style: TextStyle(color: Colors.green)),
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
                        title: Text(choices[1],style: TextStyle(color: Colors.green)),
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
                        title: Text(choices[2], style: TextStyle(color: Colors.green)),
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
                      ListTile(
                        title: Text(choices[3], style: TextStyle(color: Colors.green)),
                        leading: Radio<String>(
                          value: choices[3],
                          groupValue: selectedItem,
                          onChanged: (value) {
                            setState(() {
                              selectedItem = value!;
                            });
                          },
                        ),
                      ),

                      Container(
                          margin: EdgeInsets.all(PadValues.mainPad),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(onPressed: (){}, child: Text("SEDN COMMAND", ), )),


                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  Future<List<Authorized>?> getAuthorizedFromDp() async {

    await db.open("mockup_dp");
    List<Authorized>? AuthList = [];
    AuthList = await db.getAuthorizedList(device.deviceId!);
    return AuthList;
  }

  labeledSpinnerAuth(context, label, field, List<String> val) {
    return Container(
      child: Padding(
        padding: EdgeInsets.only(top: PadValues.lesserPad,bottom: PadValues.lesserPad
            ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.only(left: PadValues.mainPad,
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

  populateFields() {
    if(counter ==0) {
      phoneController.text = selectedAuth.phone;
      nameController.text = selectedAuth.name;
      delayController.text = selectedAuth.delay.toString();
      selectedItem = choices[int.parse(selectedAuth.mode) - 1];
      relay1 = selectedAuth.relay1;
      relay2 = selectedAuth.relay2;
      relay3 = selectedAuth.relay3;
      if (relay1.isEmpty) {
        relay1 = relayActions[0];
      }
      if (relay2.isEmpty) {
        relay2 = relayActions[0];
      }
      if (relay3.isEmpty) {
        relay3 = relayActions[0];
      }
      counter++;
    }

  }

  Future<void> sendCommand() async {
    String strAux = "";

    if (selectedItem == choices[0]) {
      if (phoneController.text.length < 1) {
        Prevalent.showDialogue(context, "Field phone number is mandatory");
      }
      else {
        strAux = device.serial! + " delete number " + phoneController.text +
            " number " + phoneController.text + " allow";
        _sendSMS(strAux, [device.phone!]);
        await db.open("mockup_dp");
        if(path == edit) {
          await db.updateAuthorized(Authorized(
              device.deviceId!,
              phoneController.text,
              nameController.text,
              '1',
              relay1,
              relay2,
              relay3,
              0)).then((value) => showDialogue(context, "Authorized Number Edited"));
        }
        else {
          await db.insertAuthorized(Authorized(
              device.deviceId!,
              phoneController.text,
              nameController.text,
              '1',
              relay1,
              relay2,
              relay3,
              0)).then((value) => showDialogue(context, "Authorized Number Added"));

          phoneController.text = "";
          nameController.text = "";
        }
      }
    }
    else if (selectedItem == choices[1]) {
      if (phoneController.text.length < 1)
      {
        Prevalent.showDialogue(context, "Field phone number is mandatory");
      }
      else
      {
        strAux = device.serial! + " delete number " + phoneController.text + " number " + phoneController.text;
        if (relay1 != relayActions[0]) {
          strAux = strAux + " relay 1 " + relay1;
        }
        if (relay2 != relayActions[0]) {
          strAux = strAux + " relay 2 " + relay2;
        }
        if (relay3 != relayActions[0]) {
          strAux = strAux + " relay 3 " + relay3;
        }
        _sendSMS(strAux, [device.phone!]);
        if(path == edit) {
          db.updateAuthorized(Authorized(
              device.deviceId!,
              phoneController.text,
              nameController.text,
              '2',
              relay1,
              relay2,
              relay3,
              0)).then((value) => showDialogue(context,"Authorized Number Edited"));
        }
        else{
          db.insertAuthorized(Authorized(
              device.deviceId!,
              phoneController.text,
              nameController.text,
              '2',
              relay1,
              relay2,
              relay3,
              0)).then((value) => showDialogue(context,"Authorized Number Added"));

        }
        phoneController.text = "";nameController.text = "";}
    }
    else if (selectedItem == choices[2]) {
      if (phoneController.text.length < 1)
      {
        Prevalent.showDialogue(context, "Field phone number is mandatory");

      }
      else if (delayController.text.length < 1)
      {
    Prevalent.showDialogue(context, "Answer delay is mandatory");

    }

      else
      {
    strAux = device.serial! + " delete number " + phoneController.text + " number " + phoneController.text + " delay " + delayController.text;

    if (relay1 != relayActions[0]) {
      strAux = strAux + " relay 1 " + relay1;
    }
    if (relay2 != relayActions[0]) {
      strAux = strAux + " relay 2 " + relay2;
    }
    if (relay3 != relayActions[0]) {
      strAux = strAux + " relay 3 " + relay3;
    };

    _sendSMS(strAux, [device.phone!]);

    if(path == edit){
      db.updateAuthorized(Authorized(device.deviceId!, phoneController.text, nameController.text, '3', relay1, relay2, relay3, int.parse(delayController.text))).then((value) =>
      showDialogue(context, "Authorized Number Edited"));
    }
    else{
      db.insertAuthorized(Authorized(device.deviceId!, phoneController.text, nameController.text, '3', relay1, relay2, relay3, int.parse(delayController.text))).then((value) =>
          showDialogue(context, "Authorized Number Added"));

    }

    phoneController.text = "";
    nameController.text = "";
    delayController.text = "";
    }
    }
    else if (selectedItem == choices[3]) {
    strAux = device.serial! + " delete number " + phoneController.text;
    _sendSMS(strAux, [device.phone!]);
    db.deleteAuthorized(device.deviceId!, selectedAuth.phone).then((value) => showDialogue(context, "Authorized Number Deleted")).
    then((value) {
    authorizedList = db.getAuthorizedList(device.deviceId!);
    selectedAuth = Authorized.a();
    selectedItem = choices[0];
    counter = 0;
    populateFields();
    }
    );
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

  Future<void> getContact() async {
    var status = await await Permission.contacts.request();
    if(status.isGranted){
      final contact = await FlutterContacts.openExternalPick();
      setState(() {
        phoneController.text = contact!.phones[0].number;
        nameController.text = contact!.name.first;
      });
    }
    else{
      Prevalent.showDialogue(context, "You need Permission to Access Contacts");
    }
  }

  showDialogue(context, msg){
    showDialog<String>(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
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
                    padding: EdgeInsets.all(PadValues.extraPad),
                    child: Container(
                      height: 1,
                      width: 100,
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
              actions: <Widget>[
                ElevatedButton(

                  onPressed: () =>
                  {
                    Navigator.pop(context),
                    setState(() {
                      path = select;
                      authorizedList = db.getAuthorizedList(device.deviceId!);
                      selectedAuth = Authorized.a();
                      selectedItem = choices[0];
                      counter = 0;
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

