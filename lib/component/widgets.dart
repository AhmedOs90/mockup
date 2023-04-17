

import 'package:flutter/material.dart';
import 'package:mockup/models/Authorized.dart';

import '../models/Device.dart';
import '../models/PinCodes.dart';
import '../pages/info.dart';
import '../prevalent/Prevalent.dart';
import '../values.dart';

labeledFieldCardEditable({context, label, field, hint, edit,
  controller, inputType,bool? icon, TextInputType? keyboard}) {
  icon == null? icon = false: icon = icon;
  keyboard == null? keyboard = TextInputType.text: keyboard = keyboard;
  return Container(
    // constraints: const BoxConstraints(
    //     minWidth: 500
    // ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                    top: PadValues.mainPad),
                child: Text(label, style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.green
                ),),
              ),
            ),
            icon!?IconButton(onPressed: (){
              Prevalent.showSerialDialogue(context);

            }, icon: Icon(Icons.info_outline,
              size: 25,
            color: Colors.green,)
            ):Container(),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(
              bottom: PadValues.doubleExtraPad),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 40,
                color: Colors.grey.shade300,
              ),
              TextField(

                style: TextStyle(fontSize: 12,
                    color: Colors.grey.shade700
                ),
                controller: controller,
                decoration: InputDecoration(
                  hintText: hint,
                  fillColor: Colors.grey,
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                readOnly: edit,
                keyboardType: keyboard,

                inputFormatters:[ inputType ],),
            ],
          ),
        ),

      ],

    ),
  );
}

DeviceCard({required Device device, required action,Device? selected}
){
  bool select = false;
  if(selected != null){
    if(selected.deviceId == device.deviceId)
      {
        select = true;
      }
  }
  return Padding(
    padding: EdgeInsets.only(left: PadValues.mainPad, right:PadValues.mainPad, top: PadValues.lesserPad, bottom: PadValues.lesserPad ),
    child: InkWell(
      onTap: action,
      child: Card(
        color:select? Colors.grey.shade300:Colors.white,
        child: Row(
          children: [
            Image(
                height: 100,
                width: 100,
                image: AssetImage("assets/Panel.png")
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(device.name!, style: TextStyle(color: Colors.green),),
                Text("Phone: "+device.phone!),
                Text("NS: "+device.serial!),
              ],
            )
          ],
        ),
      ),
    ),
  );

}

PinCodesCard({required PinCodes pin, required action,PinCodes? selected}
    ){
  bool select = false;
  if(selected != null){
    if(selected.pinCode == pin.pinCode)
    {
      select = true;
    }
  }
  return Padding(
    padding: EdgeInsets.only(left: PadValues.mainPad, right:PadValues.mainPad, top: PadValues.lesserPad, bottom: PadValues.lesserPad ),
    child: InkWell(
      onTap: action,
      child: Card(
        color:select? Colors.grey.shade300:Colors.white,
        child: Row(
          children: [
            Image(
                height: 80,
                width: 100,
                image: AssetImage("assets/Panel.png")
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("PIN Code: " + pin.pinCode!, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                Text(Prevalent.relay1+": "+pin.firstRelay1!),
                Text(Prevalent.relay2+": "+pin.secondRelay2!),
                Text(Prevalent.relay3+": "+pin.thirdRelay3!),

              ],
            )
          ],
        ),
      ),
    ),
  );

}

AuthCard({required Authorized auth, required action,Authorized? selected}
    ){
  List<String> choices = ["Authorize Only",
    "Reject call & trigger relays",
    "Answer (delay) or trigger relays",
    "Delete authorised number"];
  bool select = false;
  if(selected != null){
    if(selected.phone == auth.phone)
    {
      select = true;
    }
  }
  return Padding(
    padding: EdgeInsets.only(left: PadValues.mainPad, right:PadValues.mainPad, top: PadValues.lesserPad, bottom: PadValues.lesserPad ),
    child: InkWell(
      onTap: action,
      child: Card(
        color:select? Colors.grey.shade300:Colors.white,
        child: Padding(
          padding: EdgeInsets.all(PadValues.doubleExtraPad),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image(
                    height: 70,
                    width: 70,
                    image: AssetImage("assets/incomingcalls.png")
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Telephone: " + auth.phone!, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(child: Text("name: "+ auth.name!)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Expanded(child: Text(choices[int.parse(auth.mode!) - 1 ])),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );

}
labeledFieldCard(BuildContext context, label, field) {
  return Container(
    constraints: const BoxConstraints(
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: PadValues.mainPad,
              right: PadValues.mainPad,
              bottom: PadValues.lessPad,
              top: PadValues.mainPad),
          child: Text(label, style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green
          ),),
        ),
        Padding(
          padding: EdgeInsets.only(left: PadValues.doubleExtraPad,
              right: PadValues.extraPad,
              bottom: PadValues.mainPad),
          child: Text(field, style: TextStyle(
              color: Colors.green
          )),
        ),
        Padding(
          padding: EdgeInsets.only(left: PadValues.mainPad,
              right: PadValues.mainPad,
              bottom: PadValues.mainPad),
          child: Container(
            height: 1,
            decoration: const BoxDecoration(
                color: Colors.white
            ),

          ),
        )
      ],
    ),
  );
}

labeledSpinner(context, label, field, List<String> val ,action) {

  return Container(

    child: Padding(
      padding: EdgeInsets.all(PadValues.lesserPad),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [

          Container(
            child: Padding(
              padding: EdgeInsets.only(left: PadValues.mainPad,
                  right: PadValues.mainPad,
                  bottom: PadValues.lessPad,
                  top: PadValues.mainPad),
              child: Text(label, style: TextStyle(
                  fontSize: 16,
                  color: Colors.green
              ),),
            ),
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
                      action();
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
        ],
      ),
    ),
  );
}

appHeadWithBack(String title, BuildContext context, bool leading)
{
  return Container(
    height: 80,
    width: MediaQuery.of(context).size.width,
    decoration: BoxDecoration(
      color: Colors.green,
    ),
    child: Padding(
      padding: const EdgeInsets.only(top: 28),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          leading?InkWell(
            onTap: () {
              Navigator.of(context).maybePop();
              // do something when the button is pressed
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Image(
                height: 45,
                width: 45,
                image: AssetImage("assets/backIcon.png")
                ,),
            ),
          ):Container(
            height: 50,
            width: 50,
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(top:8.0, bottom: 8, left: 12, right: 12),
              child: Row( mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(title,style: TextStyle(color: Colors.white, fontSize: 16),),
                ],
              ),
            ),
            margin: EdgeInsets.only(top: 10),),
          InkWell(
            onTap: () {
            Navigator.push(context, MaterialPageRoute(builder:
            (context) => Info()));
            // do something when the button is pressed
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image(
                    height: 45,
                      width: 45,
                      image: AssetImage("assets/InfoIcon.png")
,),
            ),
          )



        ],
      ),
    ),
  );
}




