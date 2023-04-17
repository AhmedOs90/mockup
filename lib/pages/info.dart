import 'package:flutter/material.dart';
import 'package:mockup/values.dart';

import '../component/widgets.dart';

class Info extends StatelessWidget {
  const Info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          appHeadWithBack("Info", context, true,),
          Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(PadValues.lesserPad),
                  child: Container(
                    height: 150,
                    width: 150,
                    color: Colors.green,
                  ),
                ),
                Expanded(
                  child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(PadValues.lessPad),
                        child: Text("Version: 1.1.1", style: TextStyle(color: Colors.grey),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(PadValues.lessPad),
                        child: Text("www.............com",  style: TextStyle(color: Colors.grey),),
                      ),
                      Padding(
                        padding: EdgeInsets.all(PadValues.lessPad),
                        child: Text("Privacy Policy",  style: TextStyle(color: Colors.grey),),
                      )
                    ],

                  ),
                )
              ],
            ),
            labeledFieldCard(context, "Change Telephone Numbers", "this menu allows you to do alot of things thats; why I am wrtiting anything now thank you for your attention whore"),
            labeledFieldCard(context, "Change Telephone Numbers", "this menu allows you to do alot of things thats; why I am wrtiting anything now thank you for your attention whore"),
            labeledFieldCard(context, "Change Telephone Numbers", "this menu allows you to do alot of things thats; why I am wrtiting anything now thank you for your attention whore"),
            labeledFieldCard(context, "Change Telephone Numbers", "this menu allows you to do alot of things thats; why I am wrtiting anything now thank you for your attention whore"),
          ],
        )
    ]
      ),
    );
  }
}
