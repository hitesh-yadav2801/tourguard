import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:toastification/toastification.dart';

class AppToasts {
  AppToasts._();

  static void simpleToast({required String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.grey.shade200,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }

  static void successToast({
    required BuildContext context,
    required String message,
    String? title,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      description: Text(message, overflow: TextOverflow.ellipsis, maxLines: 2),
      title: title != null ? Text(title) : null,
      alignment: Alignment.topCenter,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 4),
      showProgressBar: false,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  static void errorToast({
    required BuildContext context,
    required String message,
    String? title,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      description: Text(message, overflow: TextOverflow.ellipsis, maxLines: 2),
      title: title != null ? Text(title) : null,
      alignment: Alignment.topCenter,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 4),
      showProgressBar: false,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  static void warningToast({
    required BuildContext context,
    required String message,
    String? title,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      description: Text(message, overflow: TextOverflow.ellipsis, maxLines: 2),
      title: title != null ? Text(title) : null,
      alignment: Alignment.topCenter,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 4),
      showProgressBar: false,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }

  static void infoToast({
    required BuildContext context,
    required String message,
    String? title,
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      description: Text(message, overflow: TextOverflow.ellipsis, maxLines: 2),
      title: title != null ? Text(title) : null,
      alignment: Alignment.topCenter,
      style: ToastificationStyle.flatColored,
      autoCloseDuration: const Duration(seconds: 4),
      showProgressBar: false,
      margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
    );
  }
}
