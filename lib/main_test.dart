import 'package:flutter/material.dart';
import 'package:src/env.dart';
import 'main.dart';

void main() {
  AppEnvironment.setupEnv(Environment.test);
  runApp(const MyApp());
}

