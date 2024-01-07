import 'package:flutter/material.dart';

void showLoading({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return const SimpleDialog(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10),
              Text(
                'Aguarde ...',
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      );
    },
  );
}

void hideLoading({required BuildContext context}) {
  if (Navigator.canPop(context)) {
    Navigator.of(context).pop();
  }
}
