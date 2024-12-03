import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:lottie/lottie.dart';
import 'package:quickalert/quickalert.dart';

import '../themes/color.dart';

void loadingDialog(
    {required BuildContext context,
    required Size mediaQuery,
    String title = ''}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(
            color: AppColors.primaryColor,
            size: mediaQuery.width / 8,
          ),
          SizedBox(
            height: mediaQuery.height / 90,
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}

void internetToast({
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("No internet connection"), // Replaced localized string
  ));
}

void serverToast({
  required BuildContext context,
}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text("Server is down"), // Replaced localized string
  ));
}

void internetDialog({required BuildContext context, required Size mediaQuery}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white70,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15.0),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/lottie/no_internet.json',
            fit: BoxFit.contain,
            width: mediaQuery.width / 5,
            height: mediaQuery.height / 5,
          ),
          Text(
            "No internet connection detected.", // Replaced localized string
            softWrap: true,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    ),
  );
}

void errorDialog({
  required BuildContext context,
  required String text,
}) {
  const textStyle =
      TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600);
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: AppColors.dark,
      title: Text(
        "Error",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ), // Replaced localized string
      content: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(
              AppColors.primaryColor.withOpacity(0.1),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Cancel", style: textStyle), // Replaced localized string
        ),
      ],
    ),
  );
}

void infoDialog(
    {required BuildContext context,
    required String text,
    required void Function()? onConfirmBtnTap}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.info,
    title: "Info", // Replaced localized string
    text: text,
    confirmBtnColor: Colors.amber.shade400,
    confirmBtnText: "Cancel", // Replaced localized string
    onConfirmBtnTap: onConfirmBtnTap,
  );
}

void successDialog({
  required BuildContext context,
  required String text,
}) {
  QuickAlert.show(
    context: context,
    type: QuickAlertType.success,
    title: "Info", // Replaced localized string
    text: text,
    confirmBtnColor: Colors.green,
    confirmBtnText: "Cancel", // Replaced localized string
  );
}
