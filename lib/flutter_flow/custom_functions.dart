import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/enums/enums.dart';
import '/auth/firebase_auth/auth_util.dart';

int? divideby(int? number) {
  // divide a int by 50
  if (number == null) {
    return null; // Return null if the input is null
  }
  return (number ~/ 50); // Divide the number by 50 using integer division
}

DateTime? dateplus3() {
  return DateTime.now()
      .add(Duration(days: 3)); // Add 3 days to the current date
}

DateTime? dateplus4() {
  // current date + 4 days
  return DateTime.now()
      .add(Duration(days: 4)); // Add 4 days to the current date
}

DateTime? currentdatelessone() {
  // current date less one day
  return DateTime.now()
      .subtract(Duration(days: 1)); // Subtract 1 day from the current date
}

DateTime? currentdayplus1() {
  // current date plus one
  return DateTime.now().add(Duration(days: 1)); // Add 1 day to the current date
}

DateTime? currentdateplus2() {
  return DateTime.now()
      .add(Duration(days: 2)); // Add 2 days to the current date
}

DateTime? dateplus6() {
  return DateTime.now()
      .add(Duration(days: 6)); // Add 6 days to the current date
}

DateTime? dateplus7() {
  // current date plus 7
  return DateTime.now()
      .add(Duration(days: 7)); // Add 7 days to the current date
}

DateTime? dateplus5() {
  return DateTime.now()
      .add(Duration(days: 5)); // Add 5 days to the current date
}
