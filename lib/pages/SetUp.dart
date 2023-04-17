import 'package:flutter/material.dart';
import 'package:mockup/database/DatabaseProvider.dart';
import 'package:mockup/pages/AuthorizedCalls.dart';
import 'package:mockup/pages/TelephoneNumbers.dart';
import 'package:mockup/pages/changePins.dart';

import '../component/widgets.dart';
import '../models/Device.dart';
import '../models/Relays.dart';
import '../prevalent/Prevalent.dart';
import '../values.dart';
import 'RenameRelays.dart';
import 'info.dart';

class SetUp extends StatefulWidget {
  Device device;


  SetUp(this.device);

  @override
  State<SetUp> createState() => _SetUpState(device);
}

class _SetUpState extends State<SetUp> {

Device device;
DataBaseProvider db = DataBaseProvider();
late Future<List<Relays>?> relaysList = Prevalent.getRelaysFromDb(device);
_SetUpState(this.device);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: relaysList,
        builder: (BuildContext context, snapshot){
          if(snapshot.connectionState == ConnectionState.done){
            Prevalent.relay1 = snapshot.data![0].name;
            Prevalent.relay2 = snapshot.data![1].name;
            Prevalent.relay3 = snapshot.data![2].name;
          }
          return Scaffold(

            body: Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  appHeadWithBack("Set Up", context, true,),
                  Column(mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Padding(
                        padding: EdgeInsets.all(PadValues.mainPad),
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
                        padding: EdgeInsets.all(PadValues.mainPad),
                        child: Container(
                          height: 2,
                          color: Colors.greenAccent,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(PadValues.mainPad),
                        child: InkWell(
                          onTap: (){ Navigator.push(context, MaterialPageRoute(builder:
                              (context) => TeleNumber(device)));},
                          child: Ink.image(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              image: AssetImage("assets/ChangeTelephoneNumbers.png"),
                              fit: BoxFit.fitWidth),

                        ),
                      ),
                      Padding(
                        padding:  EdgeInsets.all(PadValues.mainPad),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) => ChangePins(device)));
                          },
                          child: Ink.image(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              image: AssetImage("assets/ChangePinsButton.png"),
                              fit: BoxFit.fitWidth),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(PadValues.mainPad),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) => AuthorizedCalls(device)));
                          },
                          child: Ink.image(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              image: AssetImage("assets/AuthorisedIncomingCalls.png"),
                              fit: BoxFit.fitWidth),

                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(PadValues.mainPad),
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder:
                                (context) => RenameRelay(device)));
                          },
                          child: Ink.image(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              image: AssetImage("assets/RenameRelays.png"),
                              fit: BoxFit.fitWidth),

                        ),
                      )

                    ],
                  )
                ],
              ),
            ),
          );
        });
  }



}
