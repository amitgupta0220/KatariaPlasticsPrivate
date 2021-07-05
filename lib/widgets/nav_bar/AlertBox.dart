import 'package:flutter/material.dart';

showAlertDialogCustom(BuildContext context) {
  Widget continueButton = FlatButton(
    child: Text("Ok"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(
      "Attention",
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Your account approval is pending. Once approved you will be able to Bid."),
        SizedBox(
          height: 20,
        ),
        Text(
            "आपका खाता अनुमोदन के लिए लंबित हैं। स्वीकृति मिलते ही आप बोली लगा सकेंगे।"),
      ],
    ),
    actions: [
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
