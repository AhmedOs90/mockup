import 'package:flutter/material.dart';


class mockAppBar extends StatelessWidget {
  String? title;
  IconData? icon;

  mockAppBar({required this.title,required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      height: MediaQuery.of(context).size.height*.05,
      child: Row(
        children: [
          Container(
            width: 30,
          ),
          Text(title!),
          InkWell(
            onTap: (){},
            child: Icon(icon),
          )

        ]

      ),
    );
  }
}
