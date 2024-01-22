import 'package:flutter/material.dart';
import 'package:src/env.dart';
import 'main.dart';

void main() {
  AppEnvironment.setupEnv(Environment.prod);
  runApp(const MyApp());
}

