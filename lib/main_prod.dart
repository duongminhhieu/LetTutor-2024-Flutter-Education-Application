import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:src/env.dart';
import 'firebase_options.dart';
import 'main.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  PlatformDispatcher.instance.onError= (error, stack){
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };


  AppEnvironment.setupEnv(Environment.prod);
  runApp(const MyApp());
}

