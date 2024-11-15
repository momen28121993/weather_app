import 'package:flutter/material.dart';

import '../constant/app_color.dart';

void showCustomDialog(BuildContext context , String title , String content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
               Text(title, style: TextStyle(fontSize: 20 , color: AppColor.red)),
              const SizedBox(height: 10),
               Text(content , textAlign: TextAlign.center,),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: const Text("Close"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}
