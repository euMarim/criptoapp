
import 'package:flutter/material.dart';
import 'package:cryptoapp/app/app.dart';
import 'package:cryptoapp/app/di_container.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  setupLocator();

  runApp(const MyApp());
}