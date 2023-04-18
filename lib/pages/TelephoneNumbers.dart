
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:mockup/database/DatabaseProvider.dart';
import 'package:mockup/models/callButtons.dart';
import 'package:permission_handler/permission_handler.dart';

import '../component/widgets.dart';
import '../models/Device.dart';
import '../prevalent/Prevalent.dart';
import '../values.dart';
import 'info.dart';
import 'package:flutter_sms/flutter_sms.dart';

class TeleNumber extends StatefulWidget {
  Device device;
  TeleNumber(this.device);

  @override
  State<TeleNumber> createState() => _TeleNumberState(this.device);
}

class _TeleNumberState extends State<TeleNumber> {
  DataBaseProvider db = DataBaseProvider();

  Device device;
  _TeleNumberState(this.device);
  String selectedButton = "Button 1";
  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController thirdNameController = TextEditingController();
  TextEditingController firstDialController = TextEditingController();
  TextEditingController secondDialController = TextEditingController();
  TextEditingController thirdDialController = TextEditingController();
  TextEditingController firstRingController = TextEditingController();
  TextEditingController secondRingController = TextEditingController();
  TextEditingController thirdRingController = TextEditingController();

  CallButtons? currentCallButton;
 int counter = 0;
  int counter1 = 0;
  List<String> val = ["Button 1","Button 2","Button 3","Button 4","Button 5",
    "Button 6","Button 7","Button 8","Button 9","Button 10",];
  @override
  Widget build(BuildContext context) {
    Future<CallButtons?> callButtons = getCallButton(selectedButton, device);
    currentCallButton = CallButtons.a();
      return FutureBuilder(
          future: callButtons,
          builder: (context, snapshot){
            if(!snapshot.hasData){
              emptyFields();
              return Scaffold(
                body: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    appHeadWithBack("Telephone Numbers", context, true,),
                    Padding(
                      padding: EdgeInsets.only(left: PadValues.mainPad, right: PadValues.mainPad),
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Row(mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  Image(image: AssetImage("assets/Panel.png"),
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
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("Call Button:", style: TextStyle(color: Colors.red),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Container(
                              width: 135,
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
                                      value: selectedButton,
                                      hint: Text("Select Type",),
                                      onChanged: (String? newValue) {

                                        setState(() {
                                          selectedButton = newValue!;
                                          counter = 0;
                                          counter1 = 0;

                                        });
                                      },

                                      items: val.map<DropdownMenuItem<String>>((String valu) {
                                        return DropdownMenuItem<String>(

                                          value: valu,
                                          child: Text(valu, style: TextStyle(color: Colors.green)),
                                        );
                                      }
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("1st Number to be dialled:",style: TextStyle(color: Colors.green)),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad,right: PadValues.lessPad),

                                  child: TextField(
                                    keyboardType: TextInputType.number,

                                    controller: firstDialController,
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
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad,right: PadValues.lessPad),

                                  child: TextField(
                                    controller: firstNameController,
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.grey.shade900
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                      fillColor: Colors.grey.shade300,
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
                              IconButton(onPressed: (){
                                getContact(0);
                              },
                                  iconSize: 30,
                                  icon: Image(image: AssetImage("assets/TelephoneIcon.png"),)),

                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("Ring for (Sec)", style: TextStyle(color: Colors.green)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: PadValues.mainPad),
                            child: Container(
                              width: 80,
                              child: TextField(
                                keyboardType: TextInputType.number,

                                style: TextStyle(fontSize: 12,
                                    color: Colors.grey.shade900
                                ),
                                controller: firstRingController,
                                decoration: InputDecoration(
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                          fillColor: Colors.grey.shade300,
                                  hintText: "20",
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
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("2nd Number to be dialled:", style: TextStyle(color: Colors.green)),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad,right: PadValues.lessPad),

                                  child: TextField(
                                    keyboardType: TextInputType.number,

                                    controller: secondDialController,
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
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad, right: PadValues.lessPad),

                                  child: TextField(
                                    controller: secondNameController,
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.grey.shade900
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                      fillColor: Colors.grey.shade300,
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
                              IconButton(onPressed: (){
                                getContact(1);
                              },
                                  iconSize: 30,
                                  icon: Image(image: AssetImage("assets/TelephoneIcon.png"),)),

                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("Ring for (Sec)", style: TextStyle(color: Colors.green)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: PadValues.mainPad),

                            child: Container(
                              width: 80,
                              child: TextField(
                                keyboardType: TextInputType.number,
                                style: TextStyle(fontSize: 12,
                                    color: Colors.grey.shade900
                                ),
                                decoration: InputDecoration(
                                          filled: true,
                                          contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                          fillColor: Colors.grey.shade300,
                                  hintText: "20",
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
                                controller: secondRingController,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("3rd Number to be dialled:",style: TextStyle(color: Colors.green)),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad, right: PadValues.lessPad),

                                  child: TextField(
                                    keyboardType: TextInputType.number,

                                    controller: thirdDialController,
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
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad,right: PadValues.lessPad),

                                  child: TextField(
                                    controller: thirdNameController,
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.grey.shade900
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad,),
                                      fillColor: Colors.grey.shade300,
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
                              IconButton(onPressed: (){
                                getContact(2);
                              },
                                  iconSize: 30,
                                  icon: Image(image: AssetImage("assets/TelephoneIcon.png"),)),

                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("Ring for (Sec)",style: TextStyle(color: Colors.green)),
                          ),
                          Container(
                            width: 80,
                            child: TextField(
                              controller: thirdRingController,
                              keyboardType: TextInputType.number,

                              style: TextStyle(fontSize: 12,
                                  color: Colors.grey.shade900
                              ),
                              decoration: InputDecoration(
                                        filled: true,
                                        contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                        fillColor: Colors.grey.shade300,
                                hintText: "20",
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
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                    margin: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(onPressed: (){

                                      UpdateButtons();

                                    }, child: Text("UPDATE BUTTON PHONE NUMBERS", ), )),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                    margin: EdgeInsets.all(PadValues.mainPad),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(onPressed: (){
                                      deletNumbers(snapshot.data);
                                    }, child: Text("DELETE NUMBERS FROM BUTTONS", ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red
                                    ),)),
                              ),
                            ],
                          ),


                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            if (snapshot.hasError){
              return Text("error");
            }
            if(snapshot.connectionState == ConnectionState.done){

              PopulateFields(snapshot.data);

              return Scaffold(
                body: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    appHeadWithBack("Telephone Numbers", context, true,),
                    Padding(
                      padding: EdgeInsets.only(left: PadValues.mainPad, right: PadValues.mainPad),
                      child: Column(mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Row(mainAxisAlignment: MainAxisAlignment.start,

                                children: [
                                  Image(image: AssetImage("assets/Panel.png"),
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
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("Call Button:", style: TextStyle(color: Colors.red),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Container(
                              width: 135,
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
                                      value: selectedButton,
                                      hint: Text("Select Type",),
                                      onChanged: (String? newValue) {

                                        setState(() {
                                          counter = 0;
                                          counter1 = 0;
                                          selectedButton = newValue!;
                                        });
                                      },

                                      items: val.map<DropdownMenuItem<String>>((String valu) {
                                        return DropdownMenuItem<String>(

                                          value: valu,
                                          child: Text(valu, style: TextStyle(color: Colors.green)),
                                        );
                                      }
                                      ).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("1st Number to be dialled:",style: TextStyle(color: Colors.green)),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad,right: PadValues.lessPad),

                                  child: TextField(
                                    keyboardType: TextInputType.number,

                                    controller: firstDialController,
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
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad,right: PadValues.lessPad),

                                  child: TextField(

                                    controller: firstNameController,
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.grey.shade900
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                      fillColor: Colors.grey.shade300,
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
                              IconButton(onPressed: (){
                                getContact(0);
                              },
                                  iconSize: 30,
                                  icon: Image(image: AssetImage("assets/TelephoneIcon.png"),)),

                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("Ring for (Sec)", style: TextStyle(color: Colors.green)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: PadValues.mainPad),
                            child: Container(
                              width: 80,
                              child: TextField(
                                keyboardType: TextInputType.number,

                                style: TextStyle(fontSize: 12,
                                    color: Colors.grey.shade900
                                ),
                                controller: firstRingController,
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                  fillColor: Colors.grey.shade300,
                                  hintText: "20",
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
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("2nd Number to be dialled:", style: TextStyle(color: Colors.green)),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad,right: PadValues.lessPad),

                                  child: TextField(
                                    keyboardType: TextInputType.number,

                                    controller: secondDialController,
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
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad, right: PadValues.lessPad),

                                  child: TextField(
                                    controller: secondNameController,
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.grey.shade900
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                      fillColor: Colors.grey.shade300,
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
                              IconButton(onPressed: (){
                                getContact(1);
                              },
                                  iconSize: 30,
                                  icon: Image(image: AssetImage("assets/TelephoneIcon.png"),)),

                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("Ring for (Sec)", style: TextStyle(color: Colors.green)),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: PadValues.mainPad),
                            child: Container(
                              width: 80,
                              child: TextField(
                                keyboardType: TextInputType.number,

                                style: TextStyle(fontSize: 12,
                                    color: Colors.grey.shade900
                                ),
                                decoration: InputDecoration(
                                  filled: true,
                                  contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                  fillColor: Colors.grey.shade300,
                                  hintText: "20",
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
                                controller: secondRingController,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("3rd Number to be dialled:",style: TextStyle(color: Colors.green)),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad, right: PadValues.lessPad),

                                  child: TextField(
                                    keyboardType: TextInputType.number,

                                    controller: thirdDialController,
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
                                  padding: EdgeInsets.only(bottom: PadValues.mainPad,right: PadValues.lessPad),

                                  child: TextField(

                                    controller: thirdNameController,
                                    style: TextStyle(fontSize: 12,
                                        color: Colors.grey.shade900
                                    ),
                                    decoration: InputDecoration(
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad,),
                                      fillColor: Colors.grey.shade300,
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
                              IconButton(onPressed: (){
                                getContact(2);
                              },
                                  iconSize: 30,
                                  icon: Image(image: AssetImage("assets/TelephoneIcon.png"),)),

                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                            child: Text("Ring for (Sec)",style: TextStyle(color: Colors.green)),
                          ),
                          Container(
                            width: 80,
                            child: TextField(
                              keyboardType: TextInputType.number,

                              controller: thirdRingController,
                              style: TextStyle(fontSize: 12,
                                  color: Colors.grey.shade900
                              ),
                              decoration: InputDecoration(
                                filled: true,
                                contentPadding: EdgeInsets.symmetric(vertical: PadValues.lesserPad, horizontal: PadValues.mainPad),
                                fillColor: Colors.grey.shade300,
                                hintText: "20",
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
                          Row(
                            children: [
                              Flexible(
                                flex: 1,
                                child: Container(
                                    margin: EdgeInsets.only(top: PadValues.mainPad, bottom: PadValues.mainPad),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(onPressed: (){

                                      UpdateButtons();

                                    }, child: Text("UPDATE BUTTON PHONE NUMBERS", ), )),
                              ),
                              Flexible(
                                flex: 1,
                                child: Container(
                                    margin: EdgeInsets.all(PadValues.mainPad),
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: ElevatedButton(onPressed: (){
                                      deletNumbers(snapshot.data);
                                    },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red
                                      ),
                                      child: Text("DELETE NUMBERS FROM BUTTONS", ), )),
                              ),
                            ],
                          ),


                        ],
                      ),
                    )
                  ],
                ),
              );

            }
            return Container(
                color:Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Center(child: CircularProgressIndicator()));
          });
  }

  void UpdateButtons() async {

    if ((firstDialController.text.isNotEmpty) && int.parse(firstRingController.text)>0)
    {
      print("firstIF");
      String strAux = "";
      int option = 0;
      if ((secondDialController.text.isEmpty) && (thirdDialController.text.isNotEmpty))
      {
        Prevalent.showDialogue(context, "Blank numbers in the dialling sequence are not allowed");
      }
      else if ((secondDialController.text.isEmpty) && (thirdDialController.text.isEmpty))
      {
        print("SecondIf");
        option = 1;
        strAux = device.serial! + " button " + selectedButton + " dial " + firstDialController.text + " ring " + firstRingController.text;
      }
      else if ((secondDialController.text.isNotEmpty) && (int.parse(secondRingController.text) < 1))
      {
        Prevalent.showDialogue(context, "Num of rings is mandatory");
      }
      else if ((secondDialController.text.isNotEmpty) && (thirdDialController.text.isEmpty) && (int.parse(secondRingController.text) > 0))
      {
        option = 2;
        strAux = device.serial! + " button " + selectedButton + " dial " + firstDialController.text + " ring "
          + firstRingController.text;
        strAux = strAux + " dial " + secondDialController.text + " ring " + secondRingController.text;
      }
      else if ((secondDialController.text.isNotEmpty) && (thirdDialController.text.isNotEmpty && (int.parse(thirdRingController.text) < 1)))
      {
        Prevalent.showDialogue(context, "Num of rings is mandatory");

      }
      else if ((secondDialController.text.length > 0) && (thirdDialController.text.length > 0) && (int.parse(thirdRingController.text) > 0))
      {
        option = 3;
        strAux = device.serial! + " button " + selectedButton + " dial " + firstDialController.text + " ring " + firstRingController.text;
        strAux = strAux + " dial " + secondDialController.text + " ring " + secondRingController.text;
        strAux = strAux + " dial " + thirdDialController.text + " ring " + thirdRingController.text;
      }

      print(option);
      print(strAux);
      if (strAux.length > 5)
      {
        await db.open("mockup_dp");
        _sendSMS(strAux, [device.phone!]);
     // SmsAne.getInstance().openSMS(device.phone, strAux); //Send a SMS with the command to the device's number

        if (option == 1)
        {
          if(currentCallButton == null) {
            print("inset");
            db.insertCallButtons(CallButtons(
                device.deviceId!,
                selectedButton,
                firstNameController.text,
                firstDialController.text,
                firstRingController.text,
                "",
                "",
                "20",
                "",
                "",
                "20"));
          }
          else{
            print("update");
            db.updateCallButtons(CallButtons(
                device.deviceId!,
                selectedButton,
                firstNameController.text,
                firstDialController.text,
                firstRingController.text,
                "",
                "",
                "20",
                "",
                "",
                "20"));
          }
        }
        else if (option == 2) {
          if (currentCallButton == null) {
            db.insertCallButtons(CallButtons(
              device.deviceId!,
              selectedButton,
              firstNameController.text,
              firstDialController.text,
              firstRingController.text,
              secondNameController.text,
              secondDialController.text,
              secondRingController.text,
              "",
              "",
              "20",));
          }
          else {
            db.updateCallButtons(CallButtons(
              device.deviceId!,
              selectedButton,
              firstNameController.text,
              firstDialController.text,
              firstRingController.text,
              secondNameController.text,
              secondDialController.text,
              secondRingController.text,
              "",
              "",
              "20",));
          }
        }
        else if (option == 3)
        {
          if (currentCallButton == null) {
            db.insertCallButtons(CallButtons(
                device.deviceId!,
                selectedButton,
                firstNameController.text,
                firstDialController.text,
                firstRingController.text,
                secondNameController.text,
                secondDialController.text,
                secondRingController.text,
                thirdNameController.text,
                thirdDialController.text,
                thirdRingController.text));
          }
          else{
            db.updateCallButtons(CallButtons(
                device.deviceId!,
                selectedButton,
                firstNameController.text,
                firstDialController.text,
                firstRingController.text,
                secondNameController.text,
                secondDialController.text,
                secondRingController.text,
                thirdNameController.text,
                thirdDialController.text,
                thirdRingController.text));
          }
        }
      }
    }
    else
    {
      if (firstDialController.text.length < 1)
        Prevalent.showDialogue(context, "First dial number is mandatory");
      else if (int.parse(firstRingController.text) < 1)
      Prevalent.showDialogue(context, "Num of rings is mandatory");
    }
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents,sendDirect: false)
        .catchError((onError) {
      print("Sms error: "+onError.toString());
    });
    print(_result);
  }

  Future<CallButtons?> getCallButton(String selectedButton, Device device) async {
    await db.open("mockup_dp");
    List<CallButtons>? callButtons = [];
    callButtons =await db.getCallButtons(device.deviceId!);
    for(var button in callButtons!){
      print("button:" + button.toString());
      if (button.buttonId == selectedButton){
        currentCallButton = button;
        return button;
      }
      else{
        button = CallButtons.a();
        currentCallButton = button;
      }
    }
    return null;

  }

  void PopulateFields(CallButtons? data) {
    print(counter1);
    if(counter1 == 0 ) {
    firstNameController.text = data!.firstName;
    secondNameController.text = data!.secondName;
    thirdNameController.text = data!.thirdName;
    firstDialController.text = data!.firstDial;
    secondDialController.text = data!.secondDial;
    thirdDialController.text = data!.thirdDial;
    firstRingController.text = data!.firstRing;
    secondRingController.text = data!.secondRing;
    thirdRingController.text = data!.thirdRing;
    counter1++;

}
  }

  void deletNumbers(CallButtons? data) {
    counter = 0;
    db.deleteCallButtons(device.deviceId!, data!.buttonId).then((value){
      emptyFields();
      Prevalent.showDialogue(context, "Button Deleted");
    });
  }

  Future<void> getContact(index) async {
    var status = await Permission.contacts.status;
    if(status.isGranted) {
      final contact = await FlutterContacts.openExternalPick();

        if (index == 0) {
          print(index);

            firstDialController.text = contact!.phones[0].number;
            firstNameController.text = contact!.name.first;

        }
        if (index == 1) {
          print(index);

          secondDialController.text = contact!.phones[0].number;
          secondNameController.text = contact!.name.first;
        }
        if (index == 2) {
          print(index);

          thirdDialController.text = contact!.phones[0].number;
          thirdNameController.text = contact!.name.first;
        }
    }
    else{
      Prevalent.showDialogue(context, "You need Permission to Access Contacts");
    }

  }

  void emptyFields() {
    if(counter ==0) {
      firstNameController.text = "";
      secondNameController.text = "";
      thirdNameController.text = "";
      firstDialController.text = "";
      secondDialController.text = "";
      thirdDialController.text = "";
      firstRingController.text = "";
      secondRingController.text = "";
      thirdRingController.text = "";
      counter++;
    }
  }


}


